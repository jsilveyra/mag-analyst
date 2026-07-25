function d = trsbox(g, H, delta, sl, su)
%TRSBOX  Approximately minimise q(d)=g'd + 0.5 d'H d subject to sl<=d<=su and
%   ||d||<=delta, where sl<=0<=su. This is the box-constrained trust-region
%   subproblem at the heart of BOBYQA (Powell 2009).
%
%   Method (exploiting that n is small in this application): an active-set
%   loop. Variables not yet pinned to a box face form the "free" subspace, on
%   which the *ball-only* trust-region subproblem is solved EXACTLY via the
%   eigen/secular equation (indefinite- and hard-case-safe). If the exact free
%   step violates a box bound, the most-violated variable is pinned at that
%   bound and the loop repeats on the smaller free subspace with the ball
%   radius reduced by the pinned displacement. A light "release" check lets a
%   pinned variable become free again if the model gradient points inward,
%   which recovers the cases a pure adding scheme would leave suboptimal.
%   Terminates in at most ~2n passes; always returns a feasible d with q(d)<=0.
    n = numel(g);
    g = g(:); sl = sl(:); su = su(:);
    active = false(n, 1);        % pinned-at-a-box-face variables
    dval = zeros(n, 1);          % their fixed displacement values

    d = zeros(n, 1);
    best_d = d; best_q = 0;

    for pass = 1:(2*n + 4)
        free = ~active;
        if ~any(free)
            d = dval; break;
        end
        ra2 = delta^2 - sum(dval(active).^2);
        if ra2 <= 1e-18
            d = dval; d(free) = 0;
            break;
        end
        rf = sqrt(ra2);

        if any(active)
            gf = g(free) + H(free, active) * dval(active);
        else
            gf = g(free);           % empty active set: avoid 1x0 empty-product broadcast (breaks n=1)
        end
        Hf = H(free, free);
        df = exact_tr(gf, Hf, rf);

        d = zeros(n, 1);
        d(active) = dval(active);
        d(free) = df;

        % Track best feasible point seen (guard against any active-set churn).
        if all(d >= sl - 1e-9) && all(d <= su + 1e-9) && norm(d) <= delta + 1e-9
            qd = g' * d + 0.5 * d' * (H * d);
            if qd < best_q
                best_q = qd; best_d = max(sl, min(su, d));
            end
        end

        % Check box feasibility of the free components.
        viol = zeros(n, 1);
        viol(free) = max(sl(free) - d(free), d(free) - su(free));
        [mx, iw] = max(viol);

        if mx > 1e-10
            % Pin the most-violated free variable at the bound it crossed.
            active(iw) = true;
            if d(iw) > su(iw)
                dval(iw) = su(iw);
            else
                dval(iw) = sl(iw);
            end
        else
            % All free comps feasible. Try to release a wrongly-pinned variable:
            % gradient of q at d is gq = g + H d; a variable pinned at its upper
            % bound (dval>0) should be released if gq_i < 0 (model still
            % decreasing by increasing d_i is impossible past the bound, but if
            % gq_i points inward, i.e. gq_i>0 at an upper bound, it is correctly
            % active). Release when the multiplier sign is wrong.
            gq = g + H * d;
            released = false;
            act_idx = find(active);
            for t = 1:numel(act_idx)
                i = act_idx(t);
                if dval(i) >= su(i) - 1e-12 && gq(i) > 1e-10
                    active(i) = false; dval(i) = 0; released = true; break;
                elseif dval(i) <= sl(i) + 1e-12 && gq(i) < -1e-10
                    active(i) = false; dval(i) = 0; released = true; break;
                end
            end
            if ~released
                break;   % KKT-consistent active set found.
            end
        end
    end

    % Feasibility guard + keep the best feasible point encountered.
    d = max(sl, min(su, d));
    nd = norm(d);
    if nd > delta, d = d * (delta / nd); d = max(sl, min(su, d)); end
    qd = g' * d + 0.5 * d' * (H * d);
    if best_q < qd - 1e-14
        d = best_d;
    end
end

function d = exact_tr(g, H, delta)
%EXACT_TR  Exact minimiser of g'd+0.5 d'Hd s.t. ||d||<=delta (no box), for
%   symmetric H (possibly indefinite), via the secular equation on the
%   eigen-decomposition. Handles the hard case.
    g = g(:);
    n = numel(g);
    if n == 0, d = zeros(0,1); return; end
    Hs = (H + H') / 2;
    [V, D] = eig(Hs);
    lam = diag(D);
    ghat = V' * g;
    lmin = min(lam);

    % Interior Newton point, if H is (numerically) positive definite and it fits.
    if lmin > 1e-12
        d0 = V * (-ghat ./ lam);
        if norm(d0) <= delta
            d = d0; return;
        end
    end

    % Secular function phi(t) = ||(H+tI)^{-1} g|| - delta, root for t >= max(0,-lmin).
    tol = 1e-12;
    lo = max(0, -lmin) + 1e-12;
    % Hard case: g has no component along the least-eigenvalue subspace and the
    % boundary solution needs an eigenvector contribution.
    mask_min = abs(lam - lmin) <= 1e-9 * max(1, abs(lmin));
    if all(abs(ghat(mask_min)) <= 1e-12 * max(1, norm(ghat)))
        % Try t = max(0,-lmin): d = pseudo-inverse part + z*eigvec, ||d||=delta.
        t = lo;
        denom = lam + t;
        coef = zeros(n, 1);
        nz = abs(denom) > 1e-14;
        coef(nz) = -ghat(nz) ./ denom(nz);
        dperp = V * coef;
        rem = delta^2 - dperp' * dperp;
        if rem >= 0
            % add contribution along a least-eigenvalue eigenvector
            k = find(mask_min, 1);
            z = sqrt(rem);
            d = dperp + z * V(:, k);
            if norm(d) > delta, d = d * delta / norm(d); end
            return;
        end
    end

    phi = @(t) sqrt(sum((ghat ./ (lam + t)).^2)) - delta;
    hi = lo + 1;
    it = 0;
    while phi(hi) > 0
        hi = hi * 2; it = it + 1;
        if it > 200 || hi > 1e14, break; end
    end
    for it = 1:200
        mid = 0.5 * (lo + hi);
        if phi(mid) > 0, lo = mid; else, hi = mid; end
        if hi - lo <= tol * max(1, hi), break; end
    end
    t = 0.5 * (lo + hi);
    d = V * (-ghat ./ (lam + t));
    if norm(d) > delta, d = d * delta / norm(d); end
end
