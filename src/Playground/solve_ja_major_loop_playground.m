function [Hmod, Mmod, info] = solve_ja_major_loop_playground( ...
    Hstart, Mstart, HtipMajor, params, start_mode, stop_criterion, repetitions, rel_tol, max_repetitions, opts)
%SOLVE_JA_MAJOR_LOOP_PLAYGROUND Simulate the Playground major loop history.
%
%   [Hmod, Mmod, info] = solve_ja_major_loop_playground(...)
%
%   The function returns the full concatenated history in the selected
%   driving field mode together with branch metadata in info.branch_starts.
%   max_repetitions caps the number of cycles when stop_criterion is
%   "Until convergence" (mirrors solve_ja_hysteretic_region).

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
    stop_criterion = string(stop_criterion);
    HtipMajor = double(HtipMajor);
    repetitions = max(0, round(repetitions));
    max_repetitions = max(1, round(max_repetitions));
    rel_tol = max(rel_tol, 0);

    if ~(isscalar(HtipMajor) && isfinite(HtipMajor) && HtipMajor > 0)
        error('solve_ja_major_loop_playground:InvalidTipField', ...
            'HtipMajor must be a finite positive scalar.');
    end

    if contains(lower(start_mode), "tip point")
        if ~(isscalar(Mstart) && isfinite(Mstart))
            error('solve_ja_major_loop_playground:InvalidInputs', ...
                'Tip-point starts require a finite Mstart value.');
        end
    else
        if ~(isscalar(Hstart) && isfinite(Hstart) && isscalar(Mstart) && isfinite(Mstart))
            error('solve_ja_major_loop_playground:InvalidInputs', ...
                'Hstart and Mstart must be finite scalars.');
        end
    end

    info = struct( ...
        'mode', "Major Loop", ...
        'start_mode', start_mode, ...
        'stop_criterion', stop_criterion, ...
        'cycles_simulated', 0, ...
        'converged', false, ...
        'used_initial_magnetization', false, ...
        'branch_starts', []);

    segments_H = {};
    segments_M = {};
    branch_starts = [];
    next_start_index = 1;

    delta0 = sign(HtipMajor - Hstart);
    if delta0 == 0
        delta0 = 1;
    end
    [Hinit, Minit] = solve_ja_monotonic(Hstart, HtipMajor, Mstart, params, delta0, opts);
    segments_H{end + 1} = Hinit; %#ok<AGROW>
    segments_M{end + 1} = Minit; %#ok<AGROW>
    branch_starts(end + 1) = next_start_index; %#ok<AGROW>
    next_start_index = next_start_index + numel(Hinit) - 1;
    current_M = Minit(end);
    info.used_initial_magnetization = contains(lower(start_mode), "demagnetized");

    previous_cycle_end = current_M;
    if stop_criterion == "Until convergence"
        max_cycles = max_repetitions;
    else
        max_cycles = repetitions;
    end
    for cycle = 1:max_cycles
        [Hleft, Mleft] = solve_ja_monotonic(HtipMajor, -HtipMajor, current_M, params, -1, opts);
        [Hright, Mright] = solve_ja_monotonic(-HtipMajor, HtipMajor, Mleft(end), params, +1, opts);

        segments_H{end + 1} = Hleft; %#ok<AGROW>
        segments_M{end + 1} = Mleft; %#ok<AGROW>
        branch_starts(end + 1) = next_start_index; %#ok<AGROW>
        next_start_index = next_start_index + numel(Hleft) - 1;

        segments_H{end + 1} = Hright; %#ok<AGROW>
        segments_M{end + 1} = Mright; %#ok<AGROW>
        branch_starts(end + 1) = next_start_index; %#ok<AGROW>
        next_start_index = next_start_index + numel(Hright) - 1;

        info.cycles_simulated = cycle;
        current_M = Mright(end);

        if stop_criterion == "Until convergence"
            rel_base = max(abs(previous_cycle_end), eps);
            if abs(current_M - previous_cycle_end) / rel_base < rel_tol
                info.converged = true;
                break;
            end
            previous_cycle_end = current_M;
        end
    end

    [Hmod, Mmod] = local_concat_segments(segments_H, segments_M);

    if isempty(Hmod)
        Hmod = HtipMajor;
        Mmod = current_M;
        branch_starts = 1;
    end

    info.branch_starts = branch_starts;
end

function [Hout, Mout] = local_concat_segments(segments_H, segments_M)
    Hout = [];
    Mout = [];
    for i = 1:numel(segments_H)
        if isempty(Hout)
            Hout = segments_H{i};
            Mout = segments_M{i};
        else
            Hout = [Hout; segments_H{i}(2:end)]; %#ok<AGROW>
            Mout = [Mout; segments_M{i}(2:end)]; %#ok<AGROW>
        end
    end
end
