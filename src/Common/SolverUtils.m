classdef SolverUtils
%SOLVERUTILS  Solver choice shared by the Anhysteretic and Hysteretic fitting
%   tabs: dispatches a bound-constrained minimization to either PRIMA-BOBYQA
%   (tuned npt, src/lib/bobyqa_mat/bobyqa_mat_tuned.m) or Nelder-Mead via
%   minimize() (src/lib/minimize), and maps the fitting tabs'
%   "Solver" dropdown text to the internal solver code each fit call site
%   (fit.m, fit_physical.m, JAFitter.m) expects.

    methods (Static)
        function code = solver_code_from_dropdown(value)
            %SOLVER_CODE_FROM_DROPDOWN Map a SolverDropDown/SolverDropDown_2
            %   Value string to "prima" or "nelder_mead". Falls back to
            %   "nelder_mead" (the default since 2026-09-19: on the
            %   Jiles 1992 synthetic loop and the three published loops of
            %   the LMAG 2026 manuscript both solvers reached the same
            %   minima, Nelder-Mead in fewer evaluations) for any
            %   unrecognised value.
            switch string(value)
                case "PRIMA-BOBYQA, tuned npt"
                    code = "prima";
                case "Hybrid (Nelder-Mead, then BOBYQA)"
                    code = "hybrid";
                otherwise
                    code = "nelder_mead";
            end
        end

        function [x, fval] = minimize_bounded(obj, x0, lb, ub, output_fcn, solver, solver_options)
            %MINIMIZE_BOUNDED  Minimize obj(x) subject to lb <= x <= ub,
            %   starting from x0, using the solver named by `solver`
            %   ("nelder_mead" [default], "prima", or "hybrid" = a short
            %   Nelder-Mead prelude of HYBRID_NM_ITER iterations, whose
            %   large early simplex moves pick the basin, followed by
            %   BOBYQA from its best point for the local convergence; on
            %   the four LMAG 2026 benchmark loops this matched
            %   Nelder-Mead's minima and was faster on three, 2026-09-19).
            %   output_fcn, if
            %   non-empty, is called after every function evaluation as
            %   stop = output_fcn(x, optimValues, state) (optimset
            %   convention); returning true aborts the fit early and the
            %   best point evaluated so far is returned. solver_options
            %   (struct, optional) overrides individual solver settings:
            %   rhobeg/rhoend/npt/maxfun for "prima", TolX/TolFun/MaxIter/
            %   MaxFunEvals for "nelder_mead" -- a tuning hook for scripts,
            %   not used by the GUI.
            if nargin < 6 || isempty(solver)
                solver = "nelder_mead";
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
            if strcmp(solver, "hybrid")
                HYBRID_NM_ITER = 30;
                nm_opts = struct('MaxIter', HYBRID_NM_ITER, 'TolX', 0, 'TolFun', 0);   % exactly the prelude
                for f = intersect(fieldnames(solver_options)', {'MaxIter'})
                    nm_opts.MaxIter = solver_options.(f{1});
                end
                [x1, f1] = SolverUtils.minimize_bounded(obj, x0, lb, ub, output_fcn, "nelder_mead", nm_opts);
                n1 = SolverUtils.last_eval_count();
                [x, fval] = SolverUtils.minimize_bounded(obj, x1, lb, ub, output_fcn, "prima", solver_options);
                if fval > f1          % never leave the prelude's point for a worse one
                    x = x1; fval = f1;
                end
                SolverUtils.last_eval_count(n1 + SolverUtils.last_eval_count());
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
            end
            SolverUtils.last_eval_count(n_evals);
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
    end
end
