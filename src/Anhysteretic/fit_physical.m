function [Ms, alpha, a] = fit_physical(data_curve, seed, N, error_type, lb, ub, select_fit, output_fcn, solver)
%FIT_PHYSICAL  Full-DOF anhysteretic fit over the physical parameters.
%   [Ms, alpha, a] = fit_physical(data_curve, seed, N, error_type, lb, ub, ...
%       select_fit, output_fcn, solver) optimizes the 3*n physical parameters
%   [Ms(1..n), alpha(1..n), a(1..n)] directly, instead of the 3*n-1
%   distribution parameters (Hcr, mcr, Hx) that fit.m fits. solver selects
%   the optimizer ("nelder_mead" [default] or "prima"; see
%   SolverUtils.minimize_bounded).
%
%   This is the "reduce dof" UNCHECKED path: the constraint points at the tip
%   and Hx are dropped, so Ms becomes a free variable. It is meant as a
%   second-stage refinement seeded from a prior fit's physical parameters. Ms
%   may be negative (a component's saturation contribution can be negative in a
%   multicomponent model), so it is left unbounded by the caller.
%
%   Two things keep the promise that the error can only improve, never worsen:
%     * The optimization runs in SEED-NORMALIZED coordinates -- each parameter
%       is divided by a per-block characteristic scale so Ms (~1e5), alpha
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
    if nargin < 9
        solver = "nelder_mead";
    end
    [HTip, ~] = Utils().find_tip(data_curve.H, data_curve.M);
    Hhat = logspace(log10(data_curve.H(2)), log10(HTip), N);

    expected_params = length(lb);
    if (length(ub) ~= expected_params)
        error('Lower and upper bounds must have the same length.');
    end
    if (length(select_fit) ~= expected_params)
        error('select_fit must have the same length as the bounds.');
    end
    if (mod(expected_params, 3) ~= 0)
        error('Invalid parameter vector size. Expected 3*n parameters.');
    end

    if (length(seed) > expected_params)
        seed = seed(1:expected_params);
    elseif (length(seed) < expected_params)
        midpoint_seed = ((lb(:) + ub(:))/2).';
        seed = [seed(:).', midpoint_seed(length(seed)+1:end)];
    end

    n = expected_params/3;
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

    % Per-block characteristic scale (Ms / alpha / a), floored away from zero.
    block_scale = @(v) max(max(abs(v)), eps);
    scale = [block_scale(seed(1:n))     * ones(1, n), ...
             block_scale(seed(n+1:2*n)) * ones(1, n), ...
             block_scale(seed(2*n+1:end)) * ones(1, n)];

    function physical = unpack(x)
        physical.Ms    = x(1:n);
        physical.alpha = x(n+1:2*n);
        physical.a     = x(2*n+1:end);
    end

    function e = physical_error(x)
        magnetic_parameters = MagneticParameters(data_curve, [], [], [], [], unpack(x));
        modeled_curve = ModeledAnhystereticCurve(Hhat, magnetic_parameters);
        error_calculator = make_error_calculator(error_type, data_curve.H, data_curve.M, modeled_curve.H, modeled_curve.M);
        e = error_calculator.get_error();
    end

    function ret = objective(y)          % y is scaled; unscale to evaluate
        ret = physical_error(y .* scale);
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
    params_y = SolverUtils.minimize_bounded(@objective, y0, ylb, yub, scaled_output_fcn, solver);

    result = params_y .* scale;
    % Seed guard: never return a point worse than the seed.
    if physical_error(result) > physical_error(seed)
        result = seed;
    end

    physical = unpack(result);
    Ms    = physical.Ms;
    alpha = physical.alpha;
    a     = physical.a;
end
