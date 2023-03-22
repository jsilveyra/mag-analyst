function [Hcr, mcr] = fit(H, M, seed)
    [HTip, ~] = Utils().find_tip(H, M);
    H_log = log(H);
    N = 100;
    Hhat = logspace(log10(H(2)),log10(HTip),N);
    function ret = fit_parameters(x)
        Hcr_fit = x(1:end/2);
        mcr_fit = x((end/2)+1:end);

        magnetic_parameters = MagneticParameters(H, M, Hcr_fit, mcr_fit);
        a = magnetic_parameters.get_a("low");
        alphaMs = magnetic_parameters.get_alphaMs(a);
        Ms = magnetic_parameters.get_Ms(a, alphaMs);
        Mhat = get_Mhat(Hhat, a, alphaMs, Ms);
        %[h_error, ~] = horizontal_error(H_log, M, log(Hhat), Mhat);
        %[h_error, ~] = vertical_error(H_log, M, log(Hhat), Mhat);
        d_error = diagonal_error(H_log(2:end), M(2:end), log(Hhat), Mhat);

        ret = d_error;
    end
    
    lb = [repmat(0.0001, 1, length(seed)/2) repmat(0.44951, 1, length(seed)/2)];
    ub = [inf(1, length(seed)/2) ones(1, length(seed)/2)];
    disp(seed)
    disp(lb)
    disp(ub)
    params = minimize(@fit_parameters, seed, [],[], [],[], lb, ub);

    Hcr = params(1:end/2);
    mcr = params((end/2)+1:end);
end
