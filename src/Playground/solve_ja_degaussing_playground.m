function [Hmod, Mmod, info] = solve_ja_degaussing_playground( ...
    Hstart, Mstart, amplitudes, params, opts)
%SOLVE_JA_DEGAUSSING_PLAYGROUND Simulate degaussing history in the playground.
%
%   [Hmod, Mmod, info] = solve_ja_degaussing_playground( ...
%       Hstart, Mstart, amplitudes, params, opts)
%
%   Starting from the state (Hstart, Mstart), the sample is driven through a
%   sequence of field reversals of monotonically decreasing peak amplitude
%   (the classic AC demagnetization / degaussing envelope) and is finally
%   brought back to H = 0. Each monotonic field sweep is integrated with the
%   Jiles-Atherton ODE through solve_ja_monotonic.
%
%   Inputs
%     Hstart, Mstart : starting point of the path (field and magnetization).
%     amplitudes     : vector of positive peak field amplitudes. They are
%                      sorted in *descending* order (largest reversal first),
%                      so that they form a decaying degaussing envelope
%                      regardless of the order given.
%     params         : struct with JA parameters {Ms, a, alpha, k, c}.
%     opts           : odeset options forwarded to solve_ja_monotonic
%                      (default RelTol 1e-7, AbsTol 1e-6).
%
%   The first reversal is driven *opposite* to the sign of Mstart, so the
%   field first pushes the magnetization towards (and past) zero. Successive
%   reversals then alternate sign while their amplitude decays, and a final
%   sweep returns the field to zero, leaving the sample close to the
%   demagnetized state (H = 0, M ~ 0).

    if nargin < 5 || isempty(opts)
        opts = odeset('RelTol', 1e-7, 'AbsTol', 1e-6);
    end

    amplitudes = double(amplitudes(:));
    amplitudes = amplitudes(isfinite(amplitudes) & amplitudes > 0);
    amplitudes = sort(amplitudes, 'descend');

    if isempty(amplitudes)
        error('solve_ja_degaussing_playground:InvalidAmplitudes', ...
            'amplitudes must contain at least one finite positive value.');
    end
    if ~isfinite(Hstart) || ~isfinite(Mstart)
        error('solve_ja_degaussing_playground:InvalidStart', ...
            'Hstart and Mstart must be finite.');
    end

    info = struct( ...
        'mode', "Degaussing", ...
        'amplitudes', amplitudes(:).', ...
        'cycles_simulated', 0, ...
        'converged', false, ...
        'branch_starts', [], ...
        'tip_starts', [], ...
        'tip_ends', [], ...
        'tip_last_loop_starts', [], ...
        'Hfinal', NaN, ...
        'Mfinal', NaN);

    % Sign of the first reversal: drive the field opposite to the starting
    % magnetization so the very first (largest) swing overcomes it.
    first_sign = -sign(Mstart);
    if first_sign == 0
        first_sign = -1;
    end

    % Target fields: alternating, decaying peaks, then back to zero.
    n_amp = numel(amplitudes);
    targets = zeros(n_amp + 1, 1);
    for i = 1:n_amp
        targets(i) = first_sign * (-1)^(i - 1) * amplitudes(i);
    end
    targets(n_amp + 1) = 0;   % final sweep to the demagnetized field

    segments_H = {};
    segments_M = {};
    branch_starts = [];
    next_start_index = 1;

    Hcur = Hstart;
    Mcur = Mstart;

    for i = 1:numel(targets)
        Htarget = targets(i);
        delta = sign(Htarget - Hcur);
        if delta == 0
            % No field change requested for this leg (e.g. amplitude equal to
            % the current field); skip the degenerate zero-length segment.
            continue;
        end

        [Hseg, Mseg] = solve_ja_monotonic(Hcur, Htarget, Mcur, params, delta, opts);

        segments_H{end + 1} = Hseg; %#ok<AGROW>
        segments_M{end + 1} = Mseg; %#ok<AGROW>
        branch_starts(end + 1) = next_start_index; %#ok<AGROW>
        next_start_index = next_start_index + numel(Hseg) - 1;

        Hcur = Htarget;
        Mcur = Mseg(end);
    end

    [Hmod, Mmod] = local_concat_segments(segments_H, segments_M);

    if isempty(Hmod)
        % Nothing to integrate (all legs degenerate): return the start point.
        Hmod = Hstart;
        Mmod = Mstart;
        branch_starts = 1;
    end

    info.branch_starts = branch_starts;
    info.Hfinal = Hmod(end);
    info.Mfinal = Mmod(end);
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
