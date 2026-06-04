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

    branches = buildJA_majorLoopBranchConditions("Tip point", Htip, Mtip, Htip, 1);

    [H1, M1] = solveJA_monotonic( ...
        branches(1).Hstart, ...
        branches(1).Hend, ...
        Mtip, ...
        params, ...
        branches(1).delta, ...
        opts);

    [H2, M2] = solveJA_monotonic( ...
        branches(2).Hstart, ...
        branches(2).Hend, ...
        M1(end), ...
        params, ...
        branches(2).delta, ...
        opts);

    Hmod = [H1; H2(2:end)];
    Mmod = [M1; M2(2:end)];
end

