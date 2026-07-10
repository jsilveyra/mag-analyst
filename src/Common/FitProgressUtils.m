classdef FitProgressUtils
%FITPROGRESSUTILS Live error-vs-iteration popup shown during Anhysteretic
%   and Hysteretic fits. State (figure/axes/line handles) is cached as
%   appdata on the main UIFigure -- same pattern as PlaygroundUtils'
%   simulation cache -- so no new app_exported.m properties are needed.

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
            ylabel(ax, string(error_name) + " error");
            title(ax, 'Optimization progress');
            grid(ax, 'on');
            ax.YScale = 'log';
            ln = plot(ax, NaN, NaN, '-o', 'LineWidth', 1.2, 'MarkerSize', 4, 'Color', [0.945 0.353 0.161]);
            setappdata(root, 'fit_progress_state', struct('Fig', fig, 'Line', ln, 'Vals', []));
            drawnow;
        end

        function append(app, optim_values)
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

            state.Vals(end+1) = fval;
            iters = 0:(numel(state.Vals) - 1);
            set(state.Line, 'XData', iters, 'YData', state.Vals);
            setappdata(root, 'fit_progress_state', state);
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
    end
end
