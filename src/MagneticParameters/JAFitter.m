classdef JAFitter
    methods (Static)
        function result = fit(params_seed, mask, bounds, Hleft, Mleft, Htip, Mtip, error_type, estimateKFn, modelFn, errorCoreFn, outputFcn)
            BIG = 1e6;
            opts = odeset('RelTol', 1e-7, 'AbsTol', 1e-6);

            if nargin < 11 || isempty(modelFn)
                modelFn = @(params) solveJA_monotonic(Htip, -Htip, Mtip, params, -1, opts);
            end
            if nargin < 12
                outputFcn = [];
            end

            result = struct( ...
                'ok', false, ...
                'params_opt', params_seed, ...
                'Jseed', BIG, ...
                'Jopt', BIG, ...
                'errorMessage', "");

            [x0, map] = JAFitUtils.packParams(params_seed, mask);
            [lb, ub] = JAFitUtils.packBounds(bounds, mask);
            if any(lb > ub)
                result.errorMessage = "lower bound is greater than upper bound.";
                return;
            end

            function J = objFun(x)
                params = JAFitUtils.unpackParams(x, map, params_seed, mask, estimateKFn);
                if ~isfinite(params.k)
                    J = BIG; return;
                end
                if params.Ms <= 0 || params.a <= 0 || params.k <= 0 || params.c <= 0 || params.c >= 1
                    J = BIG; return;
                end
                try
                    [Hhat, Mhat] = modelFn(params);
                    [J, okJ] = errorCoreFn(error_type, Hleft, Mleft, Hhat, Mhat);
                    if ~okJ, J = BIG; end
                catch
                    J = BIG;
                end
            end

            try
                result.Jseed = objFun(x0);
                if mask.fitk
                    optimOpts = optimset( ...
                        'MaxIter', 500, ...
                        'MaxFunEvals', 4000, ...
                        'TolX', 1e-5, ...
                        'TolFun', 1e-5, ...
                        'Display', 'off');
                else
                    optimOpts = optimset( ...
                        'MaxIter', 1000, ...
                        'MaxFunEvals', 1e4, ...
                        'TolX', 1e-5, ...
                        'TolFun', 1e-5, ...
                        'Display', 'off');
                end
                if ~isempty(outputFcn)
                    optimOpts = optimset(optimOpts, 'OutputFcn', outputFcn);
                end

                if isempty(x0)
                    xopt = x0;
                    Jopt = result.Jseed;
                else
                    [xopt_1, Jopt_1] = minimize(@objFun, x0, [], [], [], [], lb, ub, [], optimOpts);
                    if mask.fitk
                        xopt = xopt_1;
                        Jopt = Jopt_1;
                    else
                        [xopt, Jopt] = minimize(@objFun, xopt_1, [], [], [], [], lb, ub, [], optimOpts);
                    end
                end

                result.params_opt = JAFitUtils.unpackParams(xopt, map, params_seed, mask, estimateKFn);
                result.Jopt = Jopt;
                result.ok = true;
            catch ME
                result.errorMessage = string(ME.message);
            end
        end
    end
end
