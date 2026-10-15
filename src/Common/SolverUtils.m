classdef SolverUtils
%SOLVERUTILS  Solver choice shared by the Anhysteretic and Hysteretic fitting
%   tabs: dispatches a bound-constrained minimization to either PRIMA-BOBYQA
%   (tuned npt, src/lib/bobyqa_mat/bobyqa_mat_tuned.m) or Nelder-Mead via
%   minimize() (src/lib/minimize), maps the fitting tabs' "Solver" and
%   "Significant digits" dropdown texts to what each fit call site (fit.m,
%   fit_physical.m, JAFitter.m) expects, and provides the lattice polish
%   (lattice_polish) every fit runs after its solver so that the fitted
%   parameters are exactly the numbers with the chosen number of
%   significant digits, and locally optimal among them.

    methods (Static)
        function code = solver_code_from_dropdown(value)
            %SOLVER_CODE_FROM_DROPDOWN Map a SolverDropDown/SolverDropDown_2
            %   Value string to "prima", "nelder_mead" or "dfols" (DFO-LS,
            %   offered only by the Hysteretic tab). Falls back to
            %   "prima" (the default: on the Jiles 1992 synthetic loop and
            %   the three published loops of the LMAG 2026 manuscript both
            %   solvers reached the same lattice points after polishing,
            %   BOBYQA in the shortest total time on every loop,
            %   2026-09-21) for any unrecognised value.
            switch string(value)
                case {"Nelder-Mead", "Nelder-Mead (minimize lib)"}
                    code = "nelder_mead";
                case "DFO-LS"
                    code = "dfols";
                otherwise
                    code = "prima";
            end
        end

        function n_sig = n_sig_from_dropdown(value)
            %N_SIG_FROM_DROPDOWN Map a "Significant digits" dropdown Value
            %   ('3', '4', '5', '6' or 'Full precision') to the number of
            %   significant digits the fitted parameters are polished to
            %   (Inf = no polish, full double precision). Unrecognised
            %   values give 3, the GUI default.
            v = strtrim(string(value));
            if strcmpi(v, "Full precision")
                n_sig = Inf;
            else
                n_sig = str2double(v);
                if ~isfinite(n_sig) || n_sig < 1
                    n_sig = 3;
                end
                n_sig = round(n_sig);
            end
        end

        function [x, fval, info] = lattice_polish(obj, x0, n_sig, opts)
            %LATTICE_POLISH  Local search on the lattice of n_sig-digit numbers.
            %   [x, fval, info] = lattice_polish(obj, x0, n_sig, opts) rounds
            %   x0 to n_sig significant digits per component and then
            %   improves obj on that lattice by direct search: at each
            %   iteration the 1-change neighbourhood (each component +/- one
            %   unit in its last significant digit) is evaluated and the best
            %   improving point taken; when none improves, the 2-change
            %   neighbourhood (every pair of components, +/- one unit each),
            %   and when that fails too, the extended pairs (steps of two
            %   units), which follow a curved valley whose floor runs
            %   between lattice points. The search stops when a full sweep
            %   of all three finds nothing better (info.certified = true),
            %   when the current value reaches opts.fmin, below which obj
            %   cannot go (certified at once: no neighbour can be better),
            %   or after opts.max_evals trial points (info.capped = true).
            %
            %   Every lattice point evaluated is cached, so a point that
            %   comes back in a later neighbourhood (e.g. the previous
            %   iterate, one step back) is not integrated again. The budget
            %   counts trial points visited, cached or not (info.visits), so
            %   the cache and the fmin stop change only the number of real
            %   evaluations (info.evals), never the path of the search or
            %   its result (2026-09-25; before that date both counts were
            %   the same number).
            %
            %   This is the local search of Kodek and Steiglitz for
            %   finite-wordlength filter design (IEEE Trans. Circuits Syst.
            %   28, 28, 1981: round the continuous optimum, then explore its
            %   1- and 2-change neighbourhoods) and the poll step at minimal
            %   granularity of mesh adaptive direct search (Audet, Le
            %   Digabel and Tribes, SIAM J. Optim. 29, 1164, 2019, "granular
            %   variables"). Best-improvement rather than first-improvement:
            %   on the Jiles 1992 synthetic loop the exact ground truth was
            %   a 1-change neighbour of the rounded start, and a randomly
            %   ordered first-improvement walk stepped away from it
            %   (2026-09-21).
            %
            %   obj(x) must return +Inf (or any non-finite/huge value) for
            %   points it cannot evaluate; such points are never accepted.
            %   x0 is in the same (physical, unscaled) units as x: the
            %   lattice is defined on the values a user reads and types.
            %   opts fields (all optional): max_evals (default 300; trial
            %   points visited, see above), fmin (default 0: every
            %   objective in the app is a root-mean-square distance; pass
            %   -Inf for an objective that can be negative),
            %   output_fcn (stop = output_fcn(x, optimValues, 'iter'), called
            %   after every accepted move; true aborts, info.stopped = true),
            %   extended (default true: poll the +/-2 pairs), fixed (logical
            %   mask of components that are neither rounded nor moved, e.g.
            %   parameters the user chose not to fit), lb/ub (bounds; points
            %   outside are skipped), full (any struct describing the
            %   solver's full-precision result, stored as info.full for
            %   reports that compare it with the polished one).
            if nargin < 4 || isempty(opts), opts = struct(); end
            t_polish = tic;
            max_evals = SolverUtils.opt(opts, 'max_evals', 300);
            fmin = SolverUtils.opt(opts, 'fmin', 0);
            output_fcn = SolverUtils.opt(opts, 'output_fcn', []);
            extended = SolverUtils.opt(opts, 'extended', true);
            x0 = x0(:);
            n = numel(x0);
            fixed = logical(SolverUtils.opt(opts, 'fixed', false(n, 1))); fixed = fixed(:);
            lb = SolverUtils.opt(opts, 'lb', -Inf(n, 1)); lb = lb(:);
            ub = SolverUtils.opt(opts, 'ub', Inf(n, 1)); ub = ub(:);
            x = x0;
            x(~fixed) = SolverUtils.round_sig(x0(~fixed), n_sig);
            % lattice values are canonical (round_sig after every step), so
            % the printed digits identify a point exactly
            cache = containers.Map('KeyType', 'char', 'ValueType', 'double');
            key = @(v) sprintf('%.17g,', v);
            fval = obj(x);
            cache(key(x)) = fval;
            info = struct('n_sig', n_sig, 'x_start', x, 'fval_start', fval, ...
                'start_feasible', isfinite(fval), 'moves', 0, 'evals', 1, 'visits', 1, 'sweeps', 0, ...
                'certified', false, 'capped', false, 'stopped', false, ...
                'full', SolverUtils.opt(opts, 'full', struct('x', x0)));
            % neighbourhoods as integer offsets (rows), in last-digit units,
            % over the free components only
            free = find(~fixed);
            if isempty(free) || ~isfinite(n_sig)
                info.certified = isfinite(fval);
                info.x = x; info.fval = fval; info.time_s = toc(t_polish);
                SolverUtils.last_polish_info(info);
                return;
            end
            E = eye(n);
            N1 = [E(free, :); -E(free, :)];
            if numel(free) < 2
                pairs = zeros(0, 2);
            else
                pairs = nchoosek(free(:)', 2);
            end
            N2 = zeros(0, n); N2x = zeros(0, n);
            for r = 1:size(pairs, 1)
                for si = [-2 -1 1 2]
                    for sj = [-2 -1 1 2]
                        d = zeros(1, n); d(pairs(r, 1)) = si; d(pairs(r, 2)) = sj;
                        if abs(si) == 1 && abs(sj) == 1
                            N2(end + 1, :) = d; %#ok<AGROW>
                        else
                            N2x(end + 1, :) = d; %#ok<AGROW>
                        end
                    end
                end
            end
            if extended
                levels = {N1, N2, N2x};
            else
                levels = {N1, N2};
            end
            while true
                if isfinite(fval) && fval <= fmin
                    % nothing on the lattice can be lower: certified as is
                    info.certified = true;
                    break;
                end
                if info.visits >= max_evals
                    info.capped = true;
                    break;
                end
                info.sweeps = info.sweeps + 1;
                moved = false;
                for L = 1:numel(levels)
                    D = levels{L};
                    best_f = fval; best_x = [];
                    for r = 1:size(D, 1)
                        y = SolverUtils.lattice_step(x, D(r, :), n_sig);
                        if any(y < lb) || any(y > ub), continue; end
                        k = key(y);
                        if isKey(cache, k)
                            fy = cache(k);
                        else
                            fy = obj(y);
                            cache(k) = fy;
                            info.evals = info.evals + 1;
                        end
                        info.visits = info.visits + 1;
                        if isfinite(fy) && fy < best_f
                            best_f = fy; best_x = y;
                        end
                        if info.visits >= max_evals, break; end
                    end
                    if ~isempty(best_x)
                        x = best_x; fval = best_f; moved = true;
                        info.moves = info.moves + 1;
                        if ~isempty(output_fcn)
                            ov = struct('fval', fval, 'iteration', info.moves, 'funccount', info.evals);
                            if output_fcn(x, ov, 'iter')
                                info.stopped = true;
                                info.x = x; info.fval = fval; info.time_s = toc(t_polish);
                                SolverUtils.last_polish_info(info);
                                return;
                            end
                        end
                        break;   % any move: back to the 1-change neighbourhood
                    end
                    if info.visits >= max_evals, break; end
                end
                if ~moved
                    info.certified = isfinite(fval) && info.visits < max_evals;
                    if info.visits >= max_evals, info.capped = true; end   % budget hit inside the last sweep
                    break;
                end
            end
            if info.capped, info.certified = false; end
            info.x = x; info.fval = fval; info.time_s = toc(t_polish);
            SolverUtils.last_polish_info(info);
        end

        function info = last_polish_info(set_value)
            %LAST_POLISH_INFO Info struct of the last lattice_polish call in
            %   this session (for scripts that drive the app headlessly);
            %   called with an argument by lattice_polish to store it.
            persistent stored
            if nargin > 0
                stored = set_value;
            end
            info = stored;
            if isempty(info), info = struct(); end
        end

        function y = lattice_step(x, d, n_sig)
            %LATTICE_STEP  x moved by d units of the last significant digit
            %   of each component (d integer vector), re-rounded so the
            %   result stays on the lattice when a value crosses a decade.
            y = x;
            for i = find(d(:)')
                v = x(i);
                if v == 0
                    ulp = 10^(-n_sig);
                else
                    ulp = 10^(floor(log10(abs(v))) - n_sig + 1);
                end
                y(i) = SolverUtils.round_sig(v + d(i)*ulp, n_sig);
            end
        end

        function y = round_sig(x, n_sig)
            %ROUND_SIG  Round to n_sig significant digits (Inf: unchanged).
            if ~isfinite(n_sig)
                y = x;
            else
                y = round(x, n_sig, 'significant');
            end
        end

        function msg = polish_summary(info)
            %POLISH_SUMMARY One-line Messages-panel text for a lattice_polish
            %   info struct.
            msg = sprintf("Parameters polished to %d significant digits: %d move(s) in %d evaluations", ...
                info.n_sig, info.moves, info.evals);
            if isfield(info, 'stopped') && info.stopped
                msg = msg + " (stopped by user)";
            elseif isfield(info, 'capped') && info.capped
                msg = msg + " (evaluation budget reached; not certified as a lattice optimum)";
            elseif isfield(info, 'certified') && info.certified
                msg = msg + " (no better neighbour on the lattice)";
            end
            if isfield(info, 'start_feasible') && ~info.start_feasible
                msg = msg + "; the plainly rounded parameters could not be evaluated";
            end
            msg = string(msg);
        end

        function v = opt(s, name, default)
            if isfield(s, name) && ~isempty(s.(name))
                v = s.(name);
            else
                v = default;
            end
        end

        function [x, fval] = minimize_bounded(obj, x0, lb, ub, output_fcn, solver, solver_options)
            %MINIMIZE_BOUNDED  Minimize obj(x) subject to lb <= x <= ub,
            %   starting from x0, using the solver named by `solver`
            %   ("prima" [default] or "nelder_mead"). output_fcn, if
            %   non-empty, is called after every function evaluation as
            %   stop = output_fcn(x, optimValues, state) (optimset
            %   convention); returning true aborts the fit early and the
            %   best point evaluated so far is returned. solver_options
            %   (struct, optional) overrides individual solver settings:
            %   rhobeg/rhoend/npt/maxfun for "prima", TolX/TolFun/MaxIter/
            %   MaxFunEvals for "nelder_mead" -- a tuning hook for scripts,
            %   not used by the GUI.
            if nargin < 6 || isempty(solver)
                solver = "prima";
            end
            if nargin < 7 || isempty(solver_options)
                solver_options = struct();
            end
            % Count objective evaluations (readable afterwards through
            % SolverUtils.last_eval_count). minimize()'s OutputFcn fires
            % once per ITERATION and BOBYQA's once per evaluation, so the
            % progress tracker's history is not a comparable count.
            n_evals = 0;
            function y = counted_obj(x_)
                n_evals = n_evals + 1;
                y = obj(x_);
            end
            function r_ = counted_res(x_)
                n_evals = n_evals + 1;
                r_ = solver_options.residual_fun(x_);
            end
            % "dfols": DFO-LS (src/Common/dfols_mat.m), a Gauss-Newton trust
            % region on the vector of per-point residuals whose root mean
            % square is obj -- solver_options.residual_fun, which every fit
            % supplies since 2026-09-25 (JAFitter, fit.m, fit_physical.m:
            % the metric's per-point residuals, ErrorCalculator.get_residuals).
            % Without it (a caller that passes none) "dfols" runs BOBYQA.
            if strcmp(solver, "dfols") && isfield(solver_options, 'residual_fun')
                [x, fval] = dfols_mat(@counted_res, x0, lb, ub, output_fcn);
                SolverUtils.last_eval_count(n_evals);
                SolverUtils.note_eval_limit(n_evals, 400 * (numel(x0) + 1));   % dfols_mat's maxfun
                return;
            end
            if strcmp(solver, "nelder_mead")
                % TolX acts on the seed-scaled variables (~1e-5 relative);
                % TolFun is absolute on the objective (an RMS of normalized
                % distances). Checked 2026-09-19 on the Jiles 1992 synthetic
                % loop: lowering TolFun to 1e-8 changed nothing (same 207
                % evaluations, same point), the stop is TolX.
                options = optimset('MaxIter', 2000, 'MaxFunEvals', 1e4, ...
                    'TolX', 1e-5, 'TolFun', 1e-5, 'Display', 'off');
                for f = intersect(fieldnames(solver_options)', {'TolX', 'TolFun', 'MaxIter', 'MaxFunEvals'})
                    options = optimset(options, f{1}, solver_options.(f{1}));
                end
                if ~isempty(output_fcn)
                    options = optimset(options, 'OutputFcn', output_fcn);
                end
                [x, fval] = minimize(@counted_obj, x0, [], [], [], [], lb, ub, [], options);
                SolverUtils.note_eval_limit(n_evals, optimget(options, 'MaxFunEvals'));
            else
                % rhoend is relative to the seed-scaled variables. 1e-4
                % since 2026-09-19 (was 1e-6): the objective is evaluated
                % through an adaptive ODE integration at RelTol 1e-7, whose
                % step-sequence noise makes parameter changes below ~1e-4
                % relative unresolvable, so the last radius reductions were
                % spent on noise -- same fitted parameters on the four LMAG
                % 2026 benchmark loops, 10-50 % fewer evaluations.
                prima_options = struct('rhoend', 1e-4);
                for f = intersect(fieldnames(solver_options)', {'rhobeg', 'rhoend', 'npt', 'maxfun'})
                    prima_options.(f{1}) = solver_options.(f{1});
                end
                % BOBYQA minimizes the SQUARE of the objective. Every fit
                % objective in the app is a root-mean-square distance, i.e.
                % the norm of a residual vector: near its minimum it is a
                % cone (kinked, like |x|), not a bowl, and a quadratic
                % interpolation model of a cone predicts steps that fail,
                % so the trust region collapses and the solver stops early.
                % obj^2 is a sum of squares, smooth at the minimum, with the
                % same arg min. Checked 2026-09-19 on the Jiles 1992
                % synthetic loop: from the point where the plain objective
                % stalled (c 0.18, k 547; truth 0.1, 500), the squared one
                % recovered all five parameters in 291 evaluations.
                % Nelder-Mead is comparison-based and gains nothing from
                % the transform, so it keeps the plain objective. The
                % square is undone before anything leaves this function:
                % the progress tracker and the returned fval see obj, not
                % obj^2. Penalty values (1e6) square to 1e12, still finite.
                if ~isempty(output_fcn)
                    prima_options.output_fcn = @(x_, ov, state) output_fcn(x_, ...
                        setfield(ov, 'fval', sqrt(max(ov.fval, 0))), state);
                end
                [x, fval2] = bobyqa_mat_tuned(@(x_) counted_obj(x_).^2, x0, lb, ub, prima_options);
                fval = sqrt(max(fval2, 0));
                SolverUtils.note_eval_limit(n_evals, SolverUtils.opt(prima_options, 'maxfun', 400 * (numel(x0) + 1)));
            end
            SolverUtils.last_eval_count(n_evals);
        end

        function [x, fval] = minimize_bounded_free(obj, x0, lb, ub, free, output_fcn, solver, solver_options)
            %MINIMIZE_BOUNDED_FREE  minimize_bounded over the FREE entries
            %   of x0 only. free (logical, one entry per parameter) marks the
            %   parameters to optimize; the others are held exactly at x0
            %   and are not passed to the solver. obj, output_fcn and
            %   solver_options.residual_fun keep seeing full vectors (same
            %   orientation as x0), so callers and the fit-progress tracker
            %   are unchanged. Before 2026-10-03 held parameters were passed
            %   to the solver inside a +/-1e-4 box around the seed: DFO-LS
            %   then never shrank its trust radius to rhoend and used its
            %   whole 400(n+1) budget on every run (SnGe re-fits: the same
            %   minimum in ~100 evaluations instead of 2-4 x 4000), the
            %   held values drifted by up to 1e-4, and every solver carried
            %   dead dimensions. x has the shape of x0.
            if nargin < 6, output_fcn = []; end
            if nargin < 7, solver = []; end
            if nargin < 8 || isempty(solver_options), solver_options = struct(); end
            free = logical(free(:));
            if numel(free) ~= numel(x0)
                error('free must have one entry per parameter.');
            end
            if all(free)
                [x, fval] = SolverUtils.minimize_bounded(obj, x0, lb, ub, output_fcn, solver, solver_options);
                return;
            end
            x_held = x0;
            expand = @(z) SolverUtils.fill_free(x_held, free, z);
            if ~any(free)                          % nothing to optimize
                x = x0;
                fval = obj(x0);
                SolverUtils.last_eval_count(1);
                return;
            end
            opts = solver_options;
            if isfield(opts, 'residual_fun') && ~isempty(opts.residual_fun)
                full_res = opts.residual_fun;
                opts.residual_fun = @(z) full_res(expand(z));
            end
            out = [];
            if ~isempty(output_fcn)
                out = @(z, optimValues, state) output_fcn(expand(z), optimValues, state);
            end
            z0 = x0(free); zlb = lb(free); zub = ub(free);
            [z, fval] = SolverUtils.minimize_bounded(@(z) obj(expand(z)), z0, zlb, zub, out, solver, opts);
            x = expand(z);
        end

        function x = fill_free(x, free, z)
            %FILL_FREE Full parameter vector x with its free entries set to z.
            x(free) = z;
        end

        function info = eval_limit_info(set_value)
            %EVAL_LIMIT_INFO Whether a solver run since the last reset stopped
            %   because it used up its evaluation budget (struct with fields
            %   hit, limit). The tabs reset it at the start of every Fit click
            %   (SolverUtils.eval_limit_info(struct('hit', false, 'limit', 0)))
            %   and read it afterwards through eval_limit_message; it is
            %   sticky across the several solver calls one click can make
            %   (e.g. the auto-root exploration). Set by note_eval_limit.
            persistent stored
            if nargin > 0
                stored = set_value;
            end
            if isempty(stored)
                stored = struct('hit', false, 'limit', 0);
            end
            info = stored;
        end

        function note_eval_limit(n_evals, limit)
            %NOTE_EVAL_LIMIT Record a solver run that reached its budget.
            if isfinite(limit) && limit > 0 && n_evals >= limit
                SolverUtils.eval_limit_info(struct('hit', true, 'limit', limit));
            end
        end

        function msg = eval_limit_message()
            %EVAL_LIMIT_MESSAGE Activity-log note for a fit that stopped at
            %   the solver's evaluation limit ("" otherwise).
            info = SolverUtils.eval_limit_info();
            msg = "";
            if info.hit
                msg = "The fit stopped at the solver's limit of " + info.limit + ...
                      " evaluations, so the error may still decrease. Press Fit again until it stops dropping.";
            end
        end

        function n = last_eval_count(set_value)
            %LAST_EVAL_COUNT Number of objective evaluations of the last
            %   minimize_bounded call in this session (any solver). Called
            %   with an argument by minimize_bounded to store the count.
            persistent stored
            if nargin > 0
                stored = set_value;
            end
            n = stored;
            if isempty(n), n = 0; end
        end

        function t = last_fit_time(set_value)
            %LAST_FIT_TIME Elapsed time, in seconds, of the most recent
            %   Fit/Refine/Polish click on either tab -- the same number the
            %   Activity log's "... finished after X s" message reports,
            %   i.e. the solver call itself (plus its own bookkeeping), but
            %   excluding the cost of opening the fit-progress window (a new
            %   uifigure, ~1 s) that a caller timing the whole
            %   fit_parameters()/fit_ja_parameters() call from outside would
            %   otherwise include. Set by AnhystereticUtils.fit_parameters_reduced
            %   / fit_parameters_physical and HystereticUtils.fit_ja_parameters
            %   right where they compute the message's own elapsed time.
            persistent stored
            if nargin > 0
                stored = set_value;
            end
            t = stored;
            if isempty(t), t = NaN; end
        end
    end
end
