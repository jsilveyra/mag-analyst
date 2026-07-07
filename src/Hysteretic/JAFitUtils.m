classdef JAFitUtils
%JAFITUTILS  Static helpers for JAFitter parameter/bound packing and UI parsing.
%   packParams/unpackParams convert between a JA parameter struct (Ms, a,
%   alpha, c, k) and the flat vector used by the optimizer, per a fit mask.
%   packBounds builds matching lower/upper bound vectors from a Bounds
%   struct. readBoundFieldValue and makeBoundPair parse/assemble bound
%   values from app edit-field text.
    methods (Static)
        function [x, map] = packParams(p, mask)
            x = [];
            map = {};
            if mask.fitMs
                x(end+1,1) = p.Ms; %#ok<AGROW>
                map{end+1} = 'Ms'; %#ok<AGROW>
            end
            if mask.fita
                x(end+1,1) = p.a; %#ok<AGROW>
                map{end+1} = 'a'; %#ok<AGROW>
            end
            if mask.fitalpha
                x(end+1,1) = p.alpha; %#ok<AGROW>
                map{end+1} = 'alpha'; %#ok<AGROW>
            end
            if mask.fitc
                x(end+1,1) = p.c; %#ok<AGROW>
                map{end+1} = 'c'; %#ok<AGROW>
            end
            if isfield(mask, 'fitk') && mask.fitk
                x(end+1,1) = p.k; %#ok<AGROW>
                map{end+1} = 'k'; %#ok<AGROW>
            end
        end

        function [lb, ub] = packBounds(bounds, mask)
            lb = [];
            ub = [];
            paramOrder = {'Ms','a','alpha','c','k'};
            fitFlags = [mask.fitMs, mask.fita, mask.fitalpha, mask.fitc, isfield(mask,'fitk') && mask.fitk];
            for i = 1:numel(paramOrder)
                if fitFlags(i)
                    name = paramOrder{i};
                    if isempty(bounds.(name))
                        lb(end+1,1) = -Inf; %#ok<AGROW>
                        ub(end+1,1) = Inf; %#ok<AGROW>
                    else
                        lb(end+1,1) = bounds.(name)(1); %#ok<AGROW>
                        ub(end+1,1) = bounds.(name)(2); %#ok<AGROW>
                    end
                end
            end
        end

        function p = unpackParams(x, map, p_seed, mask, estimateKFn)
            p = p_seed;
            for i = 1:numel(x)
                pname = map{i};
                p.(pname) = x(i);
            end
            if isfield(mask, 'kDependent') && mask.kDependent
                p.k = estimateKFn(p);
            end
        end

        function [v, ok] = readBoundFieldValue(fieldHandle)
            v = fieldHandle.Value;
            if isempty(v)
                v = [];
                ok = true;
                return;
            end
            ok = isfinite(v) || isinf(v);
        end

        function b = makeBoundPair(lo, hi)
            if isempty(lo) && isempty(hi)
                b = [];
                return;
            end
            if isempty(lo), lo = -Inf; end
            if isempty(hi), hi = Inf; end
            b = [lo, hi];
        end
    end
end
