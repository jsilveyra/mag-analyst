function [Hcr, mcr] = fit(H, M, seed)

    options = optimset('PlotFcns',@optimplotfval);
    [HTip, ~] = Utils().find_tip(H, M);
    H_log = log(H);
    N = 100;
    Hhat = logspace(log10(H(2)),log10(HTip),N);
    function ret = fit_parameters(x)
        Hcr_fit = x(1:end/2);
        mcr_fit = x((end/2)+1:end);
        for i = 1:length(mcr_fit)
            if mcr_fit(i) < 0.44951
                ret = 1000;
                return;
            end
        end
        magnetic_parameters = MagneticParameters(H, M, Hcr_fit, mcr_fit);
        a = magnetic_parameters.get_a();
        alphaMs = magnetic_parameters.get_alphaMs(a);
        Ms = magnetic_parameters.get_Ms(a, alphaMs);
        Mhat = get_Mhat(Hhat, a, alphaMs, Ms);
        %[h_error, ~] = horizontal_error(H_log, M, log(Hhat), Mhat);
        %[h_error, ~] = vertical_error(H_log, M, log(Hhat), Mhat);
        d_error = diagonal_error(H_log(2:end), M(2:end), log(Hhat), Mhat);

        ret = d_error;
    end
    params = fminsearch(@fit_parameters, seed, options);
    Hcr = params(1:end/2);
    mcr = params((end/2)+1:end);
end
