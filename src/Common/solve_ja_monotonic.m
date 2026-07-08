function [Hsol, Msol] = solve_ja_monotonic( ...
    Hstart, Hend, Mstart, params, delta, opts)
%SOLVE_JA_MONOTONIC Core JA ODE solver for a monotonic field history
%
%   [Hsol, Msol] = solve_ja_monotonic(Hstart, Hend, Mstart, params, delta, opts)
%
%   Inputs:
%     Hstart, Hend : initial and final applied fields [A/m]
%     Mstart       : magnetization at Hstart [A/m]
%     params       : JA parameters struct (Ms, a, alpha, k, c)
%     delta        : sign(dH), +1 or -1
%     opts         : ODE options (optional), e.g. odeset('RelTol',1e-7,'AbsTol',1e-6)
%
%   Outputs:
%     Hsol, Msol   : adaptive ODE solution arrays (column vectors)

    if nargin < 6 || isempty(opts)
        opts = odeset('RelTol', 1e-7, 'AbsTol', 1e-6);
    end

    if Hstart == Hend
        Hsol = Hstart;
        Msol = Mstart;
        return;
    end

    sol = ode23tb( ...
        @(H, M) ja_ode(H, M, params, delta), ...
        [Hstart, Hend], ...
        Mstart, ...
        opts);

    Hsol = sol.x(:);
    Msol = sol.y(:);
end
