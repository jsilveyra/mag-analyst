classdef JAFitter
%JAFITTER  Static Jiles-Atherton parameter fitter.
%   JAFitter.fit(params_seed, mask, bounds, Hleft, Mleft, Htip, Mtip,
%   error_type, estimate_k_fn, model_fn, error_core_fn, output_fcn) packs the free
%   JA parameters (per mask) into a vector, minimizes an error function that
%   simulates the hysteretic left branch (via model_fn/solve_ja_monotonic) and
%   compares it to the measured Hleft/Mleft using error_core_fn, and returns a
%   result struct with params_opt, Jseed, Jopt, ok, error_message.
    methods (Static)
        function result = fit(params_seed, mask, bounds, Hleft, Mleft, Htip, Mtip, error_type, estimate_k_fn, model_fn, error_core_fn, output_fcn)
            BIG = 1e6;
            opts = odeset('RelTol', 1e-7, 'AbsTol', 1e-6);

            if nargin < 11 || isempty(model_fn)
                model_fn = @(params) solve_ja_monotonic(Htip, -Htip, Mtip, params, -1, opts);
            end
            if nargin < 12
                output_fcn = [];
            end

            result = struct( ...
                'ok', false, ...
                'params_opt', params_seed, ...
                'Jseed', BIG, ...
                'Jopt', BIG, ...
                'error_message', "");

            [x0, map] = JAFitUtils.pack_params(params_seed, mask);
            [lb, ub] = JAFitUtils.pack_bounds(bounds, mask);
            if any(lb > ub)
                result.error_message = "lower bound is greater than upper bound.";
                return;
            end

            function J = obj_fun(x)
                params = JAFitUtils.unpack_params(x, map, params_seed, mask, estimate_k_fn);
                if ~isfinite(params.k)
                    J = BIG; return;
                end
                if params.Ms <= 0 || params.a <= 0 || params.k <= 0 || params.c <= 0 || params.c >= 1
                    J = BIG; return;
                end
                try
                    [Hhat, Mhat] = model_fn(params);
                    [J, ok_J] = error_core_fn(error_type, Hleft, Mleft, Hhat, Mhat);
                    if ~ok_J, J = BIG; end
                catch
                    J = BIG;
                end
            end

            % Per-parameter O(1) scaling for minimize(), matching
            % Anhysteretic/fit_physical.m: Ms (~1e5), a (~1e1), alpha
            % (~1e-4), c (~1e-1), k (~1e2) span wildly different magnitudes,
            % so a single TolX/TolFun/initial step size cannot serve all of
            % them at once in raw physical units. scale/obj_fun_scaled are
            % only meaningful once x0 is known to be non-empty (see below);
            % nested functions must be declared at the function's top level
            % (not inside try/if), so this one is declared here but only
            % invoked from within the try block.
            scale = max(abs(x0), eps);

            function J = obj_fun_scaled(y)
                J = obj_fun(y .* scale);
            end

            try
                result.Jseed = obj_fun(x0);
                % Same optimizer settings regardless of mask.fitk, and matching
                % the Anhysteretic fit (fit.m) -- one consistent configuration
                % across every fit in the app, rather than per-case tuning.
                % One tight minimize() call per Fit click -- a loose-then-tight
                % two-stage scheme was tried and rejected; see the
                % matching comment in fit.m for why.
                optim_opts = optimset( ...
                    'MaxIter', 2000, ...
                    'MaxFunEvals', 1e4, ...
                    'TolX', 1e-5, ...
                    'TolFun', 1e-5, ...
                    'Display', 'off');
                if ~isempty(output_fcn)
                    optim_opts = optimset(optim_opts, 'OutputFcn', output_fcn);
                end

                if isempty(x0)
                    xopt = x0;
                    Jopt = result.Jseed;
                else
                    y0 = x0 ./ scale;

                    yb1 = lb ./ scale;
                    yb2 = ub ./ scale;
                    ylb = min(yb1, yb2);
                    yub = max(yb1, yb2);

                    % Cap the SCALED bound range (see
                    % minimize-and-parameter-scaling.md): minimize() maps a
                    % two-sided-bounded variable through
                    % asin(2*(y0-ylb)/(yub-ylb) - 1), which loses the seed
                    % to floating-point cancellation once yub-ylb is many
                    % orders of magnitude wider than the O(1) scaled seed
                    % (e.g. an unbounded field defaulting to +/-Inf, or a
                    % user-entered bound far wider than the parameter's own
                    % scale). A cap of 1e6 is still effectively unconstrained
                    % for any physically meaningful Ms/a/alpha/c/k value,
                    % while keeping the transform well-conditioned.
                    BOUND_CAP = 1e6;
                    ylb = max(ylb, -BOUND_CAP);
                    yub = min(yub, BOUND_CAP);

                    [yopt, Jopt] = minimize(@obj_fun_scaled, y0, [], [], [], [], ylb, yub, [], optim_opts);
                    xopt = yopt .* scale;

                    % Seed guard: never return a point worse than the seed
                    % (matches fit_physical.m).
                    if Jopt > result.Jseed
                        xopt = x0;
                        Jopt = result.Jseed;
                    end
                end

                result.params_opt = JAFitUtils.unpack_params(xopt, map, params_seed, mask, estimate_k_fn);
                result.Jopt = Jopt;
                result.ok = true;
            catch ME
                result.error_message = string(ME.message);
            end
        end
    end
end
