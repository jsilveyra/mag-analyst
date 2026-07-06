function [Hmod, Mmod, info] = solveJA_majorLoop_playground( ...
    Hstart, Mstart, HtipMajor, params, startMode, stopCriterion, repetitions, relTol, opts)
%SOLVEJA_MAJORLOOP_PLAYGROUND Simulate the Playground major loop history.
%
%   [Hmod, Mmod, info] = solveJA_majorLoop_playground(...)
%
%   The function returns the full concatenated history in the selected
%   driving field mode together with branch metadata in info.branchStarts.

    if nargin < 9 || isempty(opts)
        opts = [];
    end
    if nargin < 8 || isempty(relTol)
        relTol = 1e-3;
    end
    if nargin < 7 || isempty(repetitions)
        repetitions = 1;
    end

    startMode = string(startMode);
    stopCriterion = string(stopCriterion);
    HtipMajor = double(HtipMajor);
    repetitions = max(0, round(repetitions));
    relTol = max(relTol, 0);

    if ~(isscalar(HtipMajor) && isfinite(HtipMajor) && HtipMajor > 0)
        error('solveJA_majorLoop_playground:InvalidTipField', ...
            'HtipMajor must be a finite positive scalar.');
    end

    if contains(lower(startMode), "tip point")
        if ~(isscalar(Mstart) && isfinite(Mstart))
            error('solveJA_majorLoop_playground:InvalidInputs', ...
                'Tip-point starts require a finite Mstart value.');
        end
    else
        if ~(isscalar(Hstart) && isfinite(Hstart) && isscalar(Mstart) && isfinite(Mstart))
            error('solveJA_majorLoop_playground:InvalidInputs', ...
                'Hstart and Mstart must be finite scalars.');
        end
    end

    info = struct( ...
        'mode', "Major Loop", ...
        'startMode', startMode, ...
        'stopCriterion', stopCriterion, ...
        'cyclesSimulated', 0, ...
        'converged', false, ...
        'usedInitialMagnetization', false, ...
        'branchStarts', []);

    segmentsH = {};
    segmentsM = {};
    branchStarts = [];
    nextStartIndex = 1;

    delta0 = sign(HtipMajor - Hstart);
    if delta0 == 0
        delta0 = 1;
    end
    [Hinit, Minit] = solveJA_monotonic(Hstart, HtipMajor, Mstart, params, delta0, opts);
    segmentsH{end + 1} = Hinit; %#ok<AGROW>
    segmentsM{end + 1} = Minit; %#ok<AGROW>
    branchStarts(end + 1) = nextStartIndex; %#ok<AGROW>
    nextStartIndex = nextStartIndex + numel(Hinit) - 1;
    currentM = Minit(end);
    info.usedInitialMagnetization = contains(lower(startMode), "demagnetized");

    previousCycleEnd = currentM;
    maxCycles = max(100, repetitions);
    for cycle = 1:maxCycles
        if stopCriterion ~= "Until convergence" && cycle > repetitions
            break;
        end

        [Hleft, Mleft] = solveJA_monotonic(HtipMajor, -HtipMajor, currentM, params, -1, opts);
        [Hright, Mright] = solveJA_monotonic(-HtipMajor, HtipMajor, Mleft(end), params, +1, opts);

        segmentsH{end + 1} = Hleft; %#ok<AGROW>
        segmentsM{end + 1} = Mleft; %#ok<AGROW>
        branchStarts(end + 1) = nextStartIndex; %#ok<AGROW>
        nextStartIndex = nextStartIndex + numel(Hleft) - 1;

        segmentsH{end + 1} = Hright; %#ok<AGROW>
        segmentsM{end + 1} = Mright; %#ok<AGROW>
        branchStarts(end + 1) = nextStartIndex; %#ok<AGROW>
        nextStartIndex = nextStartIndex + numel(Hright) - 1;

        info.cyclesSimulated = cycle;
        currentM = Mright(end);

        if stopCriterion == "Until convergence"
            relBase = max(abs(previousCycleEnd), eps);
            if abs(currentM - previousCycleEnd) / relBase < relTol
                info.converged = true;
                break;
            end
            previousCycleEnd = currentM;
        end
    end

    [Hmod, Mmod] = localConcatSegments(segmentsH, segmentsM);

    if isempty(Hmod)
        Hmod = HtipMajor;
        Mmod = currentM;
        branchStarts = 1;
    end

    info.branchStarts = branchStarts;
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
