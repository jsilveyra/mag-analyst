function [Hcr, mcr, Hx] = fit(data_curve, seed, N, select_a, error_type, lb, ub, select_fit, output_fcn)
%FIT  Anhysteretic fit over the distribution (fitting) parameters.
%   [Hcr, mcr, Hx] = fit(data_curve, seed, N, select_a, error_type, lb, ub,
%       select_fit, output_fcn) fits a DataAnhystereticCurve with an
%   n-component Langevin-Weiss model, optimizing the 3*n-1 fitting
%   parameters [Hcr(1..n), m(Hcr)(1..n), Hx(1..n-1)] within the bounds
%   lb/ub. Parameters whose select_fit entry is false are held (nearly)
%   fixed at their seed value. The modeled curve is evaluated on an
%   N-point logarithmic H grid up to the data tip, and the objective is
%   the error metric named by error_type (see make_error_calculator).
%   select_a picks the low or high root of the a(Hcr, m(Hcr)) equation.
%   output_fcn, if given, is forwarded to the optimizer (live progress).
%
%   See also fit_physical, retrieve_anhysteretic_seeds, MagneticParameters.
    if nargin < 9
        output_fcn = [];
    end
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

    if (mod(expected_params + 1, 3) ~= 0)
        error('Invalid parameter vector size. Expected 3*n - 1 parameters.');
    end

    number_components = (expected_params + 1)/3;

    function ret = fit_parameters(x)
        Hcr_fit = x(1:number_components);
        mcr_fit = x(number_components+1:2*number_components);
        Hx_fit = x(number_components*2 +1:end);

        magnetic_parameters = MagneticParameters(data_curve, Hcr_fit, mcr_fit, Hx_fit, select_a);
        
        modeled_curve = ModeledAnhystereticCurve(Hhat, magnetic_parameters);
        error_calculator = make_error_calculator(error_type, data_curve.H, data_curve.M, modeled_curve.H, modeled_curve.M);

        ret = error_calculator.get_error();
    end

    epsilon = 0.0001;
    for i=1:length(select_fit)
        if(~select_fit{i})
            lb(i) = seed(i) - epsilon;
            ub(i) = seed(i) + epsilon;
        end
    end

    % One tight minimize() call per Fit click. A loose-then-tight two-stage
    % scheme was tried and rejected: seeding the tight pass from
    % a loosely-converged intermediate point has no monotonicity guarantee
    % (unlike restarting from a pass's own FULLY tight-converged result,
    % which can only match or improve, never worsen, since minimize() always
    % evaluates its own starting point as part of the initial simplex) -- a
    % tolerance sweep showed the loose relocation can land in a genuinely
    % worse basin, sometimes well worse than not restarting at all. Pressing
    % Fit again (unchanged) reproduces the safe, monotonic restart instead,
    % seeded from this call's own tight result -- see
    % AnhystereticUtils.fit_parameters, which also surfaces a one-time tip
    % about this.
    options = optimset('MaxIter', 2000, 'MaxFunEvals', 1e4, 'TolX', 1e-5, 'TolFun', 1e-5, 'Display', 'off');
    if ~isempty(output_fcn)
        options = optimset(options, 'OutputFcn', output_fcn);
    end
    params = minimize(@fit_parameters, seed, [],[], [],[], lb , ub, [], options);

    Hcr = params(1:number_components);
    mcr = params(number_components+1:2*number_components);
    Hx = params(number_components*2 +1:end);
end

