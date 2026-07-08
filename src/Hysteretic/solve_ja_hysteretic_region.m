function [Hmod, Mmod, info] = solve_ja_hysteretic_region( ...
    Htip, Mtip, params, start_mode, fitting_region, stop_criterion, repetitions, rel_tol, max_repetitions, opts)
%SOLVE_JA_HYSTERETIC_REGION Solve the JA model for a selected hysteretic fitting region.
%
%   [Hmod, Mmod, info] = solve_ja_hysteretic_region(...)
%
%   For "Left branch only", the function returns the left branch of the
%   full major loop.
%
%   For "Entire loop", the function returns only the last simulated cycle.
%   If the start mode is Demagnetized, the first magnetization branch is
%   simulated internally and excluded from the returned model.

    if nargin < 10 || isempty(opts)
        opts = [];
    end
    if nargin < 9 || isempty(max_repetitions)
        max_repetitions = 10;
    end
    if nargin < 8 || isempty(rel_tol)
        rel_tol = 1e-3;
    end
    if nargin < 7 || isempty(repetitions)
        repetitions = 1;
    end

    start_mode = string(start_mode);
    fitting_region = string(fitting_region);
    stop_criterion = string(stop_criterion);

    info = struct( ...
        'starting_point', start_mode, ...
        'fitting_region', fitting_region, ...
        'stop_criterion', stop_criterion, ...
        'cycles_simulated', 0, ...
        'converged', false, ...
        'used_initial_magnetization', false);

    if fitting_region == "Left branch only"
        [Hfull, Mfull] = solve_ja_from_tip(Htip, Mtip, params, opts);
        min_index = find(Hfull == min(Hfull), 1, 'first');
        if isempty(min_index)
            min_index = numel(Hfull);
        end
        Hmod = Hfull(1:min_index);
        Mmod = Mfull(1:min_index);
        info.cycles_simulated = 1;
        return;
    end

    repetitions = max(1, round(repetitions));
    max_repetitions = max(1, round(max_repetitions));
    rel_tol = max(rel_tol, 0);

    if contains(lower(start_mode), "demagnetized")
        [~, Minit] = solve_ja_monotonic(0, Htip, 0, params, +1, opts);
        prev_M = Minit(end);
        info.used_initial_magnetization = true;
    else
        prev_M = Mtip;
    end

    if stop_criterion == "Until convergence"
        n_cycles = max_repetitions;
    else
        n_cycles = repetitions;
    end

    Hmod = [];
    Mmod = [];
    for cycle = 1:n_cycles
        [Hleft, Mleft] = solve_ja_monotonic(Htip, -Htip, prev_M, params, -1, opts);
        [Hright, Mright] = solve_ja_monotonic(-Htip, Htip, Mleft(end), params, +1, opts);

        Hmod = [Hleft; Hright(2:end)];
        Mmod = [Mleft; Mright(2:end)];
        info.cycles_simulated = cycle;

        if stop_criterion == "Until convergence"
            rel_base = max(abs(Mleft(1)), eps);
            if abs(Mright(end) - Mleft(1)) <= rel_tol * rel_base
                info.converged = true;
                break;
            end
        end

        prev_M = Mright(end);
    end
end
