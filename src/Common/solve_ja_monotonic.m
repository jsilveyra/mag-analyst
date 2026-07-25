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

    if params.k <= 0
        % Zero (or non-physical negative) pinning: no hysteresis, M
        % collapses identically onto the anhysteretic curve Manh(H+alpha*M).
        % ja_ode is singular at k=0 -- num and den both reduce to
        % +-alpha*(Manh-M), giving dM/dH = -1/alpha (or 0/0 exactly
        % on-curve) instead of tracking Manh -- so solve the implicit
        % anhysteretic equation directly at each sample point instead of
        % integrating. Hot-start each fzero from the previous point's M
        % (starting from Mstart) for robust, fast convergence along the
        % monotonic sweep.
        N = 200;
        Hsol = linspace(Hstart, Hend, N)';
        Msol = zeros(N, 1);
        m_guess = Mstart;
        for i = 1:N
            Hi = Hsol(i);
            m_guess = fzero(@(M) anhysteretic(Hi + params.alpha .* M, params) - M, m_guess);
            Msol(i) = m_guess;
        end
        return;
    end

    % Some JA parameter combinations probed by the fit optimizer make the
    % ODE locally stiff/near-singular (den in ja_ode.m near 0), so ode23tb
    % can stall below its minimum step size. It reports this as a warning,
    % not an error, and returns a solution truncated at the stall point --
    % silently accepting that partial curve would corrupt the fit
    % objective instead of rejecting the point. Suppress the warning's
    % console noise and promote it to an error instead, so callers'
    % existing try/catch (e.g. JAFitter's obj_fun) reject it like any
    % other invalid-parameter case.
    warn_id = 'MATLAB:ode23tb:IntegrationTolNotMet';
    warning('off', warn_id);
    restore_warning = onCleanup(@() warning('on', warn_id)); %#ok<NASGU>
    lastwarn('');

    sol = ode23tb( ...
        @(H, M) ja_ode(H, M, params, delta), ...
        [Hstart, Hend], ...
        Mstart, ...
        opts);

    [~, fired_id] = lastwarn();
    if strcmp(fired_id, warn_id)
        error('solve_ja_monotonic:IntegrationTolNotMet', ...
            'ode23tb could not meet integration tolerances for the given JA parameters.');
    end

    Hsol = sol.x(:);
    Msol = sol.y(:);
end
