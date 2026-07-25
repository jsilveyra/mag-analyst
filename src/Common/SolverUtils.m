classdef SolverUtils
%SOLVERUTILS  Solver choice shared by the Anhysteretic and Hysteretic fitting
%   tabs: dispatches a bound-constrained minimization to either PRIMA-BOBYQA
%   (tuned npt, src/lib/bobyqa_prima/bobyqa_prima_tuned.m) or the legacy
%   Nelder-Mead minimize() (src/lib/minimize), and maps the fitting tabs'
%   "Solver" dropdown text to the internal solver code each fit call site
%   (fit.m, fit_physical.m, JAFitter.m) expects.

    methods (Static)
        function code = solver_code_from_dropdown(value)
            %SOLVER_CODE_FROM_DROPDOWN Map a SolverDropDown/SolverDropDown_2
            %   Value string to "prima" or "nelder_mead". Falls back to
            %   "prima" (the recommended default) for any unrecognised value.
            switch string(value)
                case "Nelder-Mead (minimize lib)"
                    code = "nelder_mead";
                otherwise
                    code = "prima";
            end
        end

        function [x, fval] = minimize_bounded(obj, x0, lb, ub, output_fcn, solver)
            %MINIMIZE_BOUNDED  Minimize obj(x) subject to lb <= x <= ub,
            %   starting from x0, using the solver named by `solver`
            %   ("prima" [default] or "nelder_mead"). output_fcn, if
            %   non-empty, is called after every function evaluation as
            %   stop = output_fcn(x, optimValues, state) (optimset
            %   convention); returning true aborts the fit early and the
            %   best point evaluated so far is returned.
            if nargin < 6 || isempty(solver)
                solver = "prima";
            end
            if strcmp(solver, "nelder_mead")
                options = optimset('MaxIter', 2000, 'MaxFunEvals', 1e4, ...
                    'TolX', 1e-5, 'TolFun', 1e-5, 'Display', 'off');
                if ~isempty(output_fcn)
                    options = optimset(options, 'OutputFcn', output_fcn);
                end
                [x, fval] = minimize(obj, x0, [], [], [], [], lb, ub, [], options);
            else
                prima_options = struct('rhoend', 1e-6);
                if ~isempty(output_fcn)
                    prima_options.output_fcn = output_fcn;
                end
                [x, fval] = bobyqa_prima_tuned(obj, x0, lb, ub, prima_options);
            end
        end
    end
end
