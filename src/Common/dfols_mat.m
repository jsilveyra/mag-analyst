function [x, fval] = dfols_mat(resfun, x0, lb, ub, output_fcn)
%DFOLS_MAT  DFO-LS: derivative-free Gauss-Newton trust region on residuals.
%   [x, fval] = dfols_mat(resfun, x0, lb, ub, output_fcn) minimizes
%   F(x) = sqrt(mean(r(x).^2)), r = resfun(x) (a column; [] when the point
%   cannot be evaluated), subject to lb <= x <= ub. output_fcn (optional)
%   is called after every evaluation as stop = output_fcn(x, optimValues,
%   'iter') with optimValues.fval = F; returning true stops the solver, and
%   the best point evaluated so far is returned.
%
%   The method is DFO-LS, Algorithm 1 of C. Cartis, J. Fiala, B. Marteau and
%   L. Roberts, "Improving the flexibility and robustness of model-based
%   derivative-free optimization solvers", ACM Trans. Math. Softw. 45(3),
%   art. 32 (2019):
%     - a LINEAR model r(xk + s) ~ rk + J s of the whole residual vector,
%       interpolated at n+1 points (rather than a quadratic model of F);
%     - the Gauss-Newton step minimizing ||rk + J s||^2 inside the trust
%       region ||s|| <= Delta and the bounds;
%     - the trust-region update of their Eq. (2.13) (gamma_inc 2,
%       gamma_inc_bar 4, eta1 0.1, eta2 0.7); a lower radius rho reduced only
%       after an unsuccessful or too-short step when the sample set is well
%       poised; a safety phase for steps shorter than 0.5 rho;
%     - the model updated with every new point, the trust region centred at
%       the best point, and geometry improved by moving the sample point
%       farthest from it (their Section 3.1);
%     - their defaults for NOISY objectives (Section 3.1): gamma_dec 0.98,
%       alpha1 0.9, alpha2 0.95, i.e. slow radius reductions. The objectives
%       this is used for are computed through an adaptive ODE integration,
%       whose small irregular errors make the smooth defaults (0.5, 0.1,
%       0.5) shrink the radius too fast and stop early; with the noisy
%       defaults every LMAG 2026 benchmark fit matched or improved on
%       BOBYQA's (2026-09-25). Their restarts are not implemented.
%   Two practical additions: the step respects the bounds through a small
%   active-set loop (variables that would leave the box are fixed on it and
%   the rest re-solved), and a sample point that cannot be evaluated is
%   retried in the opposite direction and at half length.
%   Radii match SolverUtils' BOBYQA settings on seed-scaled variables:
%   rhobeg 0.1, rhoend 1e-4, at most 400(n+1) evaluations.

RHOBEG = 0.1; RHOEND = 1e-4; DELTA_MAX = 1e10;
G_DEC = 0.98; G_INC = 2; G_INC_BAR = 4; ETA1 = 0.1; ETA2 = 0.7;
A1 = 0.9; A2 = 0.95; G_S = 0.5; OMEGA_S = 0.1;

sz = size(x0);
x0 = min(max(x0(:), lb(:)), ub(:)); lb = lb(:); ub = ub(:);
n = numel(x0);
maxfun = 400 * (n + 1);
npt = n + 1;
nf = 0; stop = false;
best_x = x0; best_f = inf;

    function [r, f] = evalr(xx)
        r = []; f = inf;
        if stop || nf >= maxfun, return; end
        nf = nf + 1;
        r = resfun(reshape(xx, sz));
        if isempty(r) || any(~isfinite(r))
            r = []; f = inf;
        else
            r = r(:); f = sqrt(mean(r.^2));
        end
        if f < best_f, best_f = f; best_x = xx; end
        if ~isempty(output_fcn)
            stop = output_fcn(reshape(xx, sz), struct('fval', f, 'iteration', nf), 'iter');
        end
    end

    function [y, r, f] = eval_near(xc, d)
        % evaluate xc + d (projected into the box); on failure try -d, then
        % half lengths
        y = []; r = []; f = inf;
        for len = [1 0.5 0.25]
            for sgn = [1 -1]
                cand = min(max(xc + sgn * len * d, lb), ub);
                if norm(cand - xc) == 0, continue; end
                [r, f] = evalr(cand);
                if ~isempty(r), y = cand; return; end
                if stop || nf >= maxfun, return; end
            end
        end
    end

    function d = geometry_direction(D, radius)
        % the unit direction (among +-coordinates and the direction the
        % current displacements miss most) that maximizes the smallest
        % singular value of [D, radius*d], times radius
        cands = [eye(n), -eye(n)];
        if ~isempty(D)
            [Ud, ~, ~] = svd(D);                        % n x n: last column = least-covered direction
            cands = [cands, Ud(:, end), -Ud(:, end)];
        end
        best = -inf; d = cands(:, 1) * radius;
        for c = 1:size(cands, 2)
            sv = svd([D, radius * cands(:, c)]);
            if numel(sv) < min(n, size(D, 2) + 1), continue; end
            v = sv(end);
            if v > best, best = v; d = radius * cands(:, c); end
        end
    end

% ---- initial set: x0 and rhobeg along each coordinate --------------------
[r0, f0] = evalr(x0);
if isempty(r0)
    x = reshape(x0, sz); fval = inf; return;
end
X = x0; R = r0; Fv = f0;
for j = 1:n
    e = zeros(n, 1); e(j) = RHOBEG;
    if x0(j) + e(j) > ub(j), e(j) = -e(j); end
    [y, r, f] = eval_near(x0, e);
    if ~isempty(y)
        X(:, end + 1) = y; R(:, end + 1) = r; Fv(end + 1) = f; %#ok<AGROW>
    end
    if stop, break; end
end
rho = RHOBEG; Delta = RHOBEG;

while ~stop && nf < maxfun
    [~, kb] = min(Fv);
    xk = X(:, kb); rk = R(:, kb); fk = Fv(kb);
    others = setdiff(1:size(X, 2), kb);
    D = X(:, others) - xk;
    dist = vecnorm(D, 2, 1);

    % not enough independent directions yet: add a geometry point
    if size(D, 2) < n || rank(D, 1e-10 * max(1, max(dist))) < n
        d = geometry_direction(D, max(Delta, rho));
        [y, r, f] = eval_near(xk, d);
        if isempty(y), break; end
        X(:, end + 1) = y; R(:, end + 1) = r; Fv(end + 1) = f; %#ok<AGROW>
        continue;
    end

    J = (R(:, others) - rk) / D;                       % least squares if more than n
    s = box_lm_step(J, rk, Delta, lb - xk, ub - xk);
    geometry_ok = max(dist) <= max(2 * Delta, 10 * rho);

    if norm(s) < G_S * rho
        % ---- safety phase ----
        Delta_new = max(rho, OMEGA_S * Delta);
        if ~geometry_ok
            [~, far] = max(dist);
            d = geometry_direction(D(:, setdiff(1:numel(dist), far)), Delta_new);
            [y, r, f] = eval_near(xk, d);
            if ~isempty(y)
                X(:, others(far)) = y; R(:, others(far)) = r; Fv(others(far)) = f;
            end
            Delta = Delta_new;
        elseif Delta_new == rho
            if rho <= RHOEND, break; end
            Delta = A2 * rho; rho = A1 * rho;
            rho = max(rho, RHOEND); Delta = max(Delta, rho);
        else
            Delta = Delta_new;
        end
        continue;
    end

    % ---- trust-region step ----
    [rn, fn] = evalr(xk + s);
    if isempty(rn)
        ratio = -inf;
    else
        pred = sum(rk.^2) - sum((rk + J * s).^2);
        actual = sum(rk.^2) - sum(rn.^2);
        ratio = actual / max(pred, realmin);
    end
    ns = norm(s);
    if ratio < ETA1
        Delta = min(G_DEC * Delta, ns);
    elseif ratio < ETA2
        Delta = max(G_DEC * Delta, ns);
    else
        Delta = min(max(G_INC * Delta, G_INC_BAR * ns), DELTA_MAX);
    end
    Delta = max(Delta, rho);

    if ~isempty(rn)
        % always keep the newest point; drop the one farthest from the best
        X(:, end + 1) = xk + s; R(:, end + 1) = rn; Fv(end + 1) = fn;
        [~, kb2] = min(Fv);
        dd = vecnorm(X - X(:, kb2), 2, 1); dd(kb2) = -inf; dd(end) = -inf;
        while size(X, 2) > npt
            [~, far] = max(dd);
            X(:, far) = []; R(:, far) = []; Fv(far) = []; dd(far) = [];
        end
    end

    if ratio < ETA1
        [~, kb] = min(Fv);
        xk = X(:, kb);
        others = setdiff(1:size(X, 2), kb);
        D = X(:, others) - xk;
        dist = vecnorm(D, 2, 1);
        if max(dist) > max(2 * Delta, 10 * rho)
            % ---- model-improvement phase ----
            [~, far] = max(dist);
            d = geometry_direction(D(:, setdiff(1:numel(dist), far)), Delta);
            [y, r, f] = eval_near(xk, d);
            if ~isempty(y)
                X(:, others(far)) = y; R(:, others(far)) = r; Fv(others(far)) = f;
            end
        elseif Delta == rho
            % ---- unsuccessful phase with a well-poised set: reduce rho ----
            if rho <= RHOEND, break; end
            Delta = A2 * rho; rho = A1 * rho;
            rho = max(rho, RHOEND); Delta = max(Delta, rho);
        end
    end
end
x = reshape(best_x, sz); fval = best_f;
end

function s = box_lm_step(J, r, Delta, lo, hi)
% min ||r + J s||^2  s.t. ||s|| <= Delta, lo <= s <= hi: Levenberg-Marquardt
% on the free variables; any that would leave the box are fixed on it and
% the others re-solved (at most n passes).
n = size(J, 2);
s = zeros(n, 1);
free = true(n, 1);
for pass = 1:n
    rr =r + J(:, ~free) * s(~free);
    Dl = sqrt(max(Delta^2 - sum(s(~free).^2), 0));
    if Dl == 0 || ~any(free), break; end
    s(free) = lm_ball(J(:, free), rr, Dl);
    out = free & (s < lo | s > hi);
    if ~any(out), break; end
    s(out) = min(max(s(out), lo(out)), hi(out));
    free(out) = false;
end
s = min(max(s, lo), hi);
end

function s = lm_ball(J, r, Delta)
% The bisection on lam below tries very small damping values, for which
% A + lam*I is numerically singular when the model's Jacobian is
% ill-conditioned (e.g. the Ms-alpha-a valley of an anhysteretic fit); the
% resulting "nearly singular" warnings carry no information here (the
% bisection only needs the step length), so they are silenced for this
% function alone and restored on exit. Same arithmetic as before.
ws = warning('off', 'MATLAB:nearlySingularMatrix');
ws(2) = warning('off', 'MATLAB:singularMatrix');
cleanup = onCleanup(@() warning(ws));
g = J' * r; A = J' * J;
m = size(A, 1);
s = -pinv(A) * g;
if norm(s) <= Delta, return; end
lo = 0; hi = max(norm(A), eps) * 1e8 + norm(g) / Delta;
for it = 1:80
    lam = sqrt(max(lo, 1e-16 * hi) * hi);
    st = -(A + lam * eye(m)) \ g;
    if norm(st) > Delta, lo = lam; else, hi = lam; end
    if hi / max(lo, realmin) < 1 + 1e-6, break; end
end
s = -(A + hi * eye(m)) \ g;
end
