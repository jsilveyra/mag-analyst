function [Hmod, Mmod] = solveJA_fromTip(Htip, Mtip, params, opts)
%SOLVEJA_FROMTIP Full symmetric major loop starting at (+Htip, +Mtip)
%
%   [Hmod, Mmod] = solveJA_fromTip(Htip, Mtip, params, opts)
%
%   Computes:
%     +Htip -> -Htip -> +Htip
%
%   Inputs:
%     Htip   : positive field turning point [A/m]
%     Mtip   : magnetization at +Htip [A/m]
%     params : JA parameters struct (Ms, a, alpha, k, c)
%     opts   : ODE options (optional)
%
%   Outputs:
%     Hmod, Mmod : modeled loop arrays (column vectors)

    if nargin < 4
        opts = [];
    end

    [H1, M1] = solveJA_monotonic(Htip, -Htip, Mtip, params, -1, opts);
    [H2, M2] = solveJA_monotonic(-Htip, Htip, M1(end), params, +1, opts);

    Hmod = [H1; H2(2:end)];
    Mmod = [M1; M2(2:end)];
end

