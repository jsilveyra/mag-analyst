classdef FitProgressUtils
%FITPROGRESSUTILS Live error-vs-iteration popup shown during Anhysteretic
%   and Hysteretic fits. State (figure/axes/line handles, plus the running
%   best point/value) is cached as appdata on the main UIFigure -- same
%   pattern as PlaygroundUtils' simulation cache -- so no new
%   properties are needed on the app class.
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
%
%   State is kept PER KIND ('anh'/'hyst', two separate appdata entries)
%   rather than one shared slot, so that fitting one tab doesn't wipe the
%   other tab's history -- both remain independently exportable (see
%   ExportDialogUtils) regardless of which was fit most recently. Only one
%   popup is ever visually open at a time (fits run one at a time), tracked
%   via the 'fit_progress_active_kind' appdata entry so the shared OutputFcn
%   (fit_stop_output_fcn, called for both anh and hyst fits) knows which
%   kind's history to append to without every call site having to say so.
%
%   open(..., accumulate) controls whether a fit continues appending to the
%   same kind's existing Vals/BestVal/BestX (a plain "Fit again" repeat with
%   nothing edited -- see check_and_remember_conditions) or starts a fresh
%   history (anything changed since the last fit of that kind).
%
%   ONE popup window per app, reused by every fit (2026-09-28). It is
%   created hidden on first use, shown by open(), hidden (never deleted) by
%   close_popup/close and by its own close button, and deleted only when
%   the app's main window is destroyed. Until then every fit deleted the
%   previous popup and created a new one (4-5 per blind workflow), and
%   deleting uifigures that hold uiaxes crashes MATLAB R2022b now and then
%   with heap corruption (0xc0000374): reproduced without any MagAnalyst
%   code, create/plot/delete cycles died after ~15-110 cycles, while one
%   reused window survived 150 fits.

    methods (Static)
        function open(app, kind, title_text, error_name, accumulate)
            if nargin < 5
                accumulate = false;
            end
            root = FitProgressUtils.get_root(app);
            if isempty(root)
                return;
            end

            % Detach any kind from the popup without discarding either
            % kind's numeric history -- see close_popup.
            FitProgressUtils.close_popup(app);

            key = FitProgressUtils.state_key(kind);
            if accumulate && isappdata(root, key)
                state = getappdata(root, key);
            else
                state = struct('Vals', [], 'BestVal', Inf, 'BestX', [], 'TotalElapsedTime', 0);
            end
            state.ErrName = string(error_name);

            popup = FitProgressUtils.get_popup(root);
            popup.Fig.Name = title_text;
            ylabel(popup.Ax, "Best " + string(error_name) + " error so far");
            if isempty(state.Vals)
                set(popup.Line, 'XData', NaN, 'YData', NaN);
            else
                set(popup.Line, 'XData', 0:(numel(state.Vals) - 1), 'YData', state.Vals);
            end
            popup.Fig.Visible = 'on';

            state.Fig = popup.Fig;
            state.Line = popup.Line;
            setappdata(root, key, state);
            setappdata(root, 'fit_progress_active_kind', char(string(kind)));
            drawnow;
        end

        function popup = get_popup(root)
            %GET_POPUP The app's one progress window (see the class doc),
            %   created hidden on first use.
            if isappdata(root, 'fit_progress_popup')
                popup = getappdata(root, 'fit_progress_popup');
                if isvalid(popup.Fig) && isvalid(popup.Line)
                    return;
                end
            end
            w = 480; h = 360;
            scr = get(groot, 'ScreenSize');
            fig = uifigure('Name', 'Optimization progress', 'Visible', 'off');
            fig.Position = [scr(1) + max(0, (scr(3) - w) / 2), scr(2) + max(0, (scr(4) - h) / 2), w, h];
            fig.CloseRequestFcn = @(f, ~) set(f, 'Visible', 'off');   % hide, never delete
            try
                fig.Icon = root.Icon;
            catch
            end
            g = uigridlayout(fig, [1 1]);
            ax = uiaxes(g);
            xlabel(ax, 'Iteration');
            title(ax, 'Optimization progress');
            grid(ax, 'on');
            ax.YScale = 'log';
            ln = plot(ax, NaN, NaN, '-o', 'LineWidth', 1.2, 'MarkerSize', 4, 'Color', [0.945 0.353 0.161]);
            % A separate window, not a child of the app's figure: deleted
            % with it (without this, delete(app) -- a script, a test --
            % left it open, one orphan window and renderer per app).
            addlistener(root, 'ObjectBeingDestroyed', @(~, ~) FitProgressUtils.delete_if_valid(fig));
            popup = struct('Fig', fig, 'Ax', ax, 'Line', ln);
            setappdata(root, 'fit_progress_popup', popup);
        end

        function append(app, x, optim_values)
            root = FitProgressUtils.get_root(app);
            if isempty(root) || ~isappdata(root, 'fit_progress_active_kind')
                return;
            end
            key = FitProgressUtils.state_key(getappdata(root, 'fit_progress_active_kind'));
            if ~isappdata(root, key)
                return;
            end
            state = getappdata(root, key);
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
            setappdata(root, key, state);
        end

        function [best_x, best_val, has_best] = get_best(app, kind)
            best_x = [];
            best_val = Inf;
            has_best = false;
            root = FitProgressUtils.get_root(app);
            if isempty(root)
                return;
            end
            key = FitProgressUtils.state_key(kind);
            if ~isappdata(root, key)
                return;
            end
            state = getappdata(root, key);
            if isfield(state, 'BestX') && ~isempty(state.BestX) && isfinite(state.BestVal)
                best_x = state.BestX;
                best_val = state.BestVal;
                has_best = true;
            end
        end

        function [iters, vals, err_name, has_history, elapsed_time] = get_history(app, kind)
            %GET_HISTORY Full accumulated error-vs-iteration history for
            %   `kind` ('anh'/'hyst'), independent of which tab was fit most
            %   recently. Used by ExportDialogUtils. Also returns total
            %   accumulated elapsed time across all fits of that kind.
            iters = [];
            vals = [];
            err_name = "";
            has_history = false;
            elapsed_time = 0;
            root = FitProgressUtils.get_root(app);
            if isempty(root)
                return;
            end
            key = FitProgressUtils.state_key(kind);
            if ~isappdata(root, key)
                return;
            end
            state = getappdata(root, key);
            if ~isfield(state, 'Vals') || isempty(state.Vals)
                return;
            end
            vals = state.Vals(:);
            iters = (0:numel(vals) - 1)';
            if isfield(state, 'ErrName')
                err_name = state.ErrName;
            end
            if isfield(state, 'TotalElapsedTime')
                elapsed_time = state.TotalElapsedTime;
            end
            has_history = true;
        end

        function record_elapsed_time(app, kind, elapsed_seconds)
            %RECORD_ELAPSED_TIME Accumulate elapsed time for a completed fit.
            %   Called after tic/toc at the end of a fit to record the
            %   elapsed time into the state's total, so repeated fits (with
            %   accumulate=true) have cumulative timing.
            root = FitProgressUtils.get_root(app);
            if isempty(root)
                return;
            end
            key = FitProgressUtils.state_key(kind);
            if ~isappdata(root, key)
                return;
            end
            state = getappdata(root, key);
            if ~isfield(state, 'TotalElapsedTime')
                state.TotalElapsedTime = 0;
            end
            state.TotalElapsedTime = state.TotalElapsedTime + elapsed_seconds;
            setappdata(root, key, state);
        end

        function close_popup(app)
            %CLOSE_POPUP Hide the progress popup and detach both kinds from
            %   it, WITHOUT discarding the numeric history (Vals/BestVal/
            %   BestX) either kind has recorded -- called at the start of
            %   every open(). The window itself is kept for the next fit
            %   (see the class doc: deleting it is what crashed R2022b).
            root = FitProgressUtils.get_root(app);
            if isempty(root)
                return;
            end
            if isappdata(root, 'fit_progress_popup')
                popup = getappdata(root, 'fit_progress_popup');
                if isvalid(popup.Fig)
                    popup.Fig.Visible = 'off';
                end
            end
            for kind = ["anh", "hyst"]
                key = FitProgressUtils.state_key(kind);
                if ~isappdata(root, key)
                    continue;
                end
                state = getappdata(root, key);
                state.Fig = [];
                state.Line = [];
                setappdata(root, key, state);
            end
        end

        function delete_if_valid(fig)
            % The one deletion of the popup, with its app's main window.
            % Rendering is flushed and allowed to settle first: in the
            % R2022b reproduction, create/plot/delete cycles survived 300
            % cycles with drawnow + pause(0.3) before delete, crashed at
            % ~110 without, and at ~50 when the window was hidden first.
            if ~isempty(fig) && isvalid(fig)
                FitProgressUtils.settle();
                delete(fig);
            end
        end

        function settle()
            %SETTLE Let pending rendering finish before a uifigure is deleted
            %   (see delete_if_valid). Also called by close(), which runs
            %   right before the app's own window is deleted.
            drawnow;
            pause(0.3);
        end

        function close(app)
            %CLOSE Full teardown: hides the popup AND discards all
            %   history for both kinds. Called at app close and by "New".
            root = FitProgressUtils.get_root(app);
            if isempty(root)
                return;
            end
            FitProgressUtils.close_popup(app);
            for kind = ["anh", "hyst"]
                key = FitProgressUtils.state_key(kind);
                if isappdata(root, key)
                    rmappdata(root, key);
                end
            end
            if isappdata(root, 'fit_progress_active_kind')
                rmappdata(root, 'fit_progress_active_kind');
            end
            FitProgressUtils.settle();
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

        function key = state_key(kind)
            key = char("fit_progress_state_" + string(kind));
        end

        function is_rerun = check_and_remember_conditions(app, tag, conditions, seed)
            % Used to show the "Fit again for a possible improvement" tip
            % (see AnhystereticUtils.fit_parameters /
            % HystereticUtils.fit_ja_parameters) only the first time for a
            % given fit setup, not on every repeat click -- and to decide
            % whether ExportDialogUtils' fit-progress
            % history should accumulate across repeated launches instead of
            % resetting (see the `accumulate` argument of open()).
            % is_rerun is true only if BOTH the fit conditions (bounds/mask/
            % error metric -- everything but the seed itself) and the seed
            % passed in match exactly what was recorded for the previous fit
            % under `tag` (a per-tab key, e.g. 'anh'/'hyst') -- which only
            % happens when nothing was edited and the seed is still sitting
            % at the previous fit's own result (see remember_fit_result).
            % Also records `conditions` for next time, ready for
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
