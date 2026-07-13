classdef MenuUtils
%MENUUTILS Static helpers for project Open/Save/Save-As.
%   Extracted from app_exported.m, mirroring the AnhystereticUtils/
%   HystereticUtils/PlaygroundUtils pattern: static methods taking `app` as
%   the first argument, called from thin delegator methods on the app class.
%   This logic is inherently cross-tab (a project file touches nearly every
%   field in the app), unlike the other Utils files which are scoped to one
%   tab.
%
%   The project file is a flat JSON struct (see simple_field_specs for the
%   bulk of it) plus a handful of special-cased groups (Anhysteretic table
%   bounds, JA fit bounds, Playground tables, export-dialog settings) that
%   need JSON-safe numeric encoding or non-trivial restore ordering.
%   Every new key is read with isfield() so older project files still load
%   (missing fields simply keep the post-reset/startup default).

    methods (Static)
        function specs = simple_field_specs()
            %SIMPLE_FIELD_SPECS {json_key, component_name} pairs for every
            %   plain-Value control (EditField/NumericEditField/DropDown/
            %   CheckBox/TextArea) across all tabs. Shared by save() and
            %   open_project() so the two can never drift out of sync on key
            %   names. Anything with non-trivial semantics (tables, JA
            %   bounds, colors, export settings, TableFittedParameters) is
            %   handled separately below.
            specs = { ...
                ... Input tab
                'input_path',                    'InputDatasetPath'; ...
                'horizontal_axis',                'HorizontalaxisfieldDropDown'; ...
                'vertical_axis',                  'VerticalaxisfieldDropDown'; ...
                'curve_type',                     'CurvetypeDropDown'; ...
                'input_axis_scale',               'InputAxisScaleDropDown'; ...
                'input_number_of_points',         'InputNumberofPointsEditField'; ...
                'description',                    'DescriptionTextArea'; ...
                ... Anhysteretic fitting tab
                'point_space',                    'PointSpaceDropDown'; ...
                'number_points',                  'NofpointsEditField'; ...
                'error_type',                     'ErrorDropDown'; ...
                'anh_show_grid_m',                'ShowgridCheckBoxM'; ...
                'anh_show_grid_dmdh',              'ShowgridCheckBoxdMdH'; ...
                'anh_show_grid_hdmdh',             'ShowgridCheckBoxHdMdH'; ...
                'anh_plot_components_m',          'PlotcomponentsCheckBoxM'; ...
                'anh_plot_components_dmdh',        'PlotcomponentsCheckBoxdMdH'; ...
                'anh_plot_components_hdmdh',       'PlotcomponentsCheckBoxHdMdH'; ...
                'anh_show_hcr_m',                 'ShowhcrCheckBoxM'; ...
                'anh_show_hcr_dmdh',                'ShowhcrCheckBoxdMdH'; ...
                'anh_show_hcr_hdmdh',               'ShowhcrCheckBoxHdMdH'; ...
                'axis_scale_m',                   'AxisScaleDropDownM'; ...
                'axis_scale_dMdH',                 'AxisScaleDropDowndMdH'; ...
                'axis_scale_hdMdH',                'AxisScaleDropDownHdMdH'; ...
                ... Hysteretic fitting tab
                'hysteretic_max_repetitions',     'MaximumrepetitionsEditField'; ...
                'hysteretic_rel_tolerance',       'RelativetoleranceEditField'; ...
                'hysteretic_repetitions',         'RepetitionsEditField_3'; ...
                'hysteretic_stop_criterion',      'StopcriterionDropDown_5'; ...
                'hysteretic_fitting_region',      'FittingregionDropDown'; ...
                'hysteretic_starting_point',      'StartingpointDropDown_4'; ...
                'hysteretic_error_type',          'ErrortominimizeDropDown_2'; ...
                'hysteretic_show_grid',           'ShowgridCheckBoxM_2'; ...
                'hysteretic_fit_ms',              'CheckBox'; ...
                'hysteretic_fit_a',               'CheckBox_2'; ...
                'hysteretic_fit_alpha',           'CheckBox_3'; ...
                'hysteretic_fit_c',               'CheckBox_4'; ...
                'hysteretic_fit_k',               'FitkCheckBox'; ...
                'hysteretic_k_constrained',       'kConstrainedCheckBox_2'; ...
                ... Playground tab -- shared controls
                'play_horizontal_axis',           'HorizontalaxisfieldDropDown_2'; ...
                'play_vertical_axis',             'VerticalaxisfieldDropDown_2'; ...
                'play_show_grid',                 'ShowgridCheckBoxM_5'; ...
                'play_show_data_curve',           'ShowgridCheckBoxM_4'; ...
                'play_mode',                      'HcaseDropDown'; ...
                ... Playground -- Major loop panel
                'play_major_starting_point',      'StartingpointDropDown'; ...
                'play_major_hstart',              'HstartAmEditField'; ...
                'play_major_mstart',              'MstartAmEditField'; ...
                'play_major_hamplitude',          'HamplitudeAmEditField'; ...
                'play_major_stop_criterion',      'StopcriterionDropDown'; ...
                'play_major_repetitions',         'RepetitionsEditField'; ...
                'play_major_rel_tolerance',       'ReltoleranceEditField_6'; ...
                'play_major_max_repetitions',     'MaxrepetitionsEditField'; ...
                'play_major_plot_option',         'PlotDropDown'; ...
                ... Playground -- Minor loops panel
                'play_minor_stop_criterion',      'StopcriterionDropDown_4'; ...
                'play_minor_repetitions',         'RepetitionsEditField_2'; ...
                'play_minor_rel_tolerance',       'ReltoleranceEditField_5'; ...
                'play_minor_max_repetitions',     'MaxrepetitionsEditField_2'; ...
                'play_minor_plot_option',         'PlotDropDown_2'; ...
                ... Playground -- Degaussing panel
                'play_degauss_starting_point',    'StartingpointDropDown_3'; ...
                'play_degauss_hstart',            'HstartAmEditField_2'; ...
                'play_degauss_mstart',            'MstartAmEditField_2'; ...
                'play_degauss_amplitude_mode',    'HamplitudeDropDown'; ...
                'play_degauss_n_steps',           'NofstepsEditField'; ...
                'play_degauss_initial_amplitude', 'InitialamplitudeAmEditField'; ...
                'play_degauss_final_amplitude',   'FinalamplitudeAmEditField'; ...
                ... Playground -- Major loop with harmonics panel
                'play_harm_starting_point',       'StartingpointDropDown_5'; ...
                'play_harm_hstart',               'HstartAmEditField_3'; ...
                'play_harm_mstart',               'MstartAmEditField_3'; ...
                };
        end

        function txt = num_to_json_safe_str(value)
            %NUM_TO_JSON_SAFE_STR Render a scalar double as text so Inf/-Inf/
            %   NaN survive a jsonencode/jsondecode round trip (both collapse
            %   to JSON null and decode back as NaN otherwise -- verified:
            %   Inf and -Inf are indistinguishable once encoded as bare
            %   numbers). Empty stays empty (used for "auto"/unset bounds).
            if isempty(value)
                txt = '';
            else
                txt = sprintf('%.17g', value);
            end
        end

        function value = json_safe_str_to_num(txt)
            txt = strtrim(char(txt));
            if isempty(txt)
                value = [];
            else
                value = str2double(txt);
            end
        end

        function c = num_array_to_json_safe_cell(arr)
            c = arrayfun(@(v) MenuUtils.num_to_json_safe_str(v), arr(:), 'UniformOutput', false);
        end

        function arr = json_safe_cell_to_num_array(c)
            if isempty(c)
                arr = [];
                return;
            end
            arr = cellfun(@(v) MenuUtils.json_safe_str_to_num(v), c(:));
        end

        function save(app)
            file = fopen(app.ProjectPath,'w');

            s = struct();
            specs = MenuUtils.simple_field_specs();
            for i = 1:size(specs, 1)
                s.(specs{i,1}) = app.(specs{i,2}).Value;
            end

            s.number_components = app.number_components;
            s.select_a = app.TableParameters.Data.(5);

            % --- Anhysteretic fitted-parameter table (full precision; see
            % refresh_table_value_display -- the table's own columns 3/4 are
            % only a sigfig-rounded *display* of app.lb/app.ub) ---
            s.fitted_parameters_value = app.fitted_parameter_values(:);
            s.anh_lb = MenuUtils.num_array_to_json_safe_cell(app.lb);
            s.anh_ub = MenuUtils.num_array_to_json_safe_cell(app.ub);
            s.fitted_parameters_fit_flags = cell2mat(app.select_fit);

            % --- Hysteretic (JA) fit parameters + bounds ---
            s.params = struct( ...
                'Ms', app.Ms_JA.Value, ...
                'a', app.a_JA.Value, ...
                'alpha', app.alpha_JA.Value, ...
                'c', app.c_JA.Value, ...
                'k', app.k_JA.Value ...
            );
            s.hysteretic_bounds = struct( ...
                'Ms_lower', MenuUtils.num_to_json_safe_str(app.MsLower_JA.Value), ...
                'Ms_upper', MenuUtils.num_to_json_safe_str(app.MsUpper_JA.Value), ...
                'a_lower', MenuUtils.num_to_json_safe_str(app.aLower_JA.Value), ...
                'a_upper', MenuUtils.num_to_json_safe_str(app.aUpper_JA.Value), ...
                'alpha_lower', MenuUtils.num_to_json_safe_str(app.alphaLower_JA.Value), ...
                'alpha_upper', MenuUtils.num_to_json_safe_str(app.alphaUpper_JA.Value), ...
                'k_lower', MenuUtils.num_to_json_safe_str(app.kLower_JA.Value), ...
                'k_upper', MenuUtils.num_to_json_safe_str(app.kUpper_JA.Value), ...
                'c_lower', MenuUtils.num_to_json_safe_str(app.cLower_JA.Value), ...
                'c_upper', MenuUtils.num_to_json_safe_str(app.cUpper_JA.Value) ...
            );

            % --- Playground (forward-sim) JA parameters ---
            s.play_params = struct( ...
                'Ms', app.Ms_JA_Playground.Value, ...
                'a', app.a_JA_Playground.Value, ...
                'alpha', app.alpha_JA_Playground.Value, ...
                'c', app.c_JA_Playground.Value, ...
                'k', app.k_JA_Playground.Value ...
            );

            % --- Playground growing tables ---
            s.play_minor_tips = app.UITable.Data;
            s.play_degauss_amplitudes = app.UITable_3.Data;
            s.play_harm_table = app.UITable2.Data;

            % --- Anhysteretic custom curve colors ---
            s.colors = app.Colors;

            % --- Export dialog (folder/prefix/format/checked items) ---
            s.export_settings = app.export_settings;

            data = jsonencode(s, PrettyPrint=true);
            fprintf(file, "%s", data);
            fclose(file);
            app.write_message("Project saved at " + app.ProjectPath);
        end

        function open_project(app)
            app.write_message("Opening new project");
            pause(0.01);

            fullpath = app.safe_getfile('*.txt', ...
                FileDialogUtils.default_project_folder(app), ...
                "Select project");

            if fullpath == ""
                app.write_message("Open cancelled");
                return;
            end

            app.ProjectPath = fullpath;

            data = fileread(app.ProjectPath);
            s = jsondecode(data);

            app.number_components = s.number_components;
            app.init_components();
            app.configure_minor_loop_table();
            app.configure_degaussing_table();
            app.configure_harmonics_table();
            app.init_parameters_table(true);
            app.init_quantities_table(true);
            app.NofcompSpinner.Value = app.number_components;

            % --- Every plain Value-holding control, in one pass ---
            specs = MenuUtils.simple_field_specs();
            for i = 1:size(specs, 1)
                key = specs{i,1};
                if isfield(s, key)
                    app.(specs{i,2}).Value = s.(key);
                end
            end
            % Backward-compat: pre-2.7 files only ever wrote the HdMdH grid/
            % components checkboxes (as a single shared value) and never
            % actually wrote the "show Hcr" value at all (save() omitted it,
            % so it silently always fell back to the default below).
            if ~isfield(s, 'anh_show_grid_m') && isfield(s, 'fitting_show_grid_checkbox')
                app.ShowgridCheckBoxM.Value = s.fitting_show_grid_checkbox;
                app.ShowgridCheckBoxdMdH.Value = s.fitting_show_grid_checkbox;
            end
            if ~isfield(s, 'anh_plot_components_m') && isfield(s, 'fitting_plot_components_checkbox')
                app.PlotcomponentsCheckBoxM.Value = s.fitting_plot_components_checkbox;
                app.PlotcomponentsCheckBoxdMdH.Value = s.fitting_plot_components_checkbox;
            end
            if ~isfield(s, 'anh_show_hcr_m')
                show_hcr_value = 1;
                if isfield(s, 'fitting_show_hcr_checkbox')
                    show_hcr_value = s.fitting_show_hcr_checkbox;
                end
                app.ShowhcrCheckBoxM.Value = show_hcr_value;
                app.ShowhcrCheckBoxdMdH.Value = show_hcr_value;
                app.ShowhcrCheckBoxHdMdH.Value = show_hcr_value;
            end

            % --- select_a (per-component high/low root) ---
            if isfield(s, 'select_a')
                app.TableParameters.Data.(5) = cellstr(s.select_a);
                app.TableParameters.Data.(5) = categorical(app.TableParameters.Data.(5), {'high', 'low'}, 'Ordinal', true);
            end

            % --- Anhysteretic fitted-parameter table (full precision) ---
            if isfield(s, 'fitted_parameters_value')
                app.fitted_parameter_values = s.fitted_parameters_value(:);
            end
            if isfield(s, 'anh_lb') && isfield(s, 'anh_ub')
                lb_vals = MenuUtils.json_safe_cell_to_num_array(s.anh_lb);
                ub_vals = MenuUtils.json_safe_cell_to_num_array(s.anh_ub);
                app.lb = lb_vals(:)';
                app.ub = ub_vals(:)';
            elseif isfield(s, 'fitted_parameters_lower_bound') && isfield(s, 'fitted_parameters_upper_bound')
                % Legacy (pre-2.7) files stored the sigfig-rounded display
                % strings instead of the full-precision bound arrays.
                app.lb = cellfun(@(v) str2double(v), cellstr(s.fitted_parameters_lower_bound(:)))';
                app.ub = cellfun(@(v) str2double(v), cellstr(s.fitted_parameters_upper_bound(:)))';
            end
            AnhystereticUtils.refresh_table_value_display(app);
            if isfield(s, 'fitted_parameters_fit_flags')
                app.select_fit = num2cell(logical(s.fitted_parameters_fit_flags(:)));
                app.TableFittedParameters.Data(:,5) = app.select_fit;
            end

            % --- Hysteretic (JA) fit parameters + bounds ---
            if isfield(s, 'params')
                if isfield(s.params, 'Ms'); app.Ms_JA.Value = str2double(string(s.params.Ms)); end
                if isfield(s.params, 'a'); app.a_JA.Value = str2double(string(s.params.a)); end
                if isfield(s.params, 'alpha'); app.alpha_JA.Value = str2double(string(s.params.alpha)); end
                if isfield(s.params, 'c'); app.c_JA.Value = str2double(string(s.params.c)); end
                if isfield(s.params, 'k'); app.k_JA.Value = str2double(string(s.params.k)); end
            end
            if isfield(s, 'hysteretic_bounds')
                b = s.hysteretic_bounds;
                app.MsLower_JA.Value = MenuUtils.json_safe_str_to_num(b.Ms_lower);
                app.MsUpper_JA.Value = MenuUtils.json_safe_str_to_num(b.Ms_upper);
                app.aLower_JA.Value = MenuUtils.json_safe_str_to_num(b.a_lower);
                app.aUpper_JA.Value = MenuUtils.json_safe_str_to_num(b.a_upper);
                app.alphaLower_JA.Value = MenuUtils.json_safe_str_to_num(b.alpha_lower);
                app.alphaUpper_JA.Value = MenuUtils.json_safe_str_to_num(b.alpha_upper);
                app.kLower_JA.Value = MenuUtils.json_safe_str_to_num(b.k_lower);
                app.kUpper_JA.Value = MenuUtils.json_safe_str_to_num(b.k_upper);
                app.cLower_JA.Value = MenuUtils.json_safe_str_to_num(b.c_lower);
                app.cUpper_JA.Value = MenuUtils.json_safe_str_to_num(b.c_upper);
                app.hysteretic_ms_lower_bound_user_edited = true;
            end
            app.sync_k_fit_mode_ui();
            app.sync_hysteretic_fitting_ui();

            % --- Playground (forward-sim) JA parameters ---
            if isfield(s, 'play_params')
                p = s.play_params;
                if isfield(p, 'Ms'); app.Ms_JA_Playground.Value = str2double(string(p.Ms)); end
                if isfield(p, 'a'); app.a_JA_Playground.Value = str2double(string(p.a)); end
                if isfield(p, 'alpha'); app.alpha_JA_Playground.Value = str2double(string(p.alpha)); end
                if isfield(p, 'c'); app.c_JA_Playground.Value = str2double(string(p.c)); end
                if isfield(p, 'k'); app.k_JA_Playground.Value = str2double(string(p.k)); end
            end

            % --- Playground growing tables ---
            if isfield(s, 'play_minor_tips')
                app.UITable.Data = s.play_minor_tips;
                app.minor_loop_table_user_edited = true;
            end
            if isfield(s, 'play_degauss_amplitudes')
                app.UITable_3.Data = s.play_degauss_amplitudes;
                app.degaussing_user_edited = true;
            end
            if isfield(s, 'play_harm_table')
                app.UITable2.Data = s.play_harm_table;
                app.harmonics_user_edited = true;
            end

            % --- Anhysteretic custom curve colors ---
            if isfield(s, 'colors')
                app.Colors = s.colors;
            end
            app.apply_component_color_styles();

            % --- Export dialog settings ---
            if isfield(s, 'export_settings')
                app.export_settings = s.export_settings;
            end

            % --- Re-sync Playground UI to match the restored mode/fields ---
            app.sync_playground_mode_ui();
            PlaygroundUtils.sync_major_ui(app);
            PlaygroundUtils.sync_minor_ui(app);
            app.sync_degaussing_ui();
            app.sync_harmonics_ui();
            PlaygroundUtils.clear_simulation(app);

            if (app.calculate_and_plot() == -1)
                return
            end
            app.calculate_plot_and_refresh_hysteretic();

            [~, name, ext] = fileparts(app.ProjectPath);
            app.write_message(name + ext + " was opened successfully");
        end

        function save_project(app)
            start_folder = FileDialogUtils.default_project_folder(app);
            app.ensure_folder(start_folder);
            fullpath = app.safe_putfile('*.txt', start_folder, ...
                "Save project", "project.txt");

            if fullpath == ""
                return;
            end

            app.ProjectPath = fullpath;
            app.save();
        end

        function save_or_prompt(app)
            %SAVE_OR_PROMPT "Save" menu behavior: silently overwrite the
            %   already-known project file, or fall back to the Save-As
            %   prompt the first time (no ProjectPath yet this session).
            if strlength(string(app.ProjectPath)) > 0
                app.save();
            else
                MenuUtils.save_project(app);
            end
        end

        function new_project(app)
            %NEW_PROJECT "New" menu item: resets the whole app to a
            %   startup-like state without closing/reopening it. Destructive
            %   (loses anything unsaved), so confirm first.
            selection = uiconfirm(app.MagAnalystUIFigure, ...
                "Unsaved changes will be lost. Continue?", "New Project", ...
                "Options", {'Continue', 'Cancel'}, ...
                "DefaultOption", 2, "CancelOption", 2, "Icon", "warning");
            if ~strcmp(selection, 'Continue')
                return;
            end
            MenuUtils.reset_app(app);
        end

        function reset_app(app)
            %RESET_APP Clear all four tabs' data/tables/plots/caches back to
            %   a startup-like state. The deprecated (detached) Output-data
            %   tab and its Save/Save-as-linked fields are deliberately left
            %   untouched -- see CLAUDE.md 2a and src/Menus/README.md.

            % --- Input tab ---
            app.H_raw = [];
            app.M_raw = [];
            app.data_curve = [];
            app.imported_curve_type = "";
            app.M_is_mass_based = false;
            app.last_import_folder = "";
            app.InputDatasetPath.Value = '';
            app.DescriptionTextArea.Value = {''};
            cla(app.AxesRawInputData, 'reset');
            cla(app.AxesProcessedInputData, 'reset');

            % --- Anhysteretic fitting tab ---
            app.modeled_curve = [];
            app.Hcr = [];
            app.mcr = [];
            app.Hx = [];
            app.magnetic_parameters = [];
            app.fitted_parameter_values = [];
            app.component_row_types = [];
            app.lb = [];
            app.ub = [];
            app.select_fit = [];
            app.NofcompSpinner.Value = 1;
            app.number_components = 1;
            app.init_components();
            app.init_parameters_table(true);
            app.init_quantities_table(true);
            cla(app.AxesM, 'reset');
            cla(app.AxesdMdH, 'reset');
            cla(app.AxesHdMdH, 'reset');
            app.ErrorDisplay.Value = [];
            app.JsField.Value = [];
            app.chiinField.Value = [];

            % --- Hysteretic fitting tab ---
            app.Ms_JA.Value = [];
            app.a_JA.Value = [];
            app.alpha_JA.Value = [];
            app.k_JA.Value = [];
            app.c_JA.Value = 1/3;
            app.MsLower_JA.Value = 0;
            app.MsUpper_JA.Value = Inf;
            app.aLower_JA.Value = 0;
            app.aUpper_JA.Value = Inf;
            app.alphaLower_JA.Value = -Inf;
            app.alphaUpper_JA.Value = Inf;
            app.cLower_JA.Value = 0;
            app.cUpper_JA.Value = 1;
            app.kLower_JA.Value = 0;
            app.kUpper_JA.Value = Inf;
            app.Htip.Value = [];
            app.Mtip.Value = [];
            cla(app.AxesM_2, 'reset');
            app.ErrorDisplay_2.Value = [];
            app.hysteretic_ms_lower_bound_user_edited = false;

            % --- Playground tab ---
            PlaygroundUtils.clear_simulation(app);
            app.configure_minor_loop_table();
            app.configure_degaussing_table();
            app.configure_harmonics_table();
            app.HcaseDropDown.Value = 'Major loop';
            app.sync_playground_mode_ui();
            PlaygroundUtils.sync_major_ui(app);
            PlaygroundUtils.sync_minor_ui(app);
            app.sync_degaussing_ui();
            app.sync_harmonics_ui();
            cla(app.AxesM_5, 'reset');
            app.playground_curve_H = [];
            app.playground_curve_M = [];
            app.playground_curve_ready = false;
            app.Ms_JA_Playground.Value = [];
            app.a_JA_Playground.Value = [];
            app.alpha_JA_Playground.Value = [];
            app.c_JA_Playground.Value = [];
            app.k_JA_Playground.Value = [];

            % --- Cross-cutting ---
            app.ProjectPath = "";
            FitProgressUtils.close(app);
            if isappdata(app.MagAnalystUIFigure, 'fit_rerun_signature_anh')
                rmappdata(app.MagAnalystUIFigure, 'fit_rerun_signature_anh');
            end
            if isappdata(app.MagAnalystUIFigure, 'fit_rerun_signature_hyst')
                rmappdata(app.MagAnalystUIFigure, 'fit_rerun_signature_hyst');
            end
            if ~isempty(app.ColorDialogApp) && isvalid(app.ColorDialogApp)
                delete(app.ColorDialogApp);
            end
            app.ColorDialogApp = [];
            app.MessagesTextArea.Value = {''};
            app.write_message("New project started.");
        end
    end
end
