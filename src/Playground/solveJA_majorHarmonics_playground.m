function [Hmod, Mmod, info] = solveJA_majorHarmonics_playground( ...
    Hstart, Mstart, orders, amplitudes, phases, params, ...
    stopCriterion, repetitions, relTol, opts, samplesPerPeriod)
%SOLVEJA_MAJORHARMONICS_PLAYGROUND Simulate a major loop driven by a distorted
%   (harmonic) field in the Playground.
%
%   [Hmod, Mmod, info] = solveJA_majorHarmonics_playground( ...
%       Hstart, Mstart, orders, amplitudes, phases, params, ...
%       stopCriterion, repetitions, relTol, opts, samplesPerPeriod)
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
%   solveJA_monotonic. Harmonics add extra turning points inside each period,
%   producing minor loops nested inside the major loop.
%
%   The simulation starts at (Hstart, Mstart), bridges to the first turning
%   point, then repeats the per-period pattern of extrema for the requested
%   number of periods (or until the period-end magnetization converges).
%
%   info fields (consumed by PlaygroundUtils.get_simulation_curve):
%       mode                = "Major Loop Harmonics"
%       startMode/stopCriterion
%       cyclesSimulated     = number of full periods integrated
%       converged
%       branchStarts        = concatenated index at the start of each period
%       tipLastLoopStarts   = [start index of the last full period]
%       tipEnds             = [numel(Hmod)]  (so "Last period only" slices it)
%       vertices            = the per-period extrema field values used

    if nargin < 11 || isempty(samplesPerPeriod)
        samplesPerPeriod = 4000;
    end
    if nargin < 10
        opts = [];
    end
    if nargin < 9 || isempty(relTol)
        relTol = 1e-3;
    end
    if nargin < 8 || isempty(repetitions)
        repetitions = 1;
    end
    if isempty(opts)
        opts = odeset('RelTol', 1e-7, 'AbsTol', 1e-6);
    end

    stopCriterion = string(stopCriterion);
    repetitions   = max(0, round(repetitions));
    relTol        = max(relTol, 0);
    samplesPerPeriod = max(64, round(samplesPerPeriod));

    orders     = double(orders(:));
    amplitudes = double(amplitudes(:));
    phases     = double(phases(:));

    if ~(isscalar(Hstart) && isfinite(Hstart) && isscalar(Mstart) && isfinite(Mstart))
        error('solveJA_majorHarmonics_playground:InvalidInputs', ...
            'Hstart and Mstart must be finite scalars.');
    end
    if isempty(orders) || numel(orders) ~= numel(amplitudes) || numel(orders) ~= numel(phases)
        error('solveJA_majorHarmonics_playground:InvalidHarmonics', ...
            'orders, amplitudes and phases must be non-empty vectors of equal length.');
    end
    valid = isfinite(orders) & isfinite(amplitudes) & isfinite(phases) & orders >= 1;
    orders     = round(orders(valid));
    amplitudes = amplitudes(valid);
    phases     = phases(valid);
    if isempty(orders) || ~any(abs(amplitudes) > 0)
        error('solveJA_majorHarmonics_playground:InvalidHarmonics', ...
            'At least one harmonic with a non-zero amplitude and integer order >= 1 is required.');
    end

    info = struct( ...
        'mode', "Major Loop Harmonics", ...
        'startMode', "", ...
        'stopCriterion', stopCriterion, ...
        'cyclesSimulated', 0, ...
        'converged', false, ...
        'branchStarts', [], ...
        'tipLastLoopStarts', [], ...
        'tipEnds', [], ...
        'vertices', []);

    % --- per-period turning points (local extrema of the periodic waveform) ---
    pv = localPeriodVertices(orders, amplitudes, phases, samplesPerPeriod);
    info.vertices = pv;
    if numel(pv) < 2
        error('solveJA_majorHarmonics_playground:DegenerateWaveform', ...
            'The harmonic waveform has fewer than two turning points; check the amplitudes.');
    end

    segmentsH = {};
    segmentsM = {};
    branchStarts = [];
    nextStartIndex = 1;

    % --- bridge from the start point to the first turning point -------------
    delta0 = sign(pv(1) - Hstart);
    if delta0 == 0
        delta0 = sign(pv(2) - pv(1));
        if delta0 == 0, delta0 = 1; end
    end
    [Hseg, Mseg] = solveJA_monotonic(Hstart, pv(1), Mstart, params, delta0, opts);
    segmentsH{end + 1} = Hseg;   %#ok<AGROW>
    segmentsM{end + 1} = Mseg;   %#ok<AGROW>
    nextStartIndex = nextStartIndex + numel(Hseg) - 1;
    currentM = Mseg(end);
    currentH = pv(1);

    % Targets traversed within one period, starting and ending at pv(1):
    %   pv(2), pv(3), ..., pv(end), pv(1)
    periodTargets = [pv(2:end); pv(1)];

    previousPeriodM = currentM;
    maxPeriods = max(1, repetitions);
    if stopCriterion == "Until convergence"
        % With the convergence criterion, the simulation keeps going until
        % the magnetization at the period-start vertex stops changing from one
        % period to the next. This is a practical steady-state check for
        % periodic forcing: if the loop has settled, the next period is almost
        % identical to the previous one.
        maxPeriods = max(maxPeriods, 100);
    end

    for period = 1:maxPeriods
        if stopCriterion ~= "Until convergence" && period > repetitions
            break;
        end

        % index of the pv(1) boundary at which this period begins
        branchStarts(end + 1) = nextStartIndex; %#ok<AGROW>

        for t = 1:numel(periodTargets)
            target = periodTargets(t);
            delta = sign(target - currentH);
            if delta == 0
                continue;   % zero-length leg, skip
            end
            [Hseg, Mseg] = solveJA_monotonic(currentH, target, currentM, params, delta, opts);
            segmentsH{end + 1} = Hseg;   %#ok<AGROW>
            segmentsM{end + 1} = Mseg;   %#ok<AGROW>
            nextStartIndex = nextStartIndex + numel(Hseg) - 1;
            currentM = Mseg(end);
            currentH = target;
        end

        info.cyclesSimulated = period;

        if stopCriterion == "Until convergence"
            relBase = max(abs(previousPeriodM), eps);
            if abs(currentM - previousPeriodM) / relBase < relTol
                info.converged = true;
                break;
            end
            previousPeriodM = currentM;
        end
    end

    [Hmod, Mmod] = localConcatSegments(segmentsH, segmentsM);

    if isempty(Hmod)
        Hmod = Hstart;
        Mmod = currentM;
        branchStarts = 1;
    end

    info.branchStarts = branchStarts;

    % "Last period only" support: the last full period is the segment from the
    % last recorded period boundary through to the end of the trajectory.
    if info.cyclesSimulated > 0 && ~isempty(branchStarts)
        info.tipLastLoopStarts = branchStarts(end);
        info.tipEnds = numel(Hmod);
    else
        info.tipLastLoopStarts = [];
        info.tipEnds = [];
    end
end

% -------------------------------------------------------------------------
function pv = localPeriodVertices(orders, amplitudes, phases, N)
%LOCALPERIODVERTICES Field values at the local extrema of the periodic drive.
%   Returns the extrema in the order they are encountered as theta increases
%   from 0, using a dense grid over one period with cyclic neighbour tests so
%   extrema sitting on the 0/2*pi boundary are captured.
    theta = linspace(0, 2*pi, N + 1);
    theta = theta(1:end - 1);          % N points over [0, 2*pi)
    H = localWaveform(theta, orders, amplitudes, phases);

    prevH = H([end, 1:end - 1]);       % cyclic shift (H at theta - dtheta)
    nextH = H([2:end, 1]);             % cyclic shift (H at theta + dtheta)

    isMax = (H > prevH) & (H >= nextH);
    isMin = (H < prevH) & (H <= nextH);
    isVertex = isMax | isMin;

    pv = H(isVertex);
    pv = pv(:);
end

% -------------------------------------------------------------------------
function H = localWaveform(theta, orders, amplitudes, phases)
    theta = theta(:).';
    H = zeros(size(theta));
    for j = 1:numel(orders)
        H = H + amplitudes(j) * sin(orders(j) * theta + phases(j));
    end
end

% -------------------------------------------------------------------------
function [Hout, Mout] = localConcatSegments(segmentsH, segmentsM)
    Hout = [];
    Mout = [];
    for i = 1:numel(segmentsH)
        if isempty(Hout)
            Hout = segmentsH{i};
            Mout = segmentsM{i};
        else
            Hout = [Hout; segmentsH{i}(2:end)]; %#ok<AGROW>
            Mout = [Mout; segmentsM{i}(2:end)]; %#ok<AGROW>
        end
    end
end
