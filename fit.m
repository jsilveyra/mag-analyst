function [Hcr, mcr, Hx] = fit(data_curve, seed, select_a, error_type, lb, ub, select_fit)
    [HTip, ~] = Utils().find_tip(data_curve.H, data_curve.M);
    N = 100;
    Hhat = logspace(log10(data_curve.H(2)),log10(HTip),N);
    number_components = (length(seed)+1)/3;

    function ret = fit_parameters(x)
        Hcr_fit = x(1:number_components);
        mcr_fit = x(number_components+1:2*number_components);
        Hx_fit = x(number_components*2 +1:end);

        magnetic_parameters = MagneticParameters(data_curve, Hcr_fit, mcr_fit, Hx_fit, select_a);
        
        modeled_curve = ModeledAnhystereticCurve(Hhat, magnetic_parameters);
        if (error_type == "Diagonal")
            error_calculator = DiagonalErrorCalculator(data_curve, modeled_curve);
        end
        if (error_type == "Vertical")
            error_calculator = VerticalErrorCalculator(data_curve, modeled_curve);
        end
        if (error_type == "Horizontal")
            error_calculator = HorizontalErrorCalculator(data_curve, modeled_curve);
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

    params = minimize(@fit_parameters, seed, [],[], [],[], lb , ub);

    Hcr = params(1:number_components);
    mcr = params(number_components+1:2*number_components);
    Hx = params(number_components*2 +1:end);
end
