classdef JAFitter
%JAFITTER  Static Jiles-Atherton parameter fitter.
%   JAFitter.fit(params_seed, mask, bounds, Hleft, Mleft, Htip, Mtip,
%   error_type, estimate_k_fn, model_fn, error_core_fn, output_fcn, solver)
%   packs the free JA parameters (per mask) into a vector, minimizes an error
%   function that simulates the hysteretic left branch (via
%   model_fn/solve_ja_monotonic) and compares it to the measured Hleft/Mleft
%   using error_core_fn, and returns a result struct with params_opt, Jseed,
%   Jopt, ok, error_message. solver selects the optimizer ("nelder_mead"
%   [default] or "prima"; see SolverUtils.minimize_bounded). scale_by_seed
%   (default true) divides each free parameter by its seed so the solver
%   works on O(1) variables; false hands the solver the raw physical values
%   (as in Conde Garrido et al., IEEE TMAG 2026) -- an experiment switch,
%   not exposed in the GUI. solver_options (struct, optional) is passed to
%   SolverUtils.minimize_bounded to override individual solver settings
%   (rhobeg/rhoend/npt/maxfun for "prima", TolX/TolFun/MaxIter/MaxFunEvals
%   for "nelder_mead"); same purpose.
    methods (Static)
        function result = fit(params_seed, mask, bounds, Hleft, Mleft, Htip, Mtip, error_type, estimate_k_fn, model_fn, error_core_fn, output_fcn, solver, scale_by_seed, solver_options)
            BIG = 1e6;
            opts = odeset('RelTol', 1e-7, 'AbsTol', 1e-6);

            if nargin < 11 || isempty(model_fn)
                model_fn = @(params) solve_ja_monotonic(Htip, -Htip, Mtip, params, -1, opts);
            end
            if nargin < 12
                output_fcn = [];
            end
            if nargin < 13
                solver = "nelder_mead";
            end
            if nargin < 14 || isempty(scale_by_seed)
                scale_by_seed = true;
            end
            if nargin < 15 || isempty(solver_options)
                solver_options = struct();
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
                % When k is derived from Hc (mask.k_dependent) rather than
                % searched over directly, it never goes through the
                % optimizer's own lb/ub -- so a derived k landing outside
                % the user's k bounds would otherwise pass silently. Reject
                % it here instead, for every solver (this obj_fun is what
                % both "prima" and "nelder_mead" minimize, and it's also
                % what computes Jseed above).
                if isfield(mask, 'k_dependent') && mask.k_dependent && isfield(bounds, 'k') && ~isempty(bounds.k)
                    if params.k < bounds.k(1) || params.k > bounds.k(2)
                        J = BIG; return;
                    end
                end
                try
                    [Hhat, Mhat] = model_fn(params);
                    [J, ok_J] = error_core_fn(error_type, Hleft, Mleft, Hhat, Mhat);
                    if ~ok_J, J = BIG; end
                catch
                    J = BIG;
                end
            end

            % Per-parameter O(1) scaling for the solver, matching
            % Anhysteretic/fit_physical.m: Ms (~1e5), a (~1e1), alpha
            % (~1e-4), c (~1e-1), k (~1e2) span wildly different magnitudes,
            % so a single TolX/TolFun/initial step size cannot serve all of
            % them at once in raw physical units. scale/obj_fun_scaled are
            % only meaningful once x0 is known to be non-empty (see below);
            % nested functions must be declared at the function's top level
            % (not inside try/if), so this one is declared here but only
            % invoked from within the try block.
            if scale_by_seed
                scale = max(abs(x0), eps);
            else
                scale = ones(size(x0));
            end

            function J = obj_fun_scaled(y)
                J = obj_fun(y .* scale);
            end

            try
                result.Jseed = obj_fun(x0);
                % Same optimizer settings regardless of mask.fitk, and matching
                % the Anhysteretic fit (fit.m) -- one consistent configuration
                % across every fit in the app, rather than per-case tuning.
                % One tight solver call per Fit click; see the matching
                % comment in fit.m for why.

                if isempty(x0)
                    xopt = x0;
                    Jopt = result.Jseed;
                else
                    y0 = x0 ./ scale;

                    yb1 = lb ./ scale;
                    yb2 = ub ./ scale;
                    ylb = min(yb1, yb2);
                    yub = max(yb1, yb2);

                    % Infinite bounds are passed to the solver as they are.
                    % Until 2026-09-19 they were capped at +/-1e6 (scaled
                    % units) "to keep minimize()'s transform well
                    % conditioned", which did the opposite: a one-sided
                    % bound such as Ms >= Mtip became the two-sided
                    % [0.9, 1e6], which minimize() maps through
                    % asin(2*(y-lb)/(ub-lb) - 1) ~ asin(-1), the singular
                    % end of the arcsine, so Nelder-Mead's first step threw
                    % Ms hundreds of times off and the fit stalled near the
                    % seed (Jiles 1992 synthetic loop: c 0.33, k 672
                    % instead of 0.1, 500). Left infinite, minimize() uses
                    % its sqrt transform for one-sided bounds and no
                    % transform for unbounded ones, and the same fit
                    % recovers the ground truth (J ~ 1e-6). BOBYQA handles
                    % infinite bounds natively.

                    scaled_output_fcn = [];
                    if ~isempty(output_fcn)
                        % Hand the tracker unscaled (physical) points -- the
                        % caller's output_fcn (app.fit_stop_output_fcn) feeds
                        % FitProgressUtils, whose tracked "best point" is
                        % later unpacked as if it were physical params
                        % (see HystereticUtils.m). Without this wrapper the
                        % tracker instead sees x0/scale-normalized O(1)
                        % values (e.g. c could read >1), which are wrong by
                        % orders of magnitude and can fail downstream
                        % physical-sanity checks -- silently dropping the
                        % modeled curve with no error message. Matches the
                        % same wrapper in fit_physical.m.
                        scaled_output_fcn = @(y, optimValues, state) output_fcn(y .* scale, optimValues, state);
                    end
                    [yopt, Jopt] = SolverUtils.minimize_bounded(@obj_fun_scaled, y0, ylb, yub, scaled_output_fcn, solver, solver_options);
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
