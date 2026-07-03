classdef PlaygroundUtils
%PLAYGROUNDUTILS Static helpers for Playground tab workflows.

    methods (Static)
        function clear_simulation(app)
            root = PlaygroundUtils.get_simulation_root(app);
            if isempty(root)
                return;
            end
            setappdata(root, 'playground_simulation_cache', struct( ...
                'H', [], ...
                'M', [], ...
                'info', struct()));
        end

        function set_simulation(app, Hsim, Msim, info)
            root = PlaygroundUtils.get_simulation_root(app);
            if isempty(root)
                return;
            end
            setappdata(root, 'playground_simulation_cache', struct( ...
                'H', Hsim, ...
                'M', Msim, ...
                'info', info));
        end

        function mode = get_mode(app)
            mode = string(app.HcaseDropDown.Value);
        end

        function tf = is_major_mode(app)
            tf = PlaygroundUtils.normalize_mode_label(PlaygroundUtils.get_mode(app)) == "Major Loop";
        end

        function tf = is_minor_mode(app)
            tf = PlaygroundUtils.normalize_mode_label(PlaygroundUtils.get_mode(app)) == "Minor Loops";
        end

        function tf = has_data_curve(app)
            tf = false;
            try
                [~, ~, tf] = PlaygroundUtils.get_data_curve(app);
            catch
                tf = false;
            end
        end

        function [Htip, Mtip, ok] = get_data_tip(app)
            Htip = NaN;
            Mtip = NaN;
            ok = false;

            try
                [H_plot, M_plot, has_data] = PlaygroundUtils.get_data_curve(app);
                if ~has_data
                    return;
                end
                [Htip, Mtip] = Utils().find_tip(H_plot, M_plot);
                ok = isfinite(Htip) && isfinite(Mtip);
            catch
                ok = false;
            end
        end

        function sync_major_ui(app)
            if ~PlaygroundUtils.is_major_mode(app)
                return;
            end

            start_mode = lower(string(app.StartingpointDropDown.Value));
            is_fixed = string(app.StopcriterionDropDown.Value) == "Fixed repetitions";
            has_data = PlaygroundUtils.has_data_curve(app);

            if contains(start_mode, "demagnetized")
                app.HstartAmEditField.Value = 0;
                app.MstartAmEditField.Value = 0;
                app.HstartAmEditField.Enable = 'off';
                app.MstartAmEditField.Enable = 'off';
                app.HamplitudeAmEditField.Enable = 'on';
                if has_data
                    [Htip_data, ~, ok_tip] = PlaygroundUtils.get_data_tip(app);
                    if ok_tip && (~isfinite(app.HamplitudeAmEditField.Value) || app.HamplitudeAmEditField.Value <= 0)
                        app.HamplitudeAmEditField.Value = Htip_data;
                    end
                end
            elseif contains(start_mode, "tip point")
                [Htip_data, Mtip_data, ok_tip] = PlaygroundUtils.get_data_tip(app);
                if ok_tip
                    app.HstartAmEditField.Value = Htip_data;
                    app.MstartAmEditField.Value = Mtip_data;
                    app.HamplitudeAmEditField.Value = Htip_data;
                else
                    app.HstartAmEditField.Value = 0;
                    app.MstartAmEditField.Value = 0;
                    app.HamplitudeAmEditField.Value = 0;
                end
                app.HstartAmEditField.Enable = 'off';
                app.MstartAmEditField.Enable = 'off';
                app.HamplitudeAmEditField.Enable = 'off';
            else
                app.HstartAmEditField.Enable = 'on';
                app.MstartAmEditField.Enable = 'on';
                app.HamplitudeAmEditField.Enable = 'on';
            end

            if is_fixed
                app.RepetitionsEditField.Enable = 'on';
                app.ReltoleranceEditField.Enable = 'off';
            else
                app.RepetitionsEditField.Enable = 'off';
                app.ReltoleranceEditField.Enable = 'on';
            end
        end

        function [Hstart, Mstart, Htip, ok] = get_major_inputs(app)
            Hstart = NaN;
            Mstart = NaN;
            Htip = app.HamplitudeAmEditField.Value;
            ok = false;

            start_mode = lower(string(app.StartingpointDropDown.Value));
            if contains(start_mode, "demagnetized")
                Hstart = 0;
                Mstart = 0;
            elseif contains(start_mode, "tip point")
                [Hstart, Mstart, ok] = PlaygroundUtils.get_data_tip(app);
                if ~ok
                    return;
                end
            else
                Hstart = app.HstartAmEditField.Value;
                Mstart = app.MstartAmEditField.Value;
            end

            ok = isfinite(Hstart) && isfinite(Mstart) && isfinite(Htip) && Htip > 0;
        end

        function [Htips, ok] = get_minor_inputs(app)
            Htips = [];
            ok = false;

            if ~isprop(app, 'UITable') || isempty(app.UITable) || ~isvalid(app.UITable)
                return;
            end

            raw = string(app.UITable.Value);
            raw = strjoin(raw(:).', newline);
            if strlength(strtrim(raw)) == 0
                return;
            end

            tokens = split(string(raw), {newline, ",", ";", " "});
            tokens = tokens(strlength(strtrim(tokens)) > 0);
            values = str2double(replace(strtrim(tokens), ",", ""));

            if isempty(values) || any(~isfinite(values)) || any(values <= 0)
                return;
            end

            Htips = sort(values(:), 'ascend');
            ok = true;
        end

        function plot_option = get_plot_option(app)
            if PlaygroundUtils.is_major_mode(app)
                plot_option = string(app.PlotDropDown.Value);
            elseif PlaygroundUtils.is_minor_mode(app)
                plot_option = string(app.PlotDropDown_2.Value);
            else
                plot_option = "";
            end
        end

        function tf = is_last_cycle_plot_option(plot_option)
            plot_option = lower(string(plot_option));
            tf = plot_option == "last loop only" || plot_option == "last loops only" || plot_option == "last cycle only";
        end

        function [H_unit, M_unit] = get_axis_units(app)
            H_unit = string(app.HorizontalaxisfieldDropDown_2.Value);
            M_unit = string(app.VerticalaxisfieldDropDown_2.Value);
        end

        function [H_plot, M_plot, has_data] = get_data_curve(app)
            H_plot = [];
            M_plot = [];
            has_data = false;

            if ~ismethod(app, 'get_playground_data_curve')
                return;
            end

            [H_plot, M_plot, has_data] = app.get_playground_data_curve();
        end

        function [Hsim, Msim, info] = calculate_simulation(app)
            Hsim = [];
            Msim = [];
            info = struct('mode', "", 'status', "invalid_inputs", 'message', "");

            [params, ok_params] = PlaygroundUtils.get_playground_params(app);
            if ~ok_params
                return;
            end

            if PlaygroundUtils.is_major_mode(app)
                [Hstart, Mstart, Htip, ok_inputs] = PlaygroundUtils.get_major_inputs(app);
                if ~ok_inputs
                    return;
                end

                try
                    [Hsim, Msim, info] = solveJA_majorLoop_playground( ...
                        Hstart, Mstart, Htip, params, ...
                        string(app.StartingpointDropDown.Value), ...
                        string(app.StopcriterionDropDown.Value), ...
                        app.RepetitionsEditField.Value, ...
                        app.ReltoleranceEditField.Value, ...
                        odeset('RelTol', 1e-7, 'AbsTol', 1e-6));
                    info.status = "ok";
                catch ME
                    Hsim = [];
                    Msim = [];
                    info = struct('mode', "Major Loop", 'status', "solver_failed", 'message', string(ME.message));
                end
            elseif PlaygroundUtils.is_minor_mode(app)
                [Htips, ok_inputs] = PlaygroundUtils.get_minor_inputs(app);
                if ~ok_inputs
                    return;
                end

                try
                    [Hsim, Msim, info] = solveJA_minorLoop_playground( ...
                        Htips, params, ...
                        string(app.StopcriterionDropDown_4.Value), ...
                        app.RepetitionsEditField_2.Value, ...
                        app.ReltoleranceEditField_2.Value, ...
                        odeset('RelTol', 1e-7, 'AbsTol', 1e-6));
                    info.status = "ok";
                catch ME
                    Hsim = [];
                    Msim = [];
                    info = struct('mode', "Minor Loops", 'status', "solver_failed", 'message', string(ME.message));
                end
            end
        end

        function [H_plot, M_plot, has_data] = get_simulation_curve(app)
            H_plot = [];
            M_plot = [];
            has_data = false;

            root = PlaygroundUtils.get_simulation_root(app);
            if isempty(root) || ~isappdata(root, 'playground_simulation_cache')
                return;
            end

            cache = getappdata(root, 'playground_simulation_cache');
            if isempty(cache) || ~isfield(cache, 'H') || ~isfield(cache, 'M') || ~isfield(cache, 'info')
                return;
            end

            if isempty(cache.H) || isempty(cache.M)
                return;
            end

            if ~isfield(cache.info, 'mode') || PlaygroundUtils.normalize_mode_label(cache.info.mode) ~= PlaygroundUtils.normalize_mode_label(PlaygroundUtils.get_mode(app))
                return;
            end

            H_plot = cache.H;
            M_plot = cache.M;

            if isfield(cache.info, 'cyclesSimulated') && cache.info.cyclesSimulated > 0 ...
                    && PlaygroundUtils.is_last_cycle_plot_option(PlaygroundUtils.get_plot_option(app))
                if isfield(cache.info, 'tipLastLoopStarts') && isfield(cache.info, 'tipEnds') ...
                        && numel(cache.info.tipLastLoopStarts) == numel(cache.info.tipEnds) ...
                        && ~isempty(cache.info.tipLastLoopStarts)
                    H_last = [];
                    M_last = [];
                    for i = 1:numel(cache.info.tipLastLoopStarts)
                        start_idx = cache.info.tipLastLoopStarts(i);
                        end_idx = cache.info.tipEnds(i);
                        if start_idx > end_idx
                            continue;
                        end
                        seg_H = H_plot(start_idx:end_idx);
                        seg_M = M_plot(start_idx:end_idx);
                        if isempty(H_last)
                            H_last = seg_H;
                            M_last = seg_M;
                        else
                            % Insert a NaN break so each tip's last loop is
                            % plotted as a separate curve and the last point
                            % of one loop is not joined to the first point of
                            % the next.
                            H_last = [H_last; NaN; seg_H]; %#ok<AGROW>
                            M_last = [M_last; NaN; seg_M]; %#ok<AGROW>
                        end
                    end
                    if ~isempty(H_last) && ~isempty(M_last)
                        H_plot = H_last;
                        M_plot = M_last;
                    end
                elseif isfield(cache.info, 'branchStarts') && numel(cache.info.branchStarts) >= 2
                    start_idx = cache.info.branchStarts(end - 1);
                    H_plot = H_plot(start_idx:end);
                    M_plot = M_plot(start_idx:end);
                end
            end

            [H_plot, M_plot] = UnitConvertor().convert_H_M(H_plot, "H [A/m]", M_plot, "M [A/m]");
            has_data = ~isempty(H_plot) && ~isempty(M_plot) && numel(H_plot) >= 2 && numel(M_plot) >= 2;
        end

        function [params, ok] = get_hysteretic_params(app)
            [params, ok] = PlaygroundUtils.get_playground_params(app);
        end

        function [params, ok] = get_playground_params(app)
            params = struct('Ms', NaN, 'a', NaN, 'alpha', NaN, 'k', NaN, 'c', NaN);
            ok = false;

            try
                Ms = str2double(replace(string(app.JsField_9.Value), ",", ""));
                a = str2double(replace(string(app.JsField_10.Value), ",", ""));
                alpha = str2double(replace(string(app.JsField_11.Value), ",", ""));
                c = str2double(replace(string(app.JsField_12.Value), ",", ""));
                k = str2double(replace(string(app.JsField_13.Value), ",", ""));
            catch
                return;
            end

            if any(~isfinite([Ms, a, alpha, c, k]))
                return;
            end

            if Ms <= 0 || a <= 0 || k <= 0 || c < 0 || c > 1
                return;
            end

            params = struct('Ms', Ms, 'a', a, 'alpha', alpha, 'k', k, 'c', c);
            ok = true;
        end

        function root = get_simulation_root(app)
            root = [];
            if isprop(app, 'MagAnalystUIFigure') && ~isempty(app.MagAnalystUIFigure) && isvalid(app.MagAnalystUIFigure)
                root = app.MagAnalystUIFigure;
            end
        end

        function mode = normalize_mode_label(mode)
            mode = lower(strtrim(string(mode)));
            if contains(mode, "major loop")
                mode = "Major Loop";
            elseif contains(mode, "minor loop")
                mode = "Minor Loops";
            end
        end

        function [H_left, M_left] = extract_left_branch_uniform_arc(H_in, M_in, number_points)
            H = H_in(:)';
            M = M_in(:)';
            valid = isfinite(H) & isfinite(M);
            H = H(valid);
            M = M(valid);

            if numel(H) < 2
                H_left = H;
                M_left = M;
                return;
            end

            [~, H_min_index] = min(H);
            H_sorted = [H(H_min_index:end) H(1:H_min_index)];
            M_sorted = [M(H_min_index:end) M(1:H_min_index)];

            denom_H = max(H_sorted.^2);
            denom_M = max(M_sorted.^2);
            if denom_H == 0
                denom_H = 1;
            end
            if denom_M == 0
                denom_M = 1;
            end

            H2M2 = sign(H_sorted).*(H_sorted).^2./denom_H + sign(M_sorted).*(M_sorted).^2./denom_M;
            [~, max_index] = max(H2M2);
            H_left_raw = H_sorted(max_index:end);
            M_left_raw = M_sorted(max_index:end);

            if nargin < 3 || isempty(number_points) || number_points < 2
                number_points = numel(H_left_raw);
            end

            ds = hypot(diff(H_left_raw), diff(M_left_raw));
            s = [0 cumsum(ds)];
            [s_unique, idx_unique] = unique(s, 'stable');

            if numel(s_unique) < 2
                H_left = H_left_raw;
                M_left = M_left_raw;
                return;
            end

            H_unique = H_left_raw(idx_unique);
            M_unique = M_left_raw(idx_unique);
            s_query = linspace(s_unique(1), s_unique(end), round(number_points));
            H_left = interp1(s_unique, H_unique, s_query, 'linear');
            M_left = interp1(s_unique, M_unique, s_query, 'linear');
        end
    end
end
