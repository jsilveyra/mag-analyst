function [Hmod, Mmod, info] = solveJA_degaussing_playground( ...
    Hstart, Mstart, amplitudes, params, opts)
%SOLVEJA_DEGAUSSING_PLAYGROUND Simulate the Playground degaussing history.
%
%   [Hmod, Mmod, info] = solveJA_degaussing_playground( ...
%       Hstart, Mstart, amplitudes, params, opts)
%
%   Starting from the state (Hstart, Mstart), the sample is driven through a
%   sequence of field reversals of monotonically decreasing peak amplitude
%   (the classic AC demagnetization / degaussing envelope) and is finally
%   brought back to H = 0. Each monotonic field sweep is integrated with the
%   Jiles-Atherton ODE through solveJA_monotonic.
%
%   Inputs
%     Hstart, Mstart : starting point of the path (field and magnetization).
%     amplitudes     : vector of positive peak field amplitudes. They are
%                      sorted in *descending* order (largest reversal first),
%                      so that they form a decaying degaussing envelope
%                      regardless of the order given.
%     params         : struct with JA parameters {Ms, a, alpha, k, c}.
%     opts           : odeset options forwarded to solveJA_monotonic
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
        error('solveJA_degaussing_playground:InvalidAmplitudes', ...
            'amplitudes must contain at least one finite positive value.');
    end
    if ~isfinite(Hstart) || ~isfinite(Mstart)
        error('solveJA_degaussing_playground:InvalidStart', ...
            'Hstart and Mstart must be finite.');
    end

    info = struct( ...
        'mode', "Degaussing", ...
        'amplitudes', amplitudes(:).', ...
        'cyclesSimulated', 0, ...
        'converged', false, ...
        'branchStarts', [], ...
        'tipStarts', [], ...
        'tipEnds', [], ...
        'tipLastLoopStarts', [], ...
        'Hfinal', NaN, ...
        'Mfinal', NaN);

    % Sign of the first reversal: drive the field opposite to the starting
    % magnetization so the very first (largest) swing overcomes it.
    firstSign = -sign(Mstart);
    if firstSign == 0
        firstSign = -1;
    end

    % Target fields: alternating, decaying peaks, then back to zero.
    nAmp = numel(amplitudes);
    targets = zeros(nAmp + 1, 1);
    for i = 1:nAmp
        targets(i) = firstSign * (-1)^(i - 1) * amplitudes(i);
    end
    targets(nAmp + 1) = 0;   % final sweep to the demagnetized field

    segmentsH = {};
    segmentsM = {};
    branchStarts = [];
    nextStartIndex = 1;

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

        [Hseg, Mseg] = solveJA_monotonic(Hcur, Htarget, Mcur, params, delta, opts);

        segmentsH{end + 1} = Hseg; %#ok<AGROW>
        segmentsM{end + 1} = Mseg; %#ok<AGROW>
        branchStarts(end + 1) = nextStartIndex; %#ok<AGROW>
        nextStartIndex = nextStartIndex + numel(Hseg) - 1;

        Hcur = Htarget;
        Mcur = Mseg(end);
    end

    [Hmod, Mmod] = localConcatSegments(segmentsH, segmentsM);

    if isempty(Hmod)
        % Nothing to integrate (all legs degenerate): return the start point.
        Hmod = Hstart;
        Mmod = Mstart;
        branchStarts = 1;
    end

    info.branchStarts = branchStarts;
    info.Hfinal = Hmod(end);
    info.Mfinal = Mmod(end);
end

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
