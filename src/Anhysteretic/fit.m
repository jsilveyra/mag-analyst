function [Hcr, mcr, Hx, polish, chi0] = fit(data_curve, seed, N, select_a, error_type, lb, ub, select_fit, output_fcn, solver, n_sig, polish_only, linear)
%FIT  Anhysteretic fit over the distribution (fitting) parameters.
%   [Hcr, mcr, Hx, polish] = fit(data_curve, seed, N, select_a, error_type,
%       lb, ub, select_fit, output_fcn, solver, n_sig) fits a DataAnhystereticCurve with an
%   n-component Langevin-Weiss model, optimizing the 3*n-1 fitting
%   parameters [Hcr(1..n), m(Hcr)(1..n), Hx(1..n-1)] within the bounds
%   lb/ub. Parameters whose select_fit entry is false are held
%   fixed at their seed value (excluded from the solver). The modeled curve is evaluated on an
%   N-point logarithmic H grid up to the data tip, and the objective is
%   the error metric named by error_type (see make_error_calculator).
%   select_a picks the low or high root of the a(Hcr, m(Hcr)) equation.
%   output_fcn, if given, is forwarded to the optimizer (live progress).
%   solver selects the optimizer ("prima" [default], "nelder_mead" or
%   "dfols", which gets the metric's residual vector; see
%   SolverUtils.minimize_bounded). Every solver works on seed-scaled
%   variables (see the comment at the solver call). n_sig (default 3; Inf = off): after the
%   solver, the fitted parameters are polished on the lattice of
%   n_sig-digit numbers (SolverUtils.lattice_polish), so the returned
%   values are exactly the printed ones and locally optimal among them;
%   polish is the lattice_polish info struct.
%   polish_only (default false) skips the solver and runs only the lattice
%   polish, seeded from the caller's seed: what the Anhysteretic tab's
%   "Polish" button does to a finished fit (see AnhystereticUtils.polish_fit).
%   linear (default false) adds the linear term chi0 (component 0, M0 =
%   chi0*H) as the FIRST parameter: [chi0, Hcr(1..n), m(Hcr)(1..n),
%   Hx(1..n-1)], 3*n parameters; the tip/Hx constraints then act on M -
%   chi0*H. chi0 is returned as the 5th output (0 when linear is false).
%
%   See also fit_physical, retrieve_anhysteretic_seeds, MagneticParameters.
    if nargin < 9
        output_fcn = [];
    end
    if nargin < 10 || isempty(solver)
        solver = "prima";
    end
    if nargin < 11 || isempty(n_sig)
        n_sig = 3;
    end
    if nargin < 12 || isempty(polish_only)
        polish_only = false;
    end
    if nargin < 13 || isempty(linear)
        linear = false;
    end
    k0 = double(logical(linear));   % 1 when chi0 leads the parameter vector
    [HTip, ~] = Utils().find_tip(data_curve.H, data_curve.M);
    Hhat = logspace(log10(data_curve.H(2)),log10(HTip),N);

    expected_params = length(lb);
    if (length(ub) ~= expected_params)
        error('Lower and upper bounds must have the same length.');
    end
    if (length(select_fit) ~= expected_params)
        error('select_fit must have the same length as the bounds.');
    end

    if (length(seed) > expected_params)
        seed = seed(1:expected_params);
    elseif (length(seed) < expected_params)
        midpoint_seed = ((lb(:) + ub(:))/2).';
        seed = [seed(:).', midpoint_seed(length(seed)+1:end)];
    end

    if (mod(expected_params - k0 + 1, 3) ~= 0)
        error('Invalid parameter vector size. Expected 3*n - 1 parameters (3*n with the linear term).');
    end

    number_components = (expected_params - k0 + 1)/3;

    function error_calculator = calculator_at(x)
        chi0_fit = 0;
        if k0
            chi0_fit = x(1);
        end
        Hcr_fit = x(k0+1:k0+number_components);
        mcr_fit = x(k0+number_components+1:k0+2*number_components);
        Hx_fit = x(k0+number_components*2 +1:end);

        magnetic_parameters = MagneticParameters(data_curve, Hcr_fit, mcr_fit, Hx_fit, select_a, [], chi0_fit);

        modeled_curve = ModeledAnhystereticCurve(Hhat, magnetic_parameters);
        error_calculator = make_error_calculator(error_type, data_curve.H, data_curve.M, modeled_curve.H, modeled_curve.M);
    end

    function ret = fit_parameters(x)
        ret = calculator_at(x).get_error();
    end

    % The residual vector whose root mean square is fit_parameters(x), for
    % the DFO-LS solver (since 2026-09-25; before, "DFO-LS" ran BOBYQA
    % here); [] where the point cannot be scored.
    function r = fit_residuals(x)
        try
            r = calculator_at(x).get_residuals();
            if isempty(r) || ~isreal(r) || any(~isfinite(r(:)))
                r = [];
            end
        catch
            r = [];
        end
    end

    epsilon = 0.0001;
    for i=1:length(select_fit)
        if(~select_fit{i})
            lb(i) = seed(i) - epsilon;
            ub(i) = seed(i) + epsilon;
        end
    end

    % One tight solver call per Fit click. Restarting the search from a
    % loosely-converged intermediate point carries no monotonicity guarantee
    % and can land in a worse basin; restarting from a fully converged result
    % can only match or improve it, since both solvers always evaluate their
    % own starting point first. Pressing Fit again therefore repeats the
    % search seeded from this call's own converged result -- see
    % AnhystereticUtils.fit_parameters, which surfaces a one-time tip about
    % this.
    if polish_only
        % "Polish" button: the parameters are already fitted; only the
        % lattice search below runs.
        params = seed;
    else
        % Seed scaling, as in fit_physical and JAFitter: every solver works
        % on params ./ scale, i.e. each parameter in units of its own
        % initial estimate (diagonal scaling, Dennis & Schnabel 1996, ch. 7),
        % so H_cr (~1e1-1e5 A/m) and m(H_cr) (~0.5) weigh equally in steps
        % and stopping tests. scale = |seed clipped to the bounds|, 1 where
        % that is below 1e-8: exactly bobyqa_mat's own internal scaling, so
        % BOBYQA's path is unchanged to the last bit; Nelder-Mead was
        % unscaled here until 2026-09-25.
        x0c = min(max(seed(:), lb(:)), ub(:));
        scale = abs(x0c);
        scale(scale < 1e-8) = 1;
        if k0
            % chi0 is often seeded at (or near) 0, where the generic rule
            % would give it a scale of 1, far too coarse for a slope of
            % order 1e-6..1e-2: use 1e-3 of the curve's tip M/H instead.
            [HTip_s, MTip_s] = Utils().find_tip(data_curve.H, data_curve.M);
            scale(1) = max(abs(x0c(1)), 1e-3 * abs(MTip_s / HTip_s));
        end
        scale_x = reshape(scale, size(seed));
        scaled_output_fcn = [];
        if ~isempty(output_fcn)
            % hand the progress tracker physical (unscaled) points
            scaled_output_fcn = @(y, optimValues, state) output_fcn(y .* scale_x, optimValues, state);
        end
        solver_options = struct();
        if strcmp(solver, "dfols")
            solver_options.residual_fun = @(y) fit_residuals(y .* scale_x);
        end
        % Parameters held by select_fit are excluded from the solver (kept
        % exactly at their seed; see SolverUtils.minimize_bounded_free).
        free = reshape(cellfun(@logical, select_fit(:)), size(seed));
        params_y = SolverUtils.minimize_bounded_free(@(y) fit_parameters(y .* scale_x), seed ./ scale_x, ...
            lb ./ reshape(scale, size(lb)), ub ./ reshape(scale, size(ub)), free, scaled_output_fcn, solver, solver_options);
        params = params_y .* scale_x;
    end

    % Lattice polish: the reported Hcr, m(Hcr), Hx are exactly n_sig-digit
    % numbers and locally optimal among them (parameters held fixed by
    % select_fit are neither rounded nor moved).
    polish = struct();
    if isfinite(n_sig)
        fixed = ~cellfun(@logical, select_fit(:));
        [params_q, ~, polish] = SolverUtils.lattice_polish(@fit_parameters, params, n_sig, ...
            struct('output_fcn', output_fcn, 'fixed', fixed, 'lb', lb, 'ub', ub, ...
                   'full', struct('x', params, 'J', fit_parameters(params))));
        if isfinite(polish.fval_start) || polish.moves > 0
            params = reshape(params_q, size(params));   % keep the solver's orientation
        end
    end

    chi0 = 0;
    if k0
        chi0 = params(1);
    end
    Hcr = params(k0+1:k0+number_components);
    mcr = params(k0+number_components+1:k0+2*number_components);
    Hx = params(k0+number_components*2 +1:end);
end

