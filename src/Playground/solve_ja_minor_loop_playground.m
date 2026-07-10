function [Hmod, Mmod, info] = solve_ja_minor_loop_playground( ...
    Htips, params, stop_criterion, repetitions, rel_tol, max_repetitions, opts)
%SOLVE_JA_MINOR_LOOP_PLAYGROUND Simulate minor loop history in the playground.
%
%   [Hmod, Mmod, info] = solve_ja_minor_loop_playground(...)
%
%   Htips is sorted ascending before the simulation starts, so the
%   smallest tip field is simulated first (starting from the demagnetized
%   state) and each subsequent, larger tip field is reached by bridging
%   up from the previous positive tip. max_repetitions caps the number of
%   loops per tip when stop_criterion is "Until convergence" (mirrors
%   solve_ja_hysteretic_region).

    if nargin < 7 || isempty(opts)
        opts = [];
    end
    if nargin < 6 || isempty(max_repetitions)
        max_repetitions = 10;
    end
    if nargin < 5 || isempty(rel_tol)
        rel_tol = 1e-3;
    end
    if nargin < 4 || isempty(repetitions)
        repetitions = 1;
    end

    stop_criterion = string(stop_criterion);
    repetitions = max(0, round(repetitions));
    max_repetitions = max(1, round(max_repetitions));
    rel_tol = max(rel_tol, 0);
    Htips = sort(double(Htips(:)), 'ascend');

    if isempty(Htips) || any(~isfinite(Htips)) || any(Htips <= 0)
        error('solve_ja_minor_loop_playground:InvalidTipFields', ...
            'Htips must be a non-empty vector of finite positive values.');
    end

    info = struct( ...
        'mode', "Minor Loops", ...
        'stop_criterion', stop_criterion, ...
        'cycles_simulated', 0, ...
        'converged', false, ...
        'branch_starts', [], ...
        'tip_starts', [], ...
        'tip_ends', [], ...
        'tip_last_loop_starts', []);

    segments_H = {};
    segments_M = {};
    branch_starts = [];
    next_start_index = 1;

    current_positive_M = 0;
    previous_positive_tip = 0;

    for idx_tip = 1:numel(Htips)
        Htip = Htips(idx_tip);
        tip_start_index = next_start_index;
        last_loop_start_index = tip_start_index;

        if idx_tip == 1
            [Hfirst, Mfirst] = solve_ja_monotonic(0, Htip, 0, params, +1, opts);
            segments_H{end + 1} = Hfirst; %#ok<AGROW>
            segments_M{end + 1} = Mfirst; %#ok<AGROW>
            branch_starts(end + 1) = next_start_index; %#ok<AGROW>
            next_start_index = next_start_index + numel(Hfirst) - 1;
            current_positive_M = Mfirst(end);
        else
            % Tips are processed from smallest to largest, so the bridge
            % from the previous (smaller) positive tip up to the current
            % (larger) tip is an increasing field: delta = +1.
            [Hbridge, Mbridge] = solve_ja_monotonic(previous_positive_tip, Htip, current_positive_M, params, +1, opts);
            segments_H{end + 1} = Hbridge; %#ok<AGROW>
            segments_M{end + 1} = Mbridge; %#ok<AGROW>
            branch_starts(end + 1) = next_start_index; %#ok<AGROW>
            next_start_index = next_start_index + numel(Hbridge) - 1;
            current_positive_M = Mbridge(end);
        end

        previous_cycle_end = current_positive_M;
        if stop_criterion == "Until convergence"
            max_cycles = max_repetitions;
        else
            max_cycles = repetitions;
        end
        for cycle = 1:max_cycles
            last_loop_start_index = next_start_index;
            [Hleft, Mleft] = solve_ja_monotonic(Htip, -Htip, current_positive_M, params, -1, opts);
            [Hright, Mright] = solve_ja_monotonic(-Htip, Htip, Mleft(end), params, +1, opts);

            segments_H{end + 1} = Hleft; %#ok<AGROW>
            segments_M{end + 1} = Mleft; %#ok<AGROW>
            branch_starts(end + 1) = next_start_index; %#ok<AGROW>
            next_start_index = next_start_index + numel(Hleft) - 1;

            segments_H{end + 1} = Hright; %#ok<AGROW>
            segments_M{end + 1} = Mright; %#ok<AGROW>
            branch_starts(end + 1) = next_start_index; %#ok<AGROW>
            next_start_index = next_start_index + numel(Hright) - 1;

            info.cycles_simulated = info.cycles_simulated + 1;
            current_positive_M = Mright(end);

            if stop_criterion == "Until convergence"
                rel_base = max(abs(previous_cycle_end), eps);
                if abs(current_positive_M - previous_cycle_end) / rel_base < rel_tol
                    info.converged = true;
                    break;
                end
                previous_cycle_end = current_positive_M;
            end
        end

        previous_positive_tip = Htip;
        info.tip_starts(end + 1) = tip_start_index; %#ok<AGROW>
        info.tip_ends(end + 1) = next_start_index - 1; %#ok<AGROW>
        info.tip_last_loop_starts(end + 1) = last_loop_start_index; %#ok<AGROW>
    end

    [Hmod, Mmod] = local_concat_segments(segments_H, segments_M);

    if isempty(Hmod)
        Hmod = Htips(1);
        Mmod = current_positive_M;
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
