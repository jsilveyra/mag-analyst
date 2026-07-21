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

        function tf = is_harmonics_mode(app)
            tf = PlaygroundUtils.normalize_mode_label(PlaygroundUtils.get_mode(app)) == "Major Loop Harmonics";
        end

        function tf = is_minor_mode(app)
            tf = PlaygroundUtils.normalize_mode_label(PlaygroundUtils.get_mode(app)) == "Minor Loops";
        end

        function tf = is_degaussing_mode(app)
            tf = PlaygroundUtils.normalize_mode_label(PlaygroundUtils.get_mode(app)) == "Degaussing";
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

        function set_enable(component, state)
            % Guarded enable/disable: only touches the Enable property when
            % the component actually has one (older-release uilabel safety),
            % mirroring the app's set_enable_safe so labels can be grayed too.
            if ~isempty(component) && isvalid(component) && isprop(component, 'Enable')
                component.Enable = state;
            end
        end

        function set_field_enable(field, label, state)
            % Enable/disable a field together with its label so the whole
            % row grays out as a unit.
            PlaygroundUtils.set_enable(field, state);
            PlaygroundUtils.set_enable(label, state);
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
                PlaygroundUtils.set_field_enable(app.HstartAmEditField, app.HstartAmEditFieldLabel, 'off');
                PlaygroundUtils.set_field_enable(app.MstartAmEditField, app.MstartAmEditFieldLabel, 'off');
                PlaygroundUtils.set_field_enable(app.HamplitudeAmEditField, app.HamplitudeAmEditFieldLabel, 'on');
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
                PlaygroundUtils.set_field_enable(app.HstartAmEditField, app.HstartAmEditFieldLabel, 'off');
                PlaygroundUtils.set_field_enable(app.MstartAmEditField, app.MstartAmEditFieldLabel, 'off');
                PlaygroundUtils.set_field_enable(app.HamplitudeAmEditField, app.HamplitudeAmEditFieldLabel, 'off');
            else
                PlaygroundUtils.set_field_enable(app.HstartAmEditField, app.HstartAmEditFieldLabel, 'on');
                PlaygroundUtils.set_field_enable(app.MstartAmEditField, app.MstartAmEditFieldLabel, 'on');
                PlaygroundUtils.set_field_enable(app.HamplitudeAmEditField, app.HamplitudeAmEditFieldLabel, 'on');
            end

            if is_fixed
                PlaygroundUtils.set_field_enable(app.RepetitionsEditField, app.RepetitionsEditFieldLabel, 'on');
                PlaygroundUtils.set_field_enable(app.ReltoleranceEditField_6, app.ReltoleranceEditField_6Label, 'off');
                PlaygroundUtils.set_field_enable(app.MaxrepetitionsEditField, app.MaxrepetitionsEditFieldLabel, 'off');
            else
                PlaygroundUtils.set_field_enable(app.RepetitionsEditField, app.RepetitionsEditFieldLabel, 'off');
                PlaygroundUtils.set_field_enable(app.ReltoleranceEditField_6, app.ReltoleranceEditField_6Label, 'on');
                PlaygroundUtils.set_field_enable(app.MaxrepetitionsEditField, app.MaxrepetitionsEditFieldLabel, 'on');
            end
        end

        function sync_minor_ui(app)
            % Gray out the minor-loop Repetitions / Rel. tolerance fields (and
            % their labels) according to the stop criterion, mirroring the
            % major-loop behavior. Only the stop-criterion group is
            % conditional here — the minor loop always starts demagnetized and
            % is driven by the Htip_i table.
            if ~PlaygroundUtils.is_minor_mode(app)
                return;
            end

            is_fixed = string(app.StopcriterionDropDown_4.Value) == "Fixed repetitions";
            if is_fixed
                PlaygroundUtils.set_field_enable(app.RepetitionsEditField_2, app.RepetitionsEditFieldLabel_2, 'on');
                PlaygroundUtils.set_field_enable(app.ReltoleranceEditField_5, app.ReltoleranceEditField_5Label, 'off');
                PlaygroundUtils.set_field_enable(app.MaxrepetitionsEditField_2, app.MaxrepetitionsEditFieldLabel_2, 'off');
            else
                PlaygroundUtils.set_field_enable(app.RepetitionsEditField_2, app.RepetitionsEditFieldLabel_2, 'off');
                PlaygroundUtils.set_field_enable(app.ReltoleranceEditField_5, app.ReltoleranceEditField_5Label, 'on');
                PlaygroundUtils.set_field_enable(app.MaxrepetitionsEditField_2, app.MaxrepetitionsEditFieldLabel_2, 'on');
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
            elseif PlaygroundUtils.is_harmonics_mode(app)
                % The harmonics panel has no plot-option dropdown: this mode
                % always shows the full simulated history.
                plot_option = "Full history";
            else
                plot_option = "";
            end
        end

        function tf = is_last_cycle_plot_option(plot_option)
            plot_option = lower(string(plot_option));
            tf = plot_option == "last loop only" || plot_option == "last loops only" ...
                || plot_option == "last cycle only" || plot_option == "last period only";
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

            if isfield(cache.info, 'cycles_simulated') && cache.info.cycles_simulated > 0 ...
                    && PlaygroundUtils.is_last_cycle_plot_option(PlaygroundUtils.get_plot_option(app))
                if isfield(cache.info, 'tip_last_loop_starts') && isfield(cache.info, 'tip_ends') ...
                        && numel(cache.info.tip_last_loop_starts) == numel(cache.info.tip_ends) ...
                        && ~isempty(cache.info.tip_last_loop_starts)
                    H_last = [];
                    M_last = [];
                    for i = 1:numel(cache.info.tip_last_loop_starts)
                        start_idx = cache.info.tip_last_loop_starts(i);
                        end_idx = cache.info.tip_ends(i);
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
                elseif isfield(cache.info, 'branch_starts') && numel(cache.info.branch_starts) >= 2
                    start_idx = cache.info.branch_starts(end - 1);
                    H_plot = H_plot(start_idx:end);
                    M_plot = M_plot(start_idx:end);
                end
            end

            [H_plot, M_plot] = UnitConvertor().convert_H_M(H_plot, "H [A/m]", M_plot, "M [A/m]");
            has_data = ~isempty(H_plot) && ~isempty(M_plot) && numel(H_plot) >= 2 && numel(M_plot) >= 2;
        end

        function [H, M, info, ok] = get_simulation_export(app)
            %GET_SIMULATION_EXPORT Cached simulation for export.
            %   Returns the curve in BASE units [A/m] (no axis-unit conversion),
            %   honouring the current "Last loops only / Full history" plot
            %   option exactly like get_simulation_curve, plus the info struct.
            H = [];
            M = [];
            info = struct();
            ok = false;

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

            H = cache.H;
            M = cache.M;
            info = cache.info;

            if isfield(cache.info, 'cycles_simulated') && cache.info.cycles_simulated > 0 ...
                    && PlaygroundUtils.is_last_cycle_plot_option(PlaygroundUtils.get_plot_option(app))
                if isfield(cache.info, 'tip_last_loop_starts') && isfield(cache.info, 'tip_ends') ...
                        && numel(cache.info.tip_last_loop_starts) == numel(cache.info.tip_ends) ...
                        && ~isempty(cache.info.tip_last_loop_starts)
                    H_last = [];
                    M_last = [];
                    for i = 1:numel(cache.info.tip_last_loop_starts)
                        start_idx = cache.info.tip_last_loop_starts(i);
                        end_idx = cache.info.tip_ends(i);
                        if start_idx > end_idx
                            continue;
                        end
                        seg_H = H(start_idx:end_idx);
                        seg_M = M(start_idx:end_idx);
                        if isempty(H_last)
                            H_last = seg_H;
                            M_last = seg_M;
                        else
                            H_last = [H_last; NaN; seg_H]; %#ok<AGROW>
                            M_last = [M_last; NaN; seg_M]; %#ok<AGROW>
                        end
                    end
                    if ~isempty(H_last) && ~isempty(M_last)
                        H = H_last;
                        M = M_last;
                    end
                elseif isfield(cache.info, 'branch_starts') && numel(cache.info.branch_starts) >= 2
                    start_idx = cache.info.branch_starts(end - 1);
                    H = H(start_idx:end);
                    M = M(start_idx:end);
                end
            end

            ok = ~isempty(H) && ~isempty(M) && numel(H) >= 2 && numel(M) >= 2;
        end

        function [params, ok] = get_hysteretic_params(app)
            [params, ok] = PlaygroundUtils.get_playground_params(app);
        end

        function [params, ok] = get_playground_params(app)
            params = struct('Ms', NaN, 'a', NaN, 'alpha', NaN, 'k', NaN, 'c', NaN);
            ok = false;

            Ms = app.Ms_JA_Playground.Value;
            a = app.a_JA_Playground.Value;
            alpha = app.alpha_JA_Playground.Value;
            c = app.c_JA_Playground.Value;
            k = app.k_JA_Playground.Value;

            if isempty(Ms) || isempty(a) || isempty(alpha) || isempty(c) || isempty(k)
                return;
            end

            if any(~isfinite([Ms, a, alpha, c, k]))
                return;
            end

            % k == 0 is the physical zero-pinning limit (M collapses onto the
            % anhysteretic curve, handled directly in solve_ja_monotonic) --
            % only genuinely unphysical k < 0 is rejected here.
            if Ms <= 0 || a <= 0 || k < 0 || c < 0 || c > 1
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
            if contains(mode, "harmonic")
                % Must be tested before "major loop": the label
                % "Major loop with harmonics" also contains "major loop".
                mode = "Major Loop Harmonics";
            elseif contains(mode, "major loop")
                mode = "Major Loop";
            elseif contains(mode, "minor loop")
                mode = "Minor Loops";
            elseif contains(mode, "degauss")
                mode = "Degaussing";
            end
        end

        function plot_playground(app)
            ax = app.AxesM_5;
            cla(ax, 'reset');
            hold(ax, 'on');

            [H_label, M_label] = PlaygroundUtils.get_playground_axis_units(app);
            % Playground always matches the Input tab's native mode: when
            % mass-native, its own vertical-axis dropdown is locked to the
            % single sigma unit (see sync_playground_mass_ui), so the
            % source unit for the cached curve/simulation (app.data_curve.M
            % or the JA-simulated M, both mass-native in that case) must
            % match -- never hardcode "M [A/m]" as the source here.
            source_M_unit = DisplayUnits.get_M_label(app);
            if app.ShowgridCheckBoxM_4.Value == 1
                [H_plot, M_plot, has_data] = PlaygroundUtils.get_playground_data_curve(app);
                if has_data
                    [H_plot, M_plot] = PlaygroundUtils.convert_playground_curve_units(app, ...
                        H_plot, M_plot, ...
                        "H [A/m]", source_M_unit, ...
                        H_label, M_label);
                    plot(ax, H_plot, M_plot, '.', 'Color', [0 0 0], 'LineWidth', 1.0, 'MarkerSize', 7, 'DisplayName', 'Measured');
                else
                    app.write_message("Warning: No input curve is available to plot in Playground.");
                end
            end

            [H_sim, M_sim, has_sim] = PlaygroundUtils.get_simulation_curve(app);
            if has_sim
                [H_sim, M_sim] = PlaygroundUtils.convert_playground_curve_units(app, ...
                    H_sim, M_sim, ...
                    "H [A/m]", source_M_unit, ...
                    H_label, M_label);
                plot(ax, H_sim, M_sim, 'r-', 'LineWidth', 1.2, 'DisplayName', 'JA simulated');
            end

            xline(ax, 0, 'k-', 'LineWidth', 1.2);
            yline(ax, 0, 'k-', 'LineWidth', 1.2);
            app.apply_detailed_grid(ax, app.ShowgridCheckBoxM_5.Value == 1);

            xlabel(ax, H_label);
            ylabel(ax, M_label);
            box(ax, 'on');
            ax.LineWidth = 1.2;
            legend(ax, 'off');
            hold(ax, 'off');
        end

        function sync_playground_mode_ui(app)
            mode = lower(string(app.HcaseDropDown.Value));

            if contains(mode, "harmonic")
                app.MajorloopPanel.Visible = 'off';
                app.MinorloopsPanel.Visible = 'off';
                app.DegaussingPanel.Visible = 'off';
                app.MajorloopwithharmonicsPanel.Visible = 'on';
            elseif contains(mode, "major loop")
                app.MajorloopPanel.Visible = 'on';
                app.MinorloopsPanel.Visible = 'off';
                app.DegaussingPanel.Visible = 'off';
                app.MajorloopwithharmonicsPanel.Visible = 'off';
            elseif contains(mode, "minor loop")
                app.MajorloopPanel.Visible = 'off';
                app.MinorloopsPanel.Visible = 'on';
                app.DegaussingPanel.Visible = 'off';
                app.MajorloopwithharmonicsPanel.Visible = 'off';
            elseif contains(mode, "degaussing")
                app.MajorloopPanel.Visible = 'off';
                app.MinorloopsPanel.Visible = 'off';
                app.DegaussingPanel.Visible = 'on';
                app.MajorloopwithharmonicsPanel.Visible = 'off';
            else
                app.MajorloopPanel.Visible = 'on';
                app.MinorloopsPanel.Visible = 'on';
                app.DegaussingPanel.Visible = 'on';
                app.MajorloopwithharmonicsPanel.Visible = 'on';
            end
        end

        function [H_unit, M_unit] = get_playground_axis_units(app)
            % VerticalaxisfieldDropDown_2's Items are kept in sync with
            % app.M_is_mass_based by sync_playground_mass_ui (locked to the
            % single sigma unit when mass-native, the usual volume-family
            % list otherwise), so its current Value is always valid here.
            H_unit = string(app.HorizontalaxisfieldDropDown_2.Value);
            M_unit = string(app.VerticalaxisfieldDropDown_2.Value);
        end

        function sync_playground_mass_ui(app)
            % Playground never offers an independent volume/mass choice --
            % it mirrors whatever the Input tab imported. When mass-native,
            % the vertical-axis dropdown is locked to the single sigma
            % unit, the JA Ms/alpha labels switch to sigma_S/rho*alpha, and
            % every "Mstart"-type field label (major/degaussing/harmonics
            % driving-field panels) switches to sigma_start. H-side fields
            % (Hstart, H amplitude, Initial/Final amplitude, a, k) are
            % never touched -- they're always the externally applied field.
            % Only rewrite Items/Value on an actual mode transition -- an
            % axis-unit-driven reprocess of the same file re-runs this
            % (via import_data) without changing app.M_is_mass_based, and
            % must not clobber a user's manually chosen volume sub-unit
            % (e.g. kA/m) every time.
            if app.M_is_mass_based
                mass_unit = char(DisplayUnits.get_M_label(app));
                if ~isequal(app.VerticalaxisfieldDropDown_2.Items, {mass_unit})
                    app.VerticalaxisfieldDropDown_2.Items = {mass_unit};
                    app.VerticalaxisfieldDropDown_2.Value = mass_unit;
                end
            else
                volume_items = {'M [A/m]', 'M [kA/m]', 'M [MA/m]', 'M [emu/cm^3]', 'J [T]', 'B [T]', 'B [G]', 'B [kG]'};
                if ~isequal(app.VerticalaxisfieldDropDown_2.Items, volume_items)
                    app.VerticalaxisfieldDropDown_2.Items = volume_items;
                    app.VerticalaxisfieldDropDown_2.Value = 'M [A/m]';
                end
            end

            DisplayUnits.apply_ja_labels(app, app.Ms_JA_PlaygroundLabel, app.alpha_JA_PlaygroundLabel);

            Mstart_label = char(DisplayUnits.get_Mstart_label(app));
            app.MstartAmEditFieldLabel.Text = Mstart_label;
            app.MstartAmEditField_2Label.Text = Mstart_label;
            app.MstartAmEditField_3Label.Text = Mstart_label;
        end

        function values = get_minor_loop_default_values(app)
            % default Htip_i are derived from the measured-curve tip
            % (Htip, Htip*2/3, Htip*1/3) when data is available; otherwise
            % fall back to a plain 1/2/3 placeholder. Display order is
            % cosmetic: the solver sorts the tips ascending and simulates
            % the smallest tip first.
            [Htip, ~, ok] = PlaygroundUtils.get_data_tip(app);
            if ok && isfinite(Htip) && Htip > 0
                values = [Htip; Htip*2/3; Htip*1/3; NaN];
            else
                values = [1; 2; 3; NaN];
            end
        end

        function configure_minor_loop_table(app)
            if ~isprop(app, 'UITable') || isempty(app.UITable) || ~isvalid(app.UITable)
                return;
            end

            app.UITable.SelectionType = 'cell';
            app.UITable.ColumnEditable = [true];
            app.UITable.ColumnFormat = {'short g'};
            app.UITable.Data = PlaygroundUtils.get_minor_loop_default_values(app);
            app.minor_loop_table_user_edited = false;   % table now holds untouched defaults
            % NOTE: CellEditCallback wiring stays on the app class -- createCallbackFcn is a
            % protected method of matlab.apps.AppBase and cannot be called from this class.
        end

        function maybe_refresh_minor_loop_defaults(app)
            % re-fill the Htip_i table with data-tip-based defaults, but
            % only while the user has not manually edited it (so we never
            % clobber user-entered tip fields).
            if ~isprop(app, 'UITable') || isempty(app.UITable) || ~isvalid(app.UITable)
                return;
            end
            if app.minor_loop_table_user_edited
                return;
            end
            app.UITable.Data = PlaygroundUtils.get_minor_loop_default_values(app);
            app.minor_loop_table_user_edited = false;
        end

        function expand_minor_loop_table_if_needed(app, event)
            if nargin < 2 || isempty(event) || ~isprop(app, 'UITable') || isempty(app.UITable) || ~isvalid(app.UITable)
                return;
            end

            if ~isprop(event, 'Indices') || isempty(event.Indices) || ~isprop(event, 'NewData')
                return;
            end

            row = event.Indices(1);
            new_value = event.NewData;
            if ~(isscalar(row) && isfinite(row) && row >= 1 && isfinite(new_value) && new_value > 0)
                return;
            end

            data = app.UITable.Data;
            if isempty(data) || ~isnumeric(data)
                return;
            end

            data = data(:);
            if row == numel(data)
                app.UITable.Data = [data; NaN];
            end
        end

        function refresh_playground_data_curve(app)
            app.playground_curve_H = [];
            app.playground_curve_M = [];
            app.playground_curve_ready = false;

            if isempty(app.H_raw) || isempty(app.M_raw)
                return;
            end

            if app.is_last_import_anhysteretic()
                H_plot = app.data_curve.H(:).';
                M_plot = app.data_curve.M(:).';
            else
                [H_plot, M_plot] = app.build_ja_data_cycle();
            end

            if ~isempty(H_plot) && ~isempty(M_plot) && numel(H_plot) >= 2 && numel(M_plot) >= 2
                app.playground_curve_H = H_plot;
                app.playground_curve_M = M_plot;
                app.playground_curve_ready = true;
            end
        end

        function [H_plot, M_plot, has_data] = get_playground_data_curve(app)
            if ~app.playground_curve_ready
                PlaygroundUtils.refresh_playground_data_curve(app);
            end

            H_plot = app.playground_curve_H;
            M_plot = app.playground_curve_M;
            has_data = app.playground_curve_ready && ~isempty(H_plot) && ~isempty(M_plot) ...
                && numel(H_plot) >= 2 && numel(M_plot) >= 2;
        end

        function [H_out, M_out] = convert_playground_curve_units(app, H_in, M_in, H_source_unit, M_source_unit, H_target_unit, M_target_unit)
            uc = UnitConvertor();
            H_source_unit = string(H_source_unit);
            M_source_unit = string(M_source_unit);
            H_target_unit = string(H_target_unit);
            M_target_unit = string(M_target_unit);

            H_source_factor = uc.UnitConversions(H_source_unit);
            H_target_factor = uc.UnitConversions(H_target_unit);
            M_source_factor = uc.UnitConversions(M_source_unit);
            M_target_factor = uc.UnitConversions(M_target_unit);

            H_base = H_in .* H_source_factor;
            H_out = H_base ./ H_target_factor;

            source_is_B = M_source_unit == "B [T]" || M_source_unit == "B [G]" || M_source_unit == "B [kG]";
            target_is_B = M_target_unit == "B [T]" || M_target_unit == "B [G]" || M_target_unit == "B [kG]";

            if source_is_B
                M_base = (M_in .* M_source_factor) - H_base;
            else
                M_base = M_in .* M_source_factor;
            end

            if target_is_B
                M_out = (M_base + H_base) ./ M_target_factor;
            else
                M_out = M_base ./ M_target_factor;
            end
        end

        function [Htips, ok] = get_minor_loop_inputs(app)
            Htips = [];
            ok = false;

            if ~isprop(app, 'UITable') || isempty(app.UITable) || ~isvalid(app.UITable)
                return;
            end

            raw = [];
            if isprop(app.UITable, 'Data')
                raw = app.UITable.Data;
            elseif isprop(app.UITable, 'Value')
                raw = app.UITable.Value;
            end

            if isempty(raw)
                return;
            end

            if isnumeric(raw)
                values = raw(:);
            else
                raw = string(raw);

                tokens = split(strjoin(raw(:).', newline), {newline, ",", ";", " "});
                tokens = tokens(strlength(strtrim(tokens)) > 0);
                values = str2double(replace(strtrim(tokens), ",", ""));
            end

            values = values(isfinite(values) & values > 0);
            if isempty(values)
                return;
            end

            Htips = sort(values(:), 'ascend');
            ok = true;
        end

        function run_playground_minor_loop(app, notify)
            if nargin < 2 || isempty(notify)
                notify = true;
            end
            failure_message = "The magnetization path cannot be computed with the current initial condition M(Hstart) and model parameters.";
            try
                [params, ok_params] = PlaygroundUtils.get_playground_params(app);
                if ~ok_params
                    PlaygroundUtils.clear_simulation(app);
                    app.plot_playground();
                    if notify
                        app.write_message(failure_message);
                    end
                    return;
                end

                [Htips, ok_inputs] = PlaygroundUtils.get_minor_loop_inputs(app);
                if ~ok_inputs
                    PlaygroundUtils.clear_simulation(app);
                    app.plot_playground();
                    if notify
                        app.write_message(failure_message);
                    end
                    return;
                end
                PlaygroundUtils.sync_minor_ui(app);

                [Hsim, Msim, info] = solve_ja_minor_loop_playground( ...
                    Htips, params, ...
                    string(app.StopcriterionDropDown_4.Value), ...
                    app.RepetitionsEditField_2.Value, ...
                    app.ReltoleranceEditField_5.Value, ...
                    app.MaxrepetitionsEditField_2.Value, ...
                    odeset('RelTol', 1e-7, 'AbsTol', 1e-6));
                info.status = "ok";
                PlaygroundUtils.set_simulation(app, Hsim, Msim, info);
                app.plot_playground();
            catch
                PlaygroundUtils.clear_simulation(app);
                app.plot_playground();
                app.write_message(failure_message);
            end
        end

        function run_playground_major_loop(app, notify)
            if nargin < 2 || isempty(notify)
                notify = true;
            end
            failure_message = "The magnetization path cannot be computed with the current initial condition M(Hstart) and model parameters.";
            [params, ok_params] = PlaygroundUtils.get_playground_params(app);
            if ~ok_params
                PlaygroundUtils.clear_simulation(app);
                app.plot_playground();
                if notify
                    app.write_message(failure_message);
                end
                return;
            end

            [Hstart, Mstart, Htip, ok_inputs] = PlaygroundUtils.get_major_inputs(app);
            if ~ok_inputs
                PlaygroundUtils.clear_simulation(app);
                app.plot_playground();
                if notify
                    app.write_message(failure_message);
                end
                return;
            end

            PlaygroundUtils.sync_major_ui(app);
            try
                [Hsim, Msim, info] = solve_ja_major_loop_playground( ...
                    Hstart, Mstart, Htip, params, ...
                    string(app.StartingpointDropDown.Value), ...
                    string(app.StopcriterionDropDown.Value), ...
                    app.RepetitionsEditField.Value, ...
                    app.ReltoleranceEditField_6.Value, ...
                    app.MaxrepetitionsEditField.Value, ...
                    odeset('RelTol', 1e-7, 'AbsTol', 1e-6));
                info.status = "ok";
                PlaygroundUtils.set_simulation(app, Hsim, Msim, info);
                app.plot_playground();
            catch
                PlaygroundUtils.clear_simulation(app);
                app.plot_playground();
                app.write_message(failure_message);
            end
        end

        % =====================================================
        %  Degaussing (Playground)
        % =====================================================

        function [Mr, ok] = get_data_remanence(app)
            % retrieve the remanence M(H=0)=Mr from the measured
            % hysteresis loop. The upper (descending) branch is extracted from
            % the raw data (converted to A/m) and M is interpolated at H = 0
            % with interp1. Only available when a hysteretic dataset has been
            % imported; an anhysteretic import carries no hysteresis loop.
            Mr = NaN;
            ok = false;

            if isempty(app.H_raw) || isempty(app.M_raw) || app.is_last_import_anhysteretic()
                return;
            end

            try
                H_unit = app.HorizontalaxisfieldDropDown.Value;
                M_unit = app.VerticalaxisfieldDropDown.Value;
                [H_conv, M_conv] = UnitConvertor().convert_H_M(app.H_raw, H_unit, app.M_raw, M_unit);

                % Upper (descending) branch, from the +tip corner through H=0
                % down to the -tip corner, in base units (A/m).
                [H_up, M_up] = extract_left_branch_uniform_arc(H_conv, M_conv, []);

                H_up = H_up(:);
                M_up = M_up(:);
                valid = isfinite(H_up) & isfinite(M_up);
                H_up = H_up(valid);
                M_up = M_up(valid);
                if numel(H_up) < 2 || min(H_up) > 0 || max(H_up) < 0
                    return;
                end

                % interp1 needs distinct sample points: sort by H and drop dups.
                [H_sorted, idx] = unique(H_up);
                M_sorted = M_up(idx);
                Mr = interp1(H_sorted, M_sorted, 0, 'linear');
                ok = isfinite(Mr);
            catch
                Mr = NaN;
                ok = false;
            end
        end

        function [amps, ok] = get_degaussing_amplitudes_auto(app)
            % build the automatic decaying degaussing envelope from the
            % user's N-of-steps, initial and final amplitude settings. A
            % geometric (exponential) decay is used when both amplitudes are
            % positive, which matches the physical AC-demagnetization envelope;
            % otherwise a linear ramp is used.
            amps = [];
            ok = false;

            N = round(app.NofstepsEditField.Value);
            A0 = app.InitialamplitudeAmEditField.Value;
            Af = app.FinalamplitudeAmEditField.Value;

            if ~isfinite(N) || N < 1 || ~isfinite(A0) || A0 <= 0 || ~isfinite(Af) || Af < 0
                return;
            end

            if N == 1
                amps = A0;
            elseif A0 > 0 && Af > 0
                amps = logspace(log10(A0), log10(Af), N);
            else
                amps = linspace(A0, Af, N);
            end

            amps = amps(isfinite(amps) & amps > 0);
            amps = sort(amps(:), 'descend');
            ok = ~isempty(amps);
        end

        function [amps, ok] = get_degaussing_table_inputs(app)
            % read the user-defined Htip_i amplitude table (UITable_3) and
            % return the reversal amplitudes sorted in descending order (largest
            % swing first) so they form a decaying degaussing envelope.
            amps = [];
            ok = false;

            if ~isprop(app, 'UITable_3') || isempty(app.UITable_3) || ~isvalid(app.UITable_3)
                return;
            end

            raw = [];
            if isprop(app.UITable_3, 'Data')
                raw = app.UITable_3.Data;
            elseif isprop(app.UITable_3, 'Value')
                raw = app.UITable_3.Value;
            end

            if isempty(raw)
                return;
            end

            if isnumeric(raw)
                values = raw(:);
            else
                raw = string(raw);
                tokens = split(strjoin(raw(:).', newline), {newline, ",", ";", " "});
                tokens = tokens(strlength(strtrim(tokens)) > 0);
                values = str2double(replace(strtrim(tokens), ",", ""));
            end

            values = values(isfinite(values) & values > 0);
            if isempty(values)
                return;
            end

            amps = sort(values(:), 'descend');
            ok = true;
        end

        function values = get_degaussing_default_table_values(app)
            % default Htip_i amplitudes derived from the measured-curve tip
            % (Htip, Htip*2/3, Htip*1/3) when data is available; otherwise a
            % plain placeholder. Display order is cosmetic — the solver sorts
            % the amplitudes descending.
            [Htip, ~, ok] = PlaygroundUtils.get_data_tip(app);
            if ok && isfinite(Htip) && Htip > 0
                values = [Htip; Htip*2/3; Htip*1/3; NaN];
            else
                values = [3; 2; 1; NaN];
            end
        end

        function configure_degaussing_table(app)
            % initialize the Degaussing user-defined amplitude table.
            if ~isprop(app, 'UITable_3') || isempty(app.UITable_3) || ~isvalid(app.UITable_3)
                return;
            end

            app.UITable_3.SelectionType = 'cell';
            app.UITable_3.ColumnEditable = [true];
            app.UITable_3.ColumnFormat = {'short g'};
            app.UITable_3.Data = PlaygroundUtils.get_degaussing_default_table_values(app);
            app.degaussing_user_edited = false;
            % NOTE: CellEditCallback wiring stays on the app class -- createCallbackFcn is a
            % protected method of matlab.apps.AppBase and cannot be called from this class.
        end

        function maybe_refresh_degaussing_defaults(app)
            % re-fill the Degaussing amplitude settings (N of steps,
            % initial = Htip, final = 0.02*Htip) and the amplitude table with
            % data-tip-based defaults, but only while the user has not manually
            % edited them (mirrors the minor-loop default behavior).
            if app.degaussing_user_edited
                return;
            end

            [Htip, ~, ok] = PlaygroundUtils.get_data_tip(app);
            if ok && isfinite(Htip) && Htip > 0
                app.NofstepsEditField.Value = 10;
                app.InitialamplitudeAmEditField.Value = Htip;
                app.FinalamplitudeAmEditField.Value = 0.02 * Htip;
            end

            if isprop(app, 'UITable_3') && ~isempty(app.UITable_3) && isvalid(app.UITable_3)
                app.UITable_3.Data = PlaygroundUtils.get_degaussing_default_table_values(app);
            end
        end

        function sync_degaussing_ui(app)
            % enable/disable and populate the Degaussing controls according
            % to the selected starting-point and H-amplitude options.
            if ~PlaygroundUtils.is_degaussing_mode(app)
                return;
            end

            start_mode = lower(string(app.StartingpointDropDown_3.Value));
            if contains(start_mode, "remanence")
                [Mr, ok_r] = PlaygroundUtils.get_data_remanence(app);
                app.HstartAmEditField_2.Value = 0;
                if ok_r
                    app.MstartAmEditField_2.Value = Mr;
                else
                    app.MstartAmEditField_2.Value = 0;
                end
                PlaygroundUtils.set_degaussing_start_enable(app, 'off');
            elseif contains(start_mode, "tip")
                [Htip, Mtip, ok_t] = PlaygroundUtils.get_data_tip(app);
                if ok_t
                    app.HstartAmEditField_2.Value = Htip;
                    app.MstartAmEditField_2.Value = Mtip;
                else
                    app.HstartAmEditField_2.Value = 0;
                    app.MstartAmEditField_2.Value = 0;
                end
                PlaygroundUtils.set_degaussing_start_enable(app, 'off');
            else
                PlaygroundUtils.set_degaussing_start_enable(app, 'on');
            end

            amp_mode = lower(string(app.HamplitudeDropDown.Value));
            if contains(amp_mode, "automatic")
                PlaygroundUtils.set_degaussing_auto_enable(app, 'on');
                PlaygroundUtils.set_degaussing_table_enable(app, 'off');
            else
                PlaygroundUtils.set_degaussing_auto_enable(app, 'off');
                PlaygroundUtils.set_degaussing_table_enable(app, 'on');
            end
        end

        function set_degaussing_start_enable(app, state)
            app.set_enable_safe(app.MstartAmEditField_2, state);
            app.set_enable_safe(app.HstartAmEditField_2, state);
            app.set_enable_safe(app.MstartAmEditField_2Label, state);
            app.set_enable_safe(app.HstartAmEditField_2Label, state);
        end

        function set_degaussing_auto_enable(app, state)
            app.set_enable_safe(app.NofstepsEditField, state);
            app.set_enable_safe(app.InitialamplitudeAmEditField, state);
            app.set_enable_safe(app.FinalamplitudeAmEditField, state);
            app.set_enable_safe(app.NofstepsEditFieldLabel, state);
            app.set_enable_safe(app.InitialamplitudeAmEditFieldLabel, state);
            app.set_enable_safe(app.FinalamplitudeAmEditFieldLabel, state);
        end

        function set_degaussing_table_enable(app, state)
            if isprop(app, 'UITable_3') && ~isempty(app.UITable_3) && isvalid(app.UITable_3)
                app.set_enable_safe(app.UITable_3, state);
            end
        end

        function set_enable_safe(~, component, state)
            % set the Enable property only when the component actually has
            % one (uilabel gained Enable only in recent releases), so graying
            % out never errors on older MATLAB.
            if ~isempty(component) && isvalid(component) && isprop(component, 'Enable')
                component.Enable = state;
            end
        end

        function [Hstart, Mstart, amplitudes, ok, message] = get_degaussing_inputs(app)
            % gather the degaussing starting point and amplitude schedule
            % from the UI. Returns ok=false plus a user-facing warning message
            % when a required data-derived quantity is unavailable.
            Hstart = NaN;
            Mstart = NaN;
            amplitudes = [];
            ok = false;
            message = "";

            start_mode = lower(string(app.StartingpointDropDown_3.Value));
            if contains(start_mode, "remanence")
                [Mr, ok_r] = PlaygroundUtils.get_data_remanence(app);
                if ~ok_r
                    message = "Warning: The data hysteresis loop is unavailable; the remanence (H=0, Mr) starting point cannot be retrieved. Import a hysteretic dataset or choose another starting point.";
                    return;
                end
                Hstart = 0;
                Mstart = Mr;
            elseif contains(start_mode, "tip")
                [Htip, Mtip, ok_t] = PlaygroundUtils.get_data_tip(app);
                if ~ok_t
                    message = "Warning: The data tip point (Htip, Mtip) is unavailable; import a dataset or choose another starting point.";
                    return;
                end
                Hstart = Htip;
                Mstart = Mtip;
            else
                Hstart = app.HstartAmEditField_2.Value;
                Mstart = app.MstartAmEditField_2.Value;
                if ~isfinite(Hstart) || ~isfinite(Mstart)
                    message = "Warning: User-defined Hstart and Mstart must be finite numbers.";
                    return;
                end
            end

            amp_mode = lower(string(app.HamplitudeDropDown.Value));
            if contains(amp_mode, "automatic")
                [amplitudes, ok_a] = PlaygroundUtils.get_degaussing_amplitudes_auto(app);
                if ~ok_a
                    message = "Warning: Invalid automatic H amplitude settings (need N >= 1 steps and a positive initial amplitude).";
                    return;
                end
            else
                [amplitudes, ok_a] = PlaygroundUtils.get_degaussing_table_inputs(app);
                if ~ok_a
                    message = "Warning: The user-defined H amplitude table must contain at least one positive value.";
                    return;
                end
            end

            ok = true;
        end

        function run_playground_degaussing(app, notify)
            if nargin < 2 || isempty(notify)
                notify = true;
            end
            failure_message = "The magnetization path cannot be computed with the current initial condition M(Hstart) and model parameters.";
            try
                [params, ok_params] = PlaygroundUtils.get_playground_params(app);
                if ~ok_params
                    PlaygroundUtils.clear_simulation(app);
                    app.plot_playground();
                    if notify
                        app.write_message(failure_message);
                    end
                    return;
                end

                [Hstart, Mstart, amplitudes, ok_inputs, message] = PlaygroundUtils.get_degaussing_inputs(app);
                if ~ok_inputs
                    PlaygroundUtils.clear_simulation(app);
                    app.plot_playground();
                    if notify
                        if strlength(message) > 0
                            app.write_message(message);
                        else
                            app.write_message(failure_message);
                        end
                    end
                    return;
                end

                PlaygroundUtils.sync_degaussing_ui(app);   % keep displayed start values consistent

                [Hsim, Msim, info] = solve_ja_degaussing_playground( ...
                    Hstart, Mstart, amplitudes, params, ...
                    odeset('RelTol', 1e-7, 'AbsTol', 1e-6));
                info.status = "ok";
                PlaygroundUtils.set_simulation(app, Hsim, Msim, info);
                app.plot_playground();
            catch
                PlaygroundUtils.clear_simulation(app);
                app.plot_playground();
                app.write_message(failure_message);
            end
        end

        function expand_degaussing_table_if_needed(app, event)
            % auto-grow the Degaussing amplitude table by one empty row when
            % the last row receives a valid positive value (mirrors the minor
            % loop table's growing behavior).
            if nargin < 2 || isempty(event) || ~isprop(app, 'UITable_3') || isempty(app.UITable_3) || ~isvalid(app.UITable_3)
                return;
            end

            if ~isprop(event, 'Indices') || isempty(event.Indices) || ~isprop(event, 'NewData')
                return;
            end

            row = event.Indices(1);
            new_value = event.NewData;
            if ~(isscalar(row) && isfinite(row) && row >= 1 && isfinite(new_value) && new_value > 0)
                return;
            end
            data = app.UITable_3.Data;
            if isempty(data) || ~isnumeric(data)
                return;
            end

            data = data(:);
            if row == numel(data)
                app.UITable_3.Data = [data; NaN];
            end
        end

        % =====================================================
        %  Major loop with harmonics (Playground)
        % =====================================================

        function [orders, amplitudes, phases, ok] = get_harmonics_table_inputs(app)
            % read the harmonic drive table (UITable2). Columns are
            % [Order k, Amplitude [A/m], Phase [deg]]. Rows with a non-integer
            % or missing order, or a missing amplitude, are dropped; a blank
            % phase is treated as 0 deg. Returns phases in DEGREES.
            orders = [];
            amplitudes = [];
            phases = [];
            ok = false;

            if ~isprop(app, 'UITable2') || isempty(app.UITable2) || ~isvalid(app.UITable2)
                return;
            end

            data = app.UITable2.Data;
            if isempty(data) || ~isnumeric(data) || size(data, 2) < 2
                return;
            end

            ord = data(:, 1);
            amp = data(:, 2);
            if size(data, 2) >= 3
                ph = data(:, 3);
            else
                ph = zeros(size(ord));
            end
            ph(~isfinite(ph)) = 0;   % blank phase => 0 deg

            keep = isfinite(ord) & ord >= 1 & isfinite(amp);
            ord = round(ord(keep));
            amp = amp(keep);
            ph = ph(keep);

            if isempty(ord) || ~any(abs(amp) > 0)
                return;
            end

            orders = ord(:);
            amplitudes = amp(:);
            phases = ph(:);
            ok = true;
        end

        function [Hstart, Mstart, orders, amplitudes, phases, ok, message] = get_harmonics_inputs(app)
            % gather the harmonic-drive starting point and the Fourier
            % components from the UI. Returns ok=false plus a user-facing
            % warning when a required data-derived quantity is unavailable or
            % the harmonics table is empty. phases are returned in RADIANS.
            Hstart = NaN;
            Mstart = NaN;
            orders = [];
            amplitudes = [];
            phases = [];
            ok = false;
            message = "";

            start_mode = lower(string(app.StartingpointDropDown_5.Value));
            if contains(start_mode, "demagnetized")
                Hstart = 0;
                Mstart = 0;
            elseif contains(start_mode, "tip")
                [Htip, Mtip, ok_t] = PlaygroundUtils.get_data_tip(app);
                if ~ok_t
                    message = "Warning: The data tip point (Htip, Mtip) is unavailable; import a dataset or choose another starting point.";
                    return;
                end
                Hstart = Htip;
                Mstart = Mtip;
            else
                Hstart = app.HstartAmEditField_3.Value;
                Mstart = app.MstartAmEditField_3.Value;
                if ~isfinite(Hstart) || ~isfinite(Mstart)
                    message = "Warning: User-defined Hstart and Mstart must be finite numbers.";
                    return;
                end
            end

            [orders, amplitudes, phases_deg, ok_tbl] = PlaygroundUtils.get_harmonics_table_inputs(app);
            if ~ok_tbl
                message = "Warning: The harmonics table must contain at least one row with an integer order >= 1 and a non-zero amplitude.";
                return;
            end

            phases = phases_deg * pi / 180;   % degrees -> radians
            ok = true;
        end

        function values = get_harmonics_default_table_values(app)
            % Default harmonic drive chosen to resemble the example waveform
            % more closely: a fundamental plus a few lower-amplitude odd harmonics
            % with zero phase, which already create nested minor loops without
            % overcomplicating the initial pattern.
            [Htip, ~, ok] = PlaygroundUtils.get_data_tip(app);
            if ok && isfinite(Htip) && Htip > 0
                A1 = Htip;
            else
                A1 = 1;
            end
            values = [1, A1,     0; ...
                      5, A1 / 2, 60; ...
                      NaN, NaN, NaN];
        end

        function configure_harmonics_table(app)
            % initialize the harmonic drive table.
            if ~isprop(app, 'UITable2') || isempty(app.UITable2) || ~isvalid(app.UITable2)
                return;
            end

            app.UITable2.ColumnEditable = [true true true];
            app.UITable2.ColumnFormat = {'numeric', 'short g', 'short g'};
            app.UITable2.Data = PlaygroundUtils.get_harmonics_default_table_values(app);
            app.harmonics_user_edited = false;
            % NOTE: CellEditCallback wiring stays on the app class -- createCallbackFcn is a
            % protected method of matlab.apps.AppBase and cannot be called from this class.
        end

        function maybe_refresh_harmonics_defaults(app)
            % re-fill the harmonic drive table with data-tip-based
            % defaults, but only while the user has not manually edited it
            % (mirrors the minor-loop / degaussing default behavior).
            if app.harmonics_user_edited
                return;
            end

            if isprop(app, 'UITable2') && ~isempty(app.UITable2) && isvalid(app.UITable2)
                app.UITable2.Data = PlaygroundUtils.get_harmonics_default_table_values(app);
            end
        end

        function sync_harmonics_ui(app)
            % enable/disable and populate the harmonic-drive controls
            % according to the selected starting point. There is no stop
            % criterion choice for this panel: the simulation always runs a
            % single fixed repetition (see run_playground_major_harmonics).
            if ~PlaygroundUtils.is_harmonics_mode(app)
                return;
            end

            start_mode = lower(string(app.StartingpointDropDown_5.Value));
            if contains(start_mode, "demagnetized")
                app.HstartAmEditField_3.Value = 0;
                app.MstartAmEditField_3.Value = 0;
                PlaygroundUtils.set_harmonics_start_enable(app, 'off');
            elseif contains(start_mode, "tip")
                [Htip, Mtip, ok_t] = PlaygroundUtils.get_data_tip(app);
                if ok_t
                    app.HstartAmEditField_3.Value = Htip;
                    app.MstartAmEditField_3.Value = Mtip;
                else
                    app.HstartAmEditField_3.Value = 0;
                    app.MstartAmEditField_3.Value = 0;
                end
                PlaygroundUtils.set_harmonics_start_enable(app, 'off');
            else
                PlaygroundUtils.set_harmonics_start_enable(app, 'on');
            end
        end

        function set_harmonics_start_enable(app, state)
            app.set_enable_safe(app.MstartAmEditField_3, state);
            app.set_enable_safe(app.HstartAmEditField_3, state);
            app.set_enable_safe(app.MstartAmEditField_3Label, state);
            app.set_enable_safe(app.HstartAmEditField_3Label, state);
        end

        function expand_harmonics_table_if_needed(app, event)
            % auto-grow the harmonics table by one empty row when the last
            % row receives a valid (order, amplitude) pair (mirrors the minor
            % loop / degaussing growing tables).
            if nargin < 2 || isempty(event) || ~isprop(app, 'UITable2') || isempty(app.UITable2) || ~isvalid(app.UITable2)
                return;
            end
            if ~isprop(event, 'Indices') || isempty(event.Indices)
                return;
            end

            data = app.UITable2.Data;
            if isempty(data) || ~isnumeric(data)
                return;
            end

            row = event.Indices(1);
            last_row = size(data, 1);
            if row == last_row
                ord = data(last_row, 1);
                amp = data(last_row, 2);
                if isfinite(ord) && ord >= 1 && isfinite(amp)
                    app.UITable2.Data = [data; NaN(1, size(data, 2))];
                end
            end
        end

        function run_playground_major_harmonics(app, notify)
            if nargin < 2 || isempty(notify)
                notify = true;
            end
            failure_message = "The magnetization path cannot be computed with the current initial condition M(Hstart) and model parameters.";
            try
                [params, ok_params] = PlaygroundUtils.get_playground_params(app);
                if ~ok_params
                    PlaygroundUtils.clear_simulation(app);
                    app.plot_playground();
                    if notify
                        app.write_message(failure_message);
                    end
                    return;
                end

                [Hstart, Mstart, orders, amplitudes, phases, ok_inputs, message] = PlaygroundUtils.get_harmonics_inputs(app);
                if ~ok_inputs
                    PlaygroundUtils.clear_simulation(app);
                    app.plot_playground();
                    if notify
                        if strlength(message) > 0
                            app.write_message(message);
                        else
                            app.write_message(failure_message);
                        end
                    end
                    return;
                end

                PlaygroundUtils.sync_harmonics_ui(app);   % keep displayed start values consistent

                [Hsim, Msim, info] = solve_ja_major_harmonics_playground( ...
                    Hstart, Mstart, orders, amplitudes, phases, params, ...
                    "Fixed repetitions", 1, [], ...
                    odeset('RelTol', 1e-7, 'AbsTol', 1e-6));
                info.start_mode = string(app.StartingpointDropDown_5.Value);
                info.status = "ok";
                PlaygroundUtils.set_simulation(app, Hsim, Msim, info);
                app.plot_playground();
            catch
                PlaygroundUtils.clear_simulation(app);
                app.plot_playground();
                app.write_message(failure_message);
            end
        end

        function run_playground_live(app)
            % live-recompute dispatcher shared by all Playground field/table
            % callbacks; mirrors CalculatePlotButton_3Pushed's mode dispatch but
            % suppresses the "not ready" message (notify=false) since this fires
            % on every completed field edit, not just an explicit button press.
            if PlaygroundUtils.is_minor_mode(app)
                PlaygroundUtils.run_playground_minor_loop(app, false);
            elseif PlaygroundUtils.is_degaussing_mode(app)
                PlaygroundUtils.run_playground_degaussing(app, false);
            elseif PlaygroundUtils.is_harmonics_mode(app)
                PlaygroundUtils.run_playground_major_harmonics(app, false);
            else
                PlaygroundUtils.run_playground_major_loop(app, false);
            end
        end
    end
end
