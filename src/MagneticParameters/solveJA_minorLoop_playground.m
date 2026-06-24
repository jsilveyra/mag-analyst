function [Hmod, Mmod, info] = solveJA_minorLoop_playground( ...
    Htips, params, stopCriterion, repetitions, relTol, opts)
%SOLVEJA_MINORLOOP_PLAYGROUND Simulate the Playground minor loop history.
%
%   [Hmod, Mmod, info] = solveJA_minorLoop_playground(...)
%
%   Htips is sorted ascending before the simulation starts.

    if nargin < 6 || isempty(opts)
        opts = [];
    end
    if nargin < 5 || isempty(relTol)
        relTol = 1e-3;
    end
    if nargin < 4 || isempty(repetitions)
        repetitions = 1;
    end

    stopCriterion = string(stopCriterion);
    repetitions = max(0, round(repetitions));
    relTol = max(relTol, 0);
    Htips = sort(double(Htips(:)), 'ascend');

    if isempty(Htips) || any(~isfinite(Htips)) || any(Htips <= 0)
        error('solveJA_minorLoop_playground:InvalidTipFields', ...
            'Htips must be a non-empty vector of finite positive values.');
    end

    info = struct( ...
        'mode', "Minor Loops", ...
        'stopCriterion', stopCriterion, ...
        'cyclesSimulated', 0, ...
        'converged', false, ...
        'branchStarts', [], ...
        'tipStarts', [], ...
        'tipEnds', [], ...
        'tipLastLoopStarts', []);

    segmentsH = {};
    segmentsM = {};
    branchStarts = [];
    nextStartIndex = 1;

    currentPositiveM = 0;
    previousPositiveTip = 0;

    for idxTip = 1:numel(Htips)
        Htip = Htips(idxTip);
        tipStartIndex = nextStartIndex;
        lastLoopStartIndex = tipStartIndex;

        if idxTip == 1
            [Hfirst, Mfirst] = solveJA_monotonic(0, Htip, 0, params, +1, opts);
            segmentsH{end + 1} = Hfirst; %#ok<AGROW>
            segmentsM{end + 1} = Mfirst; %#ok<AGROW>
            branchStarts(end + 1) = nextStartIndex; %#ok<AGROW>
            nextStartIndex = nextStartIndex + numel(Hfirst) - 1;
            currentPositiveM = Mfirst(end);
        else
            [Hbridge, Mbridge] = solveJA_monotonic(previousPositiveTip, Htip, currentPositiveM, params, +1, opts);
            segmentsH{end + 1} = Hbridge; %#ok<AGROW>
            segmentsM{end + 1} = Mbridge; %#ok<AGROW>
            branchStarts(end + 1) = nextStartIndex; %#ok<AGROW>
            nextStartIndex = nextStartIndex + numel(Hbridge) - 1;
            currentPositiveM = Mbridge(end);
        end

        previousCycleEnd = currentPositiveM;
        maxCycles = max(100, repetitions);
        for cycle = 1:maxCycles
            if stopCriterion ~= "Until convergence" && cycle > repetitions
                break;
            end

            lastLoopStartIndex = nextStartIndex;
            [Hleft, Mleft] = solveJA_monotonic(Htip, -Htip, currentPositiveM, params, -1, opts);
            [Hright, Mright] = solveJA_monotonic(-Htip, Htip, Mleft(end), params, +1, opts);

            segmentsH{end + 1} = Hleft; %#ok<AGROW>
            segmentsM{end + 1} = Mleft; %#ok<AGROW>
            branchStarts(end + 1) = nextStartIndex; %#ok<AGROW>
            nextStartIndex = nextStartIndex + numel(Hleft) - 1;

            segmentsH{end + 1} = Hright; %#ok<AGROW>
            segmentsM{end + 1} = Mright; %#ok<AGROW>
            branchStarts(end + 1) = nextStartIndex; %#ok<AGROW>
            nextStartIndex = nextStartIndex + numel(Hright) - 1;

            info.cyclesSimulated = info.cyclesSimulated + 1;
            currentPositiveM = Mright(end);

            if stopCriterion == "Until convergence"
                relBase = max(abs(previousCycleEnd), eps);
                if abs(currentPositiveM - previousCycleEnd) / relBase < relTol
                    info.converged = true;
                    break;
                end
                previousCycleEnd = currentPositiveM;
            end
        end

        previousPositiveTip = Htip;
        info.tipStarts(end + 1) = tipStartIndex; %#ok<AGROW>
        info.tipEnds(end + 1) = nextStartIndex - 1; %#ok<AGROW>
        info.tipLastLoopStarts(end + 1) = lastLoopStartIndex; %#ok<AGROW>
    end

    [Hmod, Mmod] = localConcatSegments(segmentsH, segmentsM);

    if isempty(Hmod)
        Hmod = Htips(1);
        Mmod = currentPositiveM;
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
