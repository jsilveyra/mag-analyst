function [Hmod, Mmod, info] = solve_ja_major_harmonics_playground( ...
    Hstart, Mstart, orders, amplitudes, phases, params, ...
    stop_criterion, repetitions, rel_tol, opts, samples_per_period)
%SOLVE_JA_MAJOR_HARMONICS_PLAYGROUND Simulate a major loop driven by a distorted
%   (harmonic) field in the Playground.
%
%   [Hmod, Mmod, info] = solve_ja_major_harmonics_playground( ...
%       Hstart, Mstart, orders, amplitudes, phases, params, ...
%       stop_criterion, repetitions, rel_tol, opts, samples_per_period)
%
%   The applied field is a Fourier series over one period theta in [0, 2*pi):
%
%       H(theta) = sum_j amplitudes(j) * sin( orders(j)*theta + phases(j) )
%
%   with orders(j) positive integers, amplitudes(j) the peak amplitude of the
%   j-th component [A/m] and phases(j) its phase in RADIANS. Because the
%   Jiles-Atherton model is rate independent, only the sequence of turning
%   points (local extrema) of H(theta) governs the M(H) trajectory: between two
%   consecutive extrema the field is monotonic and is integrated with
%   solve_ja_monotonic. Harmonics add extra turning points inside each period,
%   producing minor loops nested inside the major loop.
%
%   The simulation starts at (Hstart, Mstart), bridges to the first turning
%   point, then repeats the per-period pattern of extrema for the requested
%   number of periods (or until the period-end magnetization converges).
%
%   info fields (consumed by PlaygroundUtils.get_simulation_curve):
%       mode                = "Major Loop Harmonics"
%       start_mode/stop_criterion
%       cycles_simulated     = number of full periods integrated
%       converged
%       branch_starts        = concatenated index at the start of each period
%       tip_last_loop_starts   = [start index of the last full period]
%       tip_ends             = [numel(Hmod)]  (so "Last period only" slices it)
%       vertices            = the per-period extrema field values used

    if nargin < 11 || isempty(samples_per_period)
        samples_per_period = 4000;
    end
    if nargin < 10
        opts = [];
    end
    if nargin < 9 || isempty(rel_tol)
        rel_tol = 1e-3;
    end
    if nargin < 8 || isempty(repetitions)
        repetitions = 1;
    end
    if isempty(opts)
        opts = odeset('RelTol', 1e-7, 'AbsTol', 1e-6);
    end

    stop_criterion = string(stop_criterion);
    repetitions   = max(0, round(repetitions));
    rel_tol        = max(rel_tol, 0);
    samples_per_period = max(64, round(samples_per_period));

    orders     = double(orders(:));
    amplitudes = double(amplitudes(:));
    phases     = double(phases(:));

    if ~(isscalar(Hstart) && isfinite(Hstart) && isscalar(Mstart) && isfinite(Mstart))
        error('solve_ja_major_harmonics_playground:InvalidInputs', ...
            'Hstart and Mstart must be finite scalars.');
    end
    if isempty(orders) || numel(orders) ~= numel(amplitudes) || numel(orders) ~= numel(phases)
        error('solve_ja_major_harmonics_playground:InvalidHarmonics', ...
            'orders, amplitudes and phases must be non-empty vectors of equal length.');
    end
    valid = isfinite(orders) & isfinite(amplitudes) & isfinite(phases) & orders >= 1;
    orders     = round(orders(valid));
    amplitudes = amplitudes(valid);
    phases     = phases(valid);
    if isempty(orders) || ~any(abs(amplitudes) > 0)
        error('solve_ja_major_harmonics_playground:InvalidHarmonics', ...
            'At least one harmonic with a non-zero amplitude and integer order >= 1 is required.');
    end

    info = struct( ...
        'mode', "Major Loop Harmonics", ...
        'start_mode', "", ...
        'stop_criterion', stop_criterion, ...
        'cycles_simulated', 0, ...
        'converged', false, ...
        'branch_starts', [], ...
        'tip_last_loop_starts', [], ...
        'tip_ends', [], ...
        'vertices', []);

    % --- per-period turning points (local extrema of the periodic waveform) ---
    pv = local_period_vertices(orders, amplitudes, phases, samples_per_period);
    info.vertices = pv;
    if numel(pv) < 2
        error('solve_ja_major_harmonics_playground:DegenerateWaveform', ...
            'The harmonic waveform has fewer than two turning points; check the amplitudes.');
    end

    segments_H = {};
    segments_M = {};
    branch_starts = [];
    next_start_index = 1;

    % --- bridge from the start point to the first turning point -------------
    delta0 = sign(pv(1) - Hstart);
    if delta0 == 0
        delta0 = sign(pv(2) - pv(1));
        if delta0 == 0, delta0 = 1; end
    end
    [Hseg, Mseg] = solve_ja_monotonic(Hstart, pv(1), Mstart, params, delta0, opts);
    segments_H{end + 1} = Hseg;   %#ok<AGROW>
    segments_M{end + 1} = Mseg;   %#ok<AGROW>
    next_start_index = next_start_index + numel(Hseg) - 1;
    current_M = Mseg(end);
    current_H = pv(1);

    % Targets traversed within one period, starting and ending at pv(1):
    %   pv(2), pv(3), ..., pv(end), pv(1)
    period_targets = [pv(2:end); pv(1)];

    previous_period_M = current_M;
    max_periods = max(1, repetitions);
    if stop_criterion == "Until convergence"
        % With the convergence criterion, the simulation keeps going until
        % the magnetization at the period-start vertex stops changing from one
        % period to the next. This is a practical steady-state check for
        % periodic forcing: if the loop has settled, the next period is almost
        % identical to the previous one.
        max_periods = max(max_periods, 100);
    end

    for period = 1:max_periods
        if stop_criterion ~= "Until convergence" && period > repetitions
            break;
        end

        % index of the pv(1) boundary at which this period begins
        branch_starts(end + 1) = next_start_index; %#ok<AGROW>

        for t = 1:numel(period_targets)
            target = period_targets(t);
            delta = sign(target - current_H);
            if delta == 0
                continue;   % zero-length leg, skip
            end
            [Hseg, Mseg] = solve_ja_monotonic(current_H, target, current_M, params, delta, opts);
            segments_H{end + 1} = Hseg;   %#ok<AGROW>
            segments_M{end + 1} = Mseg;   %#ok<AGROW>
            next_start_index = next_start_index + numel(Hseg) - 1;
            current_M = Mseg(end);
            current_H = target;
        end

        info.cycles_simulated = period;

        if stop_criterion == "Until convergence"
            rel_base = max(abs(previous_period_M), eps);
            if abs(current_M - previous_period_M) / rel_base < rel_tol
                info.converged = true;
                break;
            end
            previous_period_M = current_M;
        end
    end

    [Hmod, Mmod] = local_concat_segments(segments_H, segments_M);

    if isempty(Hmod)
        Hmod = Hstart;
        Mmod = current_M;
        branch_starts = 1;
    end

    info.branch_starts = branch_starts;

    % "Last period only" support: the last full period is the segment from the
    % last recorded period boundary through to the end of the trajectory.
    if info.cycles_simulated > 0 && ~isempty(branch_starts)
        info.tip_last_loop_starts = branch_starts(end);
        info.tip_ends = numel(Hmod);
    else
        info.tip_last_loop_starts = [];
        info.tip_ends = [];
    end
end

% -------------------------------------------------------------------------
function pv = local_period_vertices(orders, amplitudes, phases, N)
%LOCALPERIODVERTICES Field values at the local extrema of the periodic drive.
%   Returns the extrema in the order they are encountered as theta increases
%   from 0, using a dense grid over one period with cyclic neighbour tests so
%   extrema sitting on the 0/2*pi boundary are captured.
    theta = linspace(0, 2*pi, N + 1);
    theta = theta(1:end - 1);          % N points over [0, 2*pi)
    H = local_waveform(theta, orders, amplitudes, phases);

    prev_H = H([end, 1:end - 1]);       % cyclic shift (H at theta - dtheta)
    next_H = H([2:end, 1]);             % cyclic shift (H at theta + dtheta)

    is_max = (H > prev_H) & (H >= next_H);
    is_min = (H < prev_H) & (H <= next_H);
    is_vertex = is_max | is_min;

    pv = H(is_vertex);
    pv = pv(:);
end

% -------------------------------------------------------------------------
function H = local_waveform(theta, orders, amplitudes, phases)
    theta = theta(:).';
    H = zeros(size(theta));
    for j = 1:numel(orders)
        H = H + amplitudes(j) * sin(orders(j) * theta + phases(j));
    end
end

% -------------------------------------------------------------------------
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
