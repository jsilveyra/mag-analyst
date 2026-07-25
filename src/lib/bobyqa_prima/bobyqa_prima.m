function [x, f, exitflag, nf] = bobyqa_prima(fun, x0, lb, ub, options)
%BOBYQA_PRIMA  Bound-constrained derivative-free trust-region minimisation
%   (BOBYQA-family) with no MEX/compiler and no paid toolbox dependency.
%
%   [X, F, EXITFLAG, NF] = BOBYQA_PRIMA(FUN, X0, LB, UB) minimises the scalar
%   function FUN(X) subject to LB <= X <= UB (either bound may be empty/-Inf/+Inf
%   for an unconstrained direction), starting from X0, without requiring
%   derivatives. FUN is evaluated at boundary-respecting points only.
%
%   [...] = BOBYQA_PRIMA(FUN, X0, LB, UB, OPTIONS) accepts a struct with fields:
%     rhobeg  - initial trust-region radius (default 0.1)
%     rhoend  - final trust-region radius / convergence tolerance (default 1e-6)
%     maxfun  - maximum number of function evaluations (default 400*(n+1))
%     npt     - number of interpolation points, n+2 <= npt <= (n+1)(n+2)/2
%               (default min((n+1)(n+2)/2, 2n+1); the full-quadratic value,
%               (n+1)(n+2)/2, gave the best accuracy/efficiency in benchmarking
%               against classic BOBYQA and Nelder-Mead for n<=11 - see below)
%
%   METHOD
%   Each iteration builds a local quadratic interpolation model of FUN over NPT
%   points and takes an (exact) box-constrained trust-region step, following the
%   BOBYQA algorithm of M.J.D. Powell (2009) [1]. The quadratic model's free
%   parameters are updated INCREMENTALLY (not rebuilt from scratch) using PRIMA's
%   [2] modernised pure-MATLAB port of Powell's least-Frobenius-norm update
%   (Powell 2004), reused here (BSD-3) via the private/ helpers vlagbeta.m,
%   updateh.m, updateq.m, setdrop_tr.m, shiftbase.m, tryqalt.m, trrad.m. Unlike
%   PRIMA's own trsapp (approximate truncated-CG) and geostep (approximate
%   Cauchy+line search), this implementation solves BOTH the trust-region step
%   and the geometry-improving step EXACTLY via an active-set/secular-equation
%   solver over the box-intersect-ball feasible region (trsbox.m) - benchmarked
%   to match or exceed the accuracy of the approximate steps for n<=11 at no
%   extra function-evaluation cost.
%
%   The interpolation state (BMAT/ZMAT/model) is seeded generically from an
%   arbitrary bound-feasible point set (seed_prima_from_points.m, via a direct
%   KKT solve, verified to 1e-13 against an independent reference), which
%   decouples initialisation from NEWUOA's hardwired +/-rhobeg geometry so that
%   starting points near a bound are handled correctly.
%
%   REFERENCES
%   [1] M.J.D. Powell, "The BOBYQA algorithm for bound constrained optimization
%       without derivatives," Report DAMTP 2009/NA06, Centre for Mathematical
%       Sciences, University of Cambridge, August 2009. (Technical report; no
%       DOI. Available from the author's original distribution channel.)
%   [2] Z. Zhang et al., PRIMA: "Reference Implementation for Powell's methods
%       with Modernization and Amelioration", https://github.com/libprima/prima
%       (BSD-3-Clause). The pure-MATLAB NEWUOA update machinery in private/ is
%       reused from this project (see NOTICE / license.txt for full attribution).
%
%   See also: OPTIMIZER_EVALUATION.md and V2_NOTES.md for the full derivation,
%   verification, and benchmark comparison against classic BOBYQA, Nelder-Mead
%   (the fminsearch-based MINIMIZE), and Py-BOBYQA (Cartis et al. 2019,
%   DOI 10.1145/3338517), from which this solver was selected as the accuracy
%   and efficiency leader for n<=4, tied on accuracy at n=5.
    if nargin < 5, options = struct(); end
    x0 = x0(:); n = numel(x0);
    if isempty(lb), lb = -inf(n,1); end
    if isempty(ub), ub = +inf(n,1); end
    lb = lb(:); ub = ub(:);
    if isscalar(lb), lb = lb*ones(n,1); end
    if isscalar(ub), ub = ub*ones(n,1); end
    x0 = min(max(x0, lb), ub);

    % Per-variable scaling (match bqa/pybobyqa for a fair comparison).
    s = abs(x0); s(s < 1e-8) = 1;
    z0 = x0 ./ s; lbz = lb ./ s; ubz = ub ./ s;

    rhobeg = getopt(options, 'rhobeg', 0.1);
    rhoend = getopt(options, 'rhoend', 1e-6);
    maxfun = getopt(options, 'maxfun', 400*(n+1));
    nfull = (n+1)*(n+2)/2;
    npt = getopt(options, 'npt', min(nfull, 2*n+1));   % default 2n+1 (PRIMA default)
    npt = max(n+2, min(npt, nfull));

    fun_z = @(z) fun(z .* s);
    eta1 = 0.1; eta2 = 0.7; gamma1 = 0.5; gamma2 = 2.0;

    % ---------------- bound-feasible PRELIM ----------------
    [Y, fvals, nf] = prelim(fun_z, z0, lbz, ubz, rhobeg, npt);
    G.xbest = Y(:,1); G.fbest = Inf;
    for j = 1:npt, G = ubest(G, Y(:,j), fvals(j)); end

    % ---------------- seed PRIMA's incremental state ----------------
    [bmat, zmat, idz, gq, hq, pq, xbase, xpt, kopt] = seed_prima_from_points(Y, fvals);
    fval = fvals;

    rho = rhobeg; delta = rho;
    dnormsav = Inf(3,1); moderrsav = Inf(3,1);
    itest = 0;
    exitflag = 5;

    maxtr = 20*maxfun;
    for tr = 1:maxtr
        xopt = xpt(:, kopt); fopt = fval(kopt);
        Hfull = hq + xpt * (pq .* xpt');
        Hfull = 0.5*(Hfull + Hfull');
        gopt = gq + Hfull * xopt;

        cur = xbase + xopt;                 % current point (scaled coords)
        sl_d = lbz - cur; su_d = ubz - cur; % bounds on the step d
        d = trsbox(gopt, Hfull, delta, sl_d, su_d);
        crvmin = crvmin_proxy(Hfull, d, sl_d, su_d);
        dnorm = min(delta, norm(d));

        shortd = dnorm < 0.5*rho;
        reduce_rho_1 = shortd && (max(abs(moderrsav)) <= 0.125*crvmin*rho*rho) && (max(dnormsav) <= rho);
        if shortd && ~reduce_rho_1
            delta = 0.1*delta;
            if delta <= 1.5*rho, delta = rho; end
        end

        ratio = -1; knew = 0;
        if ~shortd
            % Shift base if xopt drifts far from xbase (PRIMA numerics).
            if dnorm*dnorm <= 1e-3 * norm(xopt)^2
                [bmat, gq, hq, xbase, xopt, xpt] = shiftbase(idz, pq, zmat, bmat, gq, hq, xbase, xopt, xpt, false);
                cur = xbase + xopt; sl_d = lbz - cur; su_d = ubz - cur;
            end

            [beta, vlag] = vlagbeta(idz, kopt, bmat, d, xpt, zmat, false);
            qred = calquad(d, gq, hq, pq, xopt, xpt, false);   % Q(xopt+d)-Q(xopt)

            xnew = xopt + d;                                    % feasible: trsbox kept d in [sl_d,su_d]
            xabs = max(lbz, min(ubz, xbase + xnew));            % clamp (roundoff only)
            f = fun_z(xabs); nf = nf + 1;
            G = ubest(G, xabs, f);

            dnormsav = [dnormsav(2:end); dnorm];
            moderr = f - fopt - qred;
            moderrsav = [moderrsav(2:end); moderr];

            if isnan(qred) || qred >= 0
                ratio = -1;                 % robust: treat as failed step (no hard break)
            else
                ratio = (f - fopt) / qred;
                delta = trrad(delta, dnorm, eta1, eta2, gamma1, gamma2, ratio);
                if delta <= 1.5*rho, delta = rho; end
            end

            if f < fopt, xopt = xnew; fopt = f; end
            if nf >= maxfun, break; end

            if isfinite(ratio) && ratio > -Inf && qred < 0
                knew = setdrop_tr(idz, kopt, beta, delta, ratio, rho, vlag(1:npt), xopt, xpt, zmat, false);
            end
            if knew > 0
                [idz, bmat, zmat] = updateh(knew, beta, vlag, idz, bmat, zmat, false);
                [gq, hq, pq] = updateq(idz, knew, bmat(:, knew), moderr, zmat, xpt(:, knew), gq, hq, pq, false);
                xpt(:, knew) = xnew; fval(knew) = f;
                if fval(knew) < fval(kopt), kopt = knew; end
                if delta <= rho
                    [itest, gq, hq, pq] = tryqalt(idz, fval - fopt, ratio, bmat(:, 1:npt), zmat, itest, gq, hq, pq, false);
                end
            end
        end

        % ---- improve_geo / reduce_rho decision (PRIMA structure) ----
        xdist = sqrt(sum((xpt - xopt).^2, 1))';
        bad_trstep = shortd || (ratio < 0.1) || (knew == 0);
        improve_geo = ~reduce_rho_1 && (max(xdist) > 2*delta) && bad_trstep;
        bad_trstep2 = shortd || (ratio <= 0) || (knew == 0);
        reduce_rho_2 = (max(xdist) <= 2*delta) && (max(delta, dnorm) <= rho) && bad_trstep2;

        if improve_geo
            [~, knew_geo] = max(xdist);
            delbar = max(min(0.1*max(xdist), 0.5*delta), rho);
            if delbar*delbar <= 1e-3 * norm(xopt)^2
                [bmat, gq, hq, xbase, xopt, xpt] = shiftbase(idz, pq, zmat, bmat, gq, hq, xbase, xopt, xpt, false);
            end
            cur = xbase + xopt; sl_d = lbz - cur; su_d = ubz - cur;

            d = box_geostep(knew_geo, bmat, zmat, idz, xpt, xopt, delbar, sl_d, su_d);
            [beta, vlag] = vlagbeta(idz, kopt, bmat, d, xpt, zmat, false);
            qred = calquad(d, gq, hq, pq, xopt, xpt, false);

            xnew = xopt + d;
            xabs = max(lbz, min(ubz, xbase + xnew));
            f = fun_z(xabs); nf = nf + 1;
            G = ubest(G, xabs, f);

            dnorm = min(delbar, norm(d));
            dnormsav = [dnormsav(2:end); dnorm];
            moderr = f - fopt - qred;
            moderrsav = [moderrsav(2:end); moderr];

            if f < fopt, xopt = xnew; fopt = f; end
            if nf >= maxfun, break; end

            [idz, bmat, zmat] = updateh(knew_geo, beta, vlag, idz, bmat, zmat, false);
            [gq, hq, pq] = updateq(idz, knew_geo, bmat(:, knew_geo), moderr, zmat, xpt(:, knew_geo), gq, hq, pq, false);
            xpt(:, knew_geo) = xnew; fval(knew_geo) = f;
            if fval(knew_geo) < fval(kopt), kopt = knew_geo; end
        end

        if reduce_rho_1 || reduce_rho_2
            if rho <= rhoend
                exitflag = 0; break;
            end
            delta = 0.5*rho;
            rr = rho/rhoend;
            if rr <= 16, rho = rhoend;
            elseif rr <= 250, rho = sqrt(rr)*rhoend;
            else, rho = 0.1*rho; end
            delta = max(delta, rho);
            dnormsav = Inf(3,1); moderrsav = Inf(3,1);
        end
        if nf >= maxfun, exitflag = 3; break; end
    end

    G = ubest(G, xbase + xpt(:,kopt), fval(kopt));
    x = G.xbest .* s;
    f = G.fbest;
end

% ======================================================================
function [Y, fvals, nf] = prelim(fun_z, z0, lbz, ubz, rhobeg, npt)
    n = numel(z0);
    sstep = zeros(n,1);
    for i = 1:n
        if z0(i)+rhobeg <= ubz(i), sstep(i) = rhobeg;
        elseif z0(i)-rhobeg >= lbz(i), sstep(i) = -rhobeg;
        else, sstep(i) = rhobeg; end
    end
    Y = zeros(n, npt); Y(:,1) = z0; k = 1;
    for i = 1:n
        if k >= npt, break; end
        k=k+1; Y(:,k)=z0; Y(i,k)=clampz(z0(i)+sstep(i), lbz(i), ubz(i));
    end
    for i = 1:n
        if k >= npt, break; end
        opp = z0(i)-sstep(i);
        if opp < lbz(i) || opp > ubz(i), opp = z0(i)+2*sstep(i); end
        k=k+1; Y(:,k)=z0; Y(i,k)=clampz(opp, lbz(i), ubz(i));
    end
    for i = 1:n
        for j = i+1:n
            if k >= npt, break; end
            k=k+1; Y(:,k)=z0;
            Y(i,k)=clampz(z0(i)+sstep(i), lbz(i), ubz(i));
            Y(j,k)=clampz(z0(j)+sstep(j), lbz(j), ubz(j));
        end
        if k >= npt, break; end
    end
    fvals = zeros(npt,1);
    for j = 1:npt, fvals(j) = fun_z(Y(:,j)); end
    nf = npt;
end

% ======================================================================
function d = box_geostep(knew, bmat, zmat, idz, xpt, xopt, delbar, sl_d, su_d)
    % Box-constrained geometry step: maximise |L_knew(xopt+d)| over
    % sl_d<=d<=su_d, ||d||<=delbar. L_knew has implicit Hessian hcol=zmat*zknew
    % and gradient-at-xopt = bmat(:,knew) + H_Lk*xopt.
    zknew = zmat(knew, :)';
    zknew(1:idz-1) = -zknew(1:idz-1);
    hcol = zmat * zknew;                       % npt-vector
    H_Lk = xpt * (hcol .* xpt');               % implicit Hessian
    H_Lk = 0.5*(H_Lk + H_Lk');
    g_Lk = bmat(:, knew) + H_Lk * xopt;        % gradient of L_k at xopt
    dp = trsbox(-g_Lk, -H_Lk, delbar, sl_d, su_d);   % maximise L
    dm = trsbox( g_Lk,  H_Lk, delbar, sl_d, su_d);   % minimise L
    Lp = g_Lk'*dp + 0.5*dp'*H_Lk*dp;
    Lm = g_Lk'*dm + 0.5*dm'*H_Lk*dm;
    if abs(Lp) >= abs(Lm), d = dp; else, d = dm; end
end

% ======================================================================
function cm = crvmin_proxy(H, d, sl, su)
    n = numel(d);
    free = true(n,1);
    for i = 1:n
        if (abs(d(i)-sl(i)) < 1e-12 && sl(i) ~= 0) || (abs(d(i)-su(i)) < 1e-12 && su(i) ~= 0)
            free(i) = false;
        end
    end
    if ~any(free), cm = 0; return; end
    Hf = H(free,free); ev = eig((Hf+Hf')/2);
    cm = min(ev); if cm < 0, cm = 0; end
end

function G = ubest(G, z, f)
    if isfinite(f) && f < G.fbest, G.fbest = f; G.xbest = z; end
end
function v = getopt(o, name, dflt)
    if isfield(o, name), v = o.(name); else, v = dflt; end
end
function y = clampz(x, lo, hi), y = min(max(x, lo), hi); end
