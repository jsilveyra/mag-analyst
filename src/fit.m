function [Hcr, mcr, Hx] = fit(data_curve, seed, N, select_a, error_type, lb, ub, select_fit)
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
        if (error_type == "Diagonal (H, sampled)")
            error_calculator = DiagonalErrorCalculator(data_curve, modeled_curve, false, false);
        elseif (error_type == "Diagonal (H, continuous)")
            error_calculator = DiagonalErrorCalculator(data_curve, modeled_curve, false, true);
        elseif (error_type == "Diagonal (logH, sampled)") || (error_type == "Diagonal (sampled)")
            error_calculator = DiagonalErrorCalculator(data_curve, modeled_curve, true, false);
        elseif (error_type == "Diagonal (logH, continuous)") || (error_type == "Diagonal") || (error_type == "Diagonal (continuous)")
            error_calculator = DiagonalErrorCalculator(data_curve, modeled_curve, true, true);
        elseif (error_type == "Vertical")
            error_calculator = VerticalErrorCalculator(data_curve, modeled_curve);
        elseif (error_type == "Horizontal")
            error_calculator = HorizontalErrorCalculator(data_curve, modeled_curve);
        else
            error('Unknown error type: %s', error_type);
        end

        ret = error_calculator.get_error();
    end

    epsilon = 0.0001;
    for i=1:length(select_fit)
        if(~select_fit{i})
            lb(i) = seed(i) - epsilon;
            ub(i) = seed(i) + epsilon;
        end
    end

    options = optimset('MaxIter', 2000, 'MaxFunEvals', 1e4); % Increase iterations and evaluations
    params = minimize(@fit_parameters, seed, [],[], [],[], lb , ub, [], options);

    Hcr = params(1:number_components);
    mcr = params(number_components+1:2*number_components);
    Hx = params(number_components*2 +1:end);
end

