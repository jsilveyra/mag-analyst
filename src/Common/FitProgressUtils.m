classdef FitProgressUtils
%FITPROGRESSUTILS Live error-vs-iteration popup shown during Anhysteretic
%   and Hysteretic fits. State (figure/axes/line handles, plus the running
%   best point/value) is cached as appdata on the main UIFigure -- same
%   pattern as PlaygroundUtils' simulation cache -- so no new
%   app_exported.m properties are needed.
%
%   Plots the best value found so far (a monotonically non-increasing
%   curve), not the raw value at whatever point the optimizer's OutputFcn
%   was last called with -- that raw value can be a rejected trial step
%   (see minimize.m's UPfval), which reads as a "peak" that doesn't match
%   how convergence plots are conventionally drawn elsewhere (MATLAB's own
%   optimplotfval/gaplotbestf, and the optimization/ML literature
%   generally, plot the best-so-far/incumbent value). get_best lets the
%   caller retrieve that same tracked best point after the fit ends, so a
%   fit stopped mid-search (via the "Stop fit" button) never returns a
%   worse point than the best one actually seen.

    methods (Static)
        function open(app, title_text, error_name)
            FitProgressUtils.close(app);
            root = FitProgressUtils.get_root(app);
            if isempty(root)
                return;
            end

            w = 480; h = 360;
            scr = get(groot, 'ScreenSize');
            fig = uifigure('Name', title_text);
            fig.Position = [scr(1) + max(0, (scr(3) - w) / 2), scr(2) + max(0, (scr(4) - h) / 2), w, h];
            try
                fig.Icon = root.Icon;
            catch
            end
            g = uigridlayout(fig, [1 1]);
            ax = uiaxes(g);
            xlabel(ax, 'Iteration');
            ylabel(ax, "Best " + string(error_name) + " error so far");
            title(ax, 'Optimization progress');
            grid(ax, 'on');
            ax.YScale = 'log';
            ln = plot(ax, NaN, NaN, '-o', 'LineWidth', 1.2, 'MarkerSize', 4, 'Color', [0.945 0.353 0.161]);
            setappdata(root, 'fit_progress_state', struct( ...
                'Fig', fig, 'Line', ln, 'Vals', [], 'BestVal', Inf, 'BestX', []));
            drawnow;
        end

        function append(app, x, optim_values)
            root = FitProgressUtils.get_root(app);
            if isempty(root) || ~isappdata(root, 'fit_progress_state')
                return;
            end
            state = getappdata(root, 'fit_progress_state');
            if isempty(state.Line) || ~isvalid(state.Line)
                return;
            end

            fval = FitProgressUtils.extract_fval(optim_values);
            if isempty(fval) || ~isfinite(fval) || fval <= 0
                return;   % non-positive values can't show on a log axis
            end

            if fval < state.BestVal
                state.BestVal = fval;
                state.BestX = x(:)';
            end

            % Plot the running best, not the raw just-evaluated value: see
            % the class doc for why the raw value can spike above what's
            % actually been achieved so far.
            state.Vals(end+1) = state.BestVal;
            iters = 0:(numel(state.Vals) - 1);
            set(state.Line, 'XData', iters, 'YData', state.Vals);
            setappdata(root, 'fit_progress_state', state);
        end

        function [best_x, best_val, has_best] = get_best(app)
            best_x = [];
            best_val = Inf;
            has_best = false;
            root = FitProgressUtils.get_root(app);
            if isempty(root) || ~isappdata(root, 'fit_progress_state')
                return;
            end
            state = getappdata(root, 'fit_progress_state');
            if isfield(state, 'BestX') && ~isempty(state.BestX) && isfinite(state.BestVal)
                best_x = state.BestX;
                best_val = state.BestVal;
                has_best = true;
            end
        end

        function close(app)
            root = FitProgressUtils.get_root(app);
            if isempty(root) || ~isappdata(root, 'fit_progress_state')
                return;
            end
            state = getappdata(root, 'fit_progress_state');
            if ~isempty(state.Fig) && isvalid(state.Fig)
                delete(state.Fig);
            end
            rmappdata(root, 'fit_progress_state');
        end

        function fval = extract_fval(optim_values)
            % optimValues.fval carries the objective for fminlbfgs/minimize;
            % resnorm is a fallback for lsq-style optimizers.
            fval = NaN;
            if isstruct(optim_values)
                if isfield(optim_values, 'fval')
                    fval = optim_values.fval;
                elseif isfield(optim_values, 'resnorm')
                    fval = optim_values.resnorm;
                end
            end
        end

        function root = get_root(app)
            root = [];
            if isprop(app, 'MagAnalystUIFigure') && ~isempty(app.MagAnalystUIFigure) && isvalid(app.MagAnalystUIFigure)
                root = app.MagAnalystUIFigure;
            end
        end

        function is_rerun = check_and_remember_conditions(app, tag, conditions, seed)
            % Used to show the "Fit again for a possible improvement" tip
            % (see AnhystereticUtils.fit_parameters /
            % HystereticUtils.fit_ja_parameters) only the first time for a
            % given fit setup, not on every repeat click. is_rerun is true
            % only if BOTH the fit conditions (bounds/mask/error metric --
            % everything but the seed itself) and the seed passed in match
            % exactly what was recorded for the previous fit under `tag` (a
            % per-tab key, e.g. 'anh'/'hyst') -- which only happens when
            % nothing was edited and the seed is still sitting at the
            % previous fit's own result (see remember_fit_result). Also
            % records `conditions` for next time, ready for
            % remember_fit_result to pair with this fit's own result once
            % it's known.
            is_rerun = false;
            root = FitProgressUtils.get_root(app);
            if isempty(root)
                return;
            end
            key = FitProgressUtils.signature_key(tag);
            if isappdata(root, key)
                prev = getappdata(root, key);
                is_rerun = isfield(prev, 'Conditions') && isfield(prev, 'LastResult') && ...
                    isequaln(prev.Conditions, conditions) && isequaln(prev.LastResult, seed);
            end
            entry.Conditions = conditions;
            entry.LastResult = [];
            setappdata(root, key, entry);
        end

        function remember_fit_result(app, tag, result)
            root = FitProgressUtils.get_root(app);
            if isempty(root)
                return;
            end
            key = FitProgressUtils.signature_key(tag);
            if isappdata(root, key)
                entry = getappdata(root, key);
            else
                entry.Conditions = [];
            end
            entry.LastResult = result;
            setappdata(root, key, entry);
        end

        function key = signature_key(tag)
            key = char("fit_rerun_signature_" + string(tag));
        end
    end
end
