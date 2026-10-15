function [Ms, alpha, a, polish, chi0] = fit_physical(data_curve, seed, N, error_type, lb, ub, select_fit, output_fcn, solver, n_sig, polish_only, linear)
%FIT_PHYSICAL  Full-DOF anhysteretic fit over the physical parameters.
%   [Ms, alpha, a, polish] = fit_physical(data_curve, seed, N, error_type, lb, ub, ...
%       select_fit, output_fcn, solver, n_sig) optimizes the 3*n physical parameters
%   [Ms(1..n), alpha(1..n), a(1..n)] directly, instead of the 3*n-1
%   distribution parameters (Hcr, mcr, Hx) that fit.m fits. solver selects
%   the optimizer ("prima" [default], "nelder_mead" or "dfols", which gets
%   the metric's residual vector; see SolverUtils.minimize_bounded). n_sig (default 3; Inf = off): after the
%   solver and the seed guard, Ms, alpha and a are polished on the lattice of
%   n_sig-digit numbers (SolverUtils.lattice_polish, in physical units), so
%   the returned values are exactly the printed ones and locally optimal
%   among them; polish is the lattice_polish info struct.
%   polish_only (default false) skips the solver and the seed guard and runs
%   only the lattice polish, seeded from the caller's seed: what the
%   Anhysteretic tab's "Polish" button does to a finished physical fit
%   (see AnhystereticUtils.polish_fit).
%   linear (default false) adds the linear term chi0 (component 0, M0 =
%   chi0*H) as the FIRST parameter: [chi0, Ms(1..n), alpha(1..n), a(1..n)],
%   3*n+1 parameters; chi0 is the 5th output (0 when linear is false).
%
%   This is the GUI's "Constrained by n data points" UNCHECKED path: the
%   constraint points at the tip and Hx are dropped, so Ms becomes a free
%   variable. It is meant as a
%   second-stage refinement seeded from a prior fit's physical parameters. Ms
%   may be negative (a component's saturation contribution can be negative in a
%   multicomponent model), so it is left unbounded by the caller.
%
%   Two things keep the promise that the error can only improve, never worsen:
%     * The optimization runs in SEED-NORMALIZED coordinates -- each parameter
%       is divided by the magnitude of its own seed so Ms (~1e5), alpha
%       (~1e-4) and a (~1e1) are all O(1). Without this, a single step size
%       and tolerance cannot serve all three blocks at once, and the search
%       can step to (and return) a worse point.
%     * A final SEED GUARD compares the optimizer's result against the seed and
%       returns whichever has the lower error -- so a failed/hurtful search
%       degrades to "no change", never to "worse".
%   The output_fcn (fit-progress tracker) is always called with UNSCALED
%   (physical) parameters, so the app's best-point bookkeeping stays in
%   physical space. Same minimizer/options and sample grid as fit.m, so the
%   reported error is directly comparable.

    if nargin < 8
        output_fcn = [];
    end
    if nargin < 9 || isempty(solver)
        solver = "prima";
    end
    if nargin < 10 || isempty(n_sig)
        n_sig = 3;
    end
    if nargin < 11 || isempty(polish_only)
        polish_only = false;
    end
    if nargin < 12 || isempty(linear)
        linear = false;
    end
    k0 = double(logical(linear));   % 1 when chi0 leads the parameter vector
    [HTip, ~] = Utils().find_tip(data_curve.H, data_curve.M);
    Hhat = logspace(log10(data_curve.H(2)), log10(HTip), N);

    expected_params = length(lb);
    if (length(ub) ~= expected_params)
        error('Lower and upper bounds must have the same length.');
    end
    if (length(select_fit) ~= expected_params)
        error('select_fit must have the same length as the bounds.');
    end
    if (mod(expected_params - k0, 3) ~= 0)
        error('Invalid parameter vector size. Expected 3*n parameters (3*n+1 with the linear term).');
    end

    if (length(seed) > expected_params)
        seed = seed(1:expected_params);
    elseif (length(seed) < expected_params)
        midpoint_seed = ((lb(:) + ub(:))/2).';
        seed = [seed(:).', midpoint_seed(length(seed)+1:end)];
    end

    n = (expected_params - k0)/3;
    seed = seed(:).';
    lb = lb(:).';
    ub = ub(:).';

    epsilon = 0.0001;
    for i = 1:length(select_fit)
        if (~select_fit{i})
            lb(i) = seed(i) - epsilon;
            ub(i) = seed(i) + epsilon;
        end
    end

    % Per-parameter scale = |own seed| (clipped to the bounds), 1 below
    % 1e-8 -- the same rule as fit.m and JAFitter. Until 2026-09-28 every
    % component's Ms (alpha, a) shared the largest |seed| of its kind,
    % but parameters of the same kind need not have the same order of
    % magnitude across components.
    scale = abs(min(max(seed, lb), ub));
    scale(scale < 1e-8) = 1;
    if k0
        % chi0 seeded at (or near) 0: scale it by 1e-3 of the tip M/H, not 1
        % (same rule as fit.m).
        [HTip_s, MTip_s] = Utils().find_tip(data_curve.H, data_curve.M);
        scale(1) = max(abs(min(max(seed(1), lb(1)), ub(1))), 1e-3 * abs(MTip_s / HTip_s));
    end

    function physical = unpack(x)
        physical.chi0  = 0;
        if k0
            physical.chi0 = x(1);
        end
        physical.Ms    = x(k0+1:k0+n);
        physical.alpha = x(k0+n+1:k0+2*n);
        physical.a     = x(k0+2*n+1:end);
    end

    function error_calculator = calculator_at(x)
        magnetic_parameters = MagneticParameters(data_curve, [], [], [], [], unpack(x));
        modeled_curve = ModeledAnhystereticCurve(Hhat, magnetic_parameters);
        error_calculator = make_error_calculator(error_type, data_curve.H, data_curve.M, modeled_curve.H, modeled_curve.M);
    end

    function e = physical_error(x)
        e = calculator_at(x).get_error();
    end

    function ret = objective(y)          % y is scaled; unscale to evaluate
        ret = physical_error(y .* scale);
    end

    % The residual vector whose root mean square is objective(y), for the
    % DFO-LS solver (since 2026-09-25; before, "DFO-LS" ran BOBYQA here);
    % [] where the point cannot be scored.
    function r = residuals(y)
        try
            r = calculator_at(y .* scale).get_residuals();
            if isempty(r) || ~isreal(r) || any(~isfinite(r(:)))
                r = [];
            end
        catch
            r = [];
        end
    end

    % Scaled seed/bounds. Bounds may be ordered (-BIG..+BIG) either way after
    % dividing by a positive scale, so re-sort per element to keep lb <= ub.
    y0  = seed ./ scale;
    yb1 = lb ./ scale;
    yb2 = ub ./ scale;
    ylb = min(yb1, yb2);
    yub = max(yb1, yb2);

    % Infinite bounds stay infinite: minimize() applies no transform to an
    % unbounded variable, so no cap is needed (the former 1e6 cap existed
    % only because the caller passed finite 1e12 stand-ins, whose asin
    % transform lost the seed to cancellation; removed 2026-09-19 together
    % with the stand-ins). A parameter may therefore grow without limit.

    scaled_output_fcn = [];
    if ~isempty(output_fcn)
        % Hand the tracker unscaled (physical) points.
        scaled_output_fcn = @(y, optimValues, state) output_fcn(y .* scale, optimValues, state);
    end
    if polish_only
        % "Polish" button: the parameters are already fitted; only the
        % lattice search below runs. No seed guard is needed -- the polish
        % never accepts a point worse than its starting one.
        result = seed;
    else
        solver_options = struct();
        if strcmp(solver, "dfols")
            solver_options.residual_fun = @residuals;
        end
        % Parameters held by select_fit are excluded from the solver (kept
        % exactly at their seed; see SolverUtils.minimize_bounded_free).
        free = cellfun(@logical, select_fit(:)).';
        params_y = SolverUtils.minimize_bounded_free(@objective, y0, ylb, yub, free, scaled_output_fcn, solver, solver_options);

        result = params_y .* scale;
        % Seed guard: never return a point worse than the seed.
        if physical_error(result) > physical_error(seed)
            result = seed;
        end
    end

    % Lattice polish on the physical values (parameters held fixed by
    % select_fit are neither rounded nor moved).
    polish = struct();
    if isfinite(n_sig)
        fixed = ~cellfun(@logical, select_fit(:));
        [result_q, ~, polish] = SolverUtils.lattice_polish(@physical_error, result(:), n_sig, ...
            struct('output_fcn', output_fcn, 'fixed', fixed, 'lb', lb(:), 'ub', ub(:), ...
                   'full', struct('x', result(:), 'J', physical_error(result))));
        if isfinite(polish.fval_start) || polish.moves > 0
            result = result_q(:).';
        end
    end

    physical = unpack(result);
    Ms    = physical.Ms;
    alpha = physical.alpha;
    a     = physical.a;
    chi0  = physical.chi0;
end
