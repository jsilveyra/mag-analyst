function [Hmod, Mmod, info] = solveJA_hysteretic_region( ...
    Htip, Mtip, params, startMode, fittingRegion, stopCriterion, repetitions, relTol, maxRepetitions, opts)
%SOLVEJA_HYSTERETIC_REGION Solve the JA model for a selected hysteretic fitting region.
%
%   [Hmod, Mmod, info] = solveJA_hysteretic_region(...)
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
    if nargin < 9 || isempty(maxRepetitions)
        maxRepetitions = 10;
    end
    if nargin < 8 || isempty(relTol)
        relTol = 1e-3;
    end
    if nargin < 7 || isempty(repetitions)
        repetitions = 1;
    end

    startMode = string(startMode);
    fittingRegion = string(fittingRegion);
    stopCriterion = string(stopCriterion);

    info = struct( ...
        'startingPoint', startMode, ...
        'fittingRegion', fittingRegion, ...
        'stopCriterion', stopCriterion, ...
        'cyclesSimulated', 0, ...
        'converged', false, ...
        'usedInitialMagnetization', false);

    if fittingRegion == "Left branch only"
        [Hfull, Mfull] = solveJA_fromTip(Htip, Mtip, params, opts);
        minIndex = find(Hfull == min(Hfull), 1, 'first');
        if isempty(minIndex)
            minIndex = numel(Hfull);
        end
        Hmod = Hfull(1:minIndex);
        Mmod = Mfull(1:minIndex);
        info.cyclesSimulated = 1;
        return;
    end

    repetitions = max(1, round(repetitions));
    maxRepetitions = max(1, round(maxRepetitions));
    relTol = max(relTol, 0);

    if contains(lower(startMode), "demagnetized")
        [~, Minit] = solveJA_monotonic(0, Htip, 0, params, +1, opts);
        prevM = Minit(end);
        info.usedInitialMagnetization = true;
    else
        prevM = Mtip;
    end

    if stopCriterion == "Until convergence"
        nCycles = maxRepetitions;
    else
        nCycles = repetitions;
    end

    Hmod = [];
    Mmod = [];
    for cycle = 1:nCycles
        [Hleft, Mleft] = solveJA_monotonic(Htip, -Htip, prevM, params, -1, opts);
        [Hright, Mright] = solveJA_monotonic(-Htip, Htip, Mleft(end), params, +1, opts);

        Hmod = [Hleft; Hright(2:end)];
        Mmod = [Mleft; Mright(2:end)];
        info.cyclesSimulated = cycle;

        if stopCriterion == "Until convergence"
            relBase = max(abs(Mleft(1)), eps);
            if abs(Mright(end) - Mleft(1)) <= relTol * relBase
                info.converged = true;
                break;
            end
        end

        prevM = Mright(end);
    end
end
