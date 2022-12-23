function [Hcr, mcr] = fit(H, M)

    options = optimset('PlotFcns',@optimplotfval);
    [HTip, ~] = find_tip(H, M);
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
        [a, alphaMs, Ms] = magnetic_parameters(H, M, Hcr_fit, mcr_fit);
        Mhat = get_Mhat(Hhat, a, alphaMs, Ms);
        %[h_error, ~] = horizontal_error(H_log, M, log(Hhat), Mhat);
        %[h_error, ~] = vertical_error(H_log, M, log(Hhat), Mhat);
        d_error = diagonal_error(H_log(2:end), M(2:end), log(Hhat), Mhat);

        ret = d_error;
    end
    params = fminsearch(@fit_parameters, [10, 8000, 0.5, 0.5], options);
    Hcr = params(1:end/2);
    mcr = params((end/2)+1:end);
end
