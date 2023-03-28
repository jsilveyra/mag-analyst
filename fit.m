function [Hcr, mcr] = fit(H, M, seed, select_a, error_type, lb, ub)
    [HTip, ~] = Utils().find_tip(H, M);
    H_log = log(H);
    N = 100;
    Hhat = logspace(log10(H(2)),log10(HTip),N);
    error = ErrorCalculator();
    function ret = fit_parameters(x)
        Hcr_fit = x(1:end/2);
        mcr_fit = x((end/2)+1:end); 

        magnetic_parameters = MagneticParameters(H, M, Hcr_fit, mcr_fit);
        a = magnetic_parameters.get_a(select_a);
        alphaMs = magnetic_parameters.get_alphaMs(a);
        Ms = magnetic_parameters.get_Ms(a, alphaMs);
        Mhat = get_Mhat(Hhat, a, alphaMs, Ms);
        ret = error.get_error(H_log, M, log(Hhat), Mhat, error_type);
    end

    params = minimize(@fit_parameters, seed, [],[], [],[], lb , ub);

    Hcr = params(1:end/2);
    mcr = params((end/2)+1:end);
end
