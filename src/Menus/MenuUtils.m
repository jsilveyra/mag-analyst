classdef MenuUtils
%MENUUTILS Static helpers for project Open/Save/Save-As.
%   Mirrors the AnhystereticUtils/
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

            % --- "reduce dof" state: the checkbox, plus the directly-fit
            % physical parameters when the last fit was a physical (unchecked)
            % refinement (Hcr/mcr/Hx are then stale and can't reproduce them). ---
            if isprop(app, 'ReduceDofCheckBox') && ~isempty(app.ReduceDofCheckBox)
                s.reduce_dof = logical(app.ReduceDofCheckBox.Value);
            end
            s.physical_fit_active = isprop(app, 'physical_fit_active') && logical(app.physical_fit_active);
            if s.physical_fit_active && isobject(app.magnetic_parameters) && ~isempty(app.magnetic_parameters.Ms)
                s.physical_Ms = app.magnetic_parameters.Ms(:);
                s.physical_alpha = app.magnetic_parameters.alpha(:);
                s.physical_a = app.magnetic_parameters.a(:);
            end

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
            app.ProjectDirty = false;
            MenuUtils.update_window_title(app);
            app.write_message("Project saved at " + app.ProjectPath);
        end

        function open_project(app)
            if app.fitting_in_progress
                uialert(app.MagAnalystUIFigure, ...
                    "A fit is currently running. Stop it before opening a project.", ...
                    "Fit in progress", "Icon", "warning");
                return;
            end
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
            app.NofcomponentsSpinner.Value = app.number_components;

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

            % --- "reduce dof" physical-fit state: restore the checkbox and,
            % if the saved project ended in physical mode, rebuild
            % magnetic_parameters directly from the stored Ms/alpha/a BEFORE the
            % plot below (so it isn't overwritten from the stale Hcr/mcr/Hx). ---
            if isprop(app, 'ReduceDofCheckBox') && ~isempty(app.ReduceDofCheckBox) && isfield(s, 'reduce_dof')
                app.ReduceDofCheckBox.Value = logical(s.reduce_dof);
            end
            if isprop(app, 'physical_fit_active')
                app.physical_fit_active = false;
                if isfield(s, 'physical_fit_active') && logical(s.physical_fit_active) ...
                        && isfield(s, 'physical_Ms') && isfield(s, 'physical_alpha') && isfield(s, 'physical_a')
                    physical.Ms = s.physical_Ms(:).';
                    physical.alpha = s.physical_alpha(:).';
                    physical.a = s.physical_a(:).';
                    if numel(physical.Ms) == app.number_components
                        app.magnetic_parameters = MagneticParameters(app.data_curve, [], [], [], [], physical);
                        app.physical_fit_active = true;
                    end
                end
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

            app.ProjectDirty = false;
            MenuUtils.update_window_title(app);
            [~, name, ext] = fileparts(app.ProjectPath);
            app.write_message(name + ext + " was opened successfully");
        end

        function save_project(app)
            start_folder = FileDialogUtils.default_project_folder(app);
            app.ensure_folder(start_folder);
            default_name = "project.txt";
            csv_path = string(app.InputDatasetPath.Value);
            if strlength(csv_path) > 0
                [~, csv_name] = fileparts(csv_path);
                if strlength(csv_name) > 0
                    default_name = csv_name + ".txt";
                end
            end
            fullpath = app.safe_putfile('*.txt', start_folder, ...
                "Save project", char(default_name));

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
            if app.fitting_in_progress
                uialert(app.MagAnalystUIFigure, ...
                    "A fit is currently running. Stop it before starting a new project.", ...
                    "Fit in progress", "Icon", "warning");
                return;
            end
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
            %   untouched -- see src/Menus/README.md.

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
            if isprop(app, 'physical_fit_active')
                app.physical_fit_active = false;
            end
            if isprop(app, 'ReduceDofCheckBox') && ~isempty(app.ReduceDofCheckBox)
                app.ReduceDofCheckBox.Value = true;
            end
            app.fitted_parameter_values = [];
            app.component_row_types = [];
            app.lb = [];
            app.ub = [];
            app.select_fit = [];
            app.NofcomponentsSpinner.Value = 1;
            app.number_components = 1;
            app.init_components();
            app.init_parameters_table(true);
            app.init_quantities_table(true);
            AnhystereticUtils.sync_reduce_dof_ui(app);
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
            app.c_JA.Value = [];
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
            app.LWModel_eq.Text = DisplayUnits.get_lw_model_eq(app);
            DisplayUnits.apply_ja_model_eqs(app, app.JAmodel_eq1, app.JAmodel_eq2, app.JAmodel_eq3);

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
            PlaygroundUtils.sync_playground_mass_ui(app);
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
            app.ProjectDirty = false;
            MenuUtils.update_window_title(app);
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

        function mark_project_dirty(app)
            %MARK_PROJECT_DIRTY Flag the open project as having unsaved
            %   changes and refresh the window title to show it (see
            %   update_window_title). Called from every place that writes
            %   state save() would persist -- component listeners wired by
            %   setup_dirty_tracking() cover user-driven edits; fit/import/
            %   retrieve-parameters/color call sites mark it explicitly
            %   since those write component Values programmatically, which
            %   does not fire the components' own change events.
            app.ProjectDirty = true;
            MenuUtils.update_window_title(app);
        end

        function update_window_title(app)
            %UPDATE_WINDOW_TITLE Keep the main window title in sync with
            %   the loaded project and its dirty state:
            %   "MagAnalyst - <project name> [*]", MATLAB-style, with
            %   "Untitled" before anything has been opened/saved.
            if strlength(string(app.ProjectPath)) > 0
                [~, name, ext] = fileparts(app.ProjectPath);
                project_name = string(name) + string(ext);
            else
                project_name = "Untitled";
            end
            if app.ProjectDirty
                suffix = " *";
            else
                suffix = "";
            end
            app.MagAnalystUIFigure.Name = char("MagAnalyst - " + project_name + suffix);
        end

        function setup_dirty_tracking(app)
            %SETUP_DIRTY_TRACKING Wire a change listener to every control
            %   whose value save() persists, so any user edit marks the
            %   project dirty. Uses addlistener rather than each
            %   component's ValueChangedFcn/CellEditCallback so it runs
            %   alongside the component's existing wiring instead of
            %   replacing it. Called once from startupFcn.
            value_components = MenuUtils.simple_field_specs();
            value_components = value_components(:,2)';
            extra_value_components = { ...
                'NofcomponentsSpinner', ...
                'Ms_JA', 'a_JA', 'alpha_JA', 'c_JA', 'k_JA', ...
                'MsLower_JA', 'MsUpper_JA', 'aLower_JA', 'aUpper_JA', ...
                'alphaLower_JA', 'alphaUpper_JA', 'kLower_JA', 'kUpper_JA', ...
                'cLower_JA', 'cUpper_JA', ...
                'Ms_JA_Playground', 'a_JA_Playground', 'alpha_JA_Playground', ...
                'c_JA_Playground', 'k_JA_Playground', ...
                };
            for name = [value_components, extra_value_components]
                addlistener(app.(name{1}), 'ValueChanged', @(~,~) MenuUtils.mark_project_dirty(app));
            end

            table_components = {'TableParameters', 'TableFittedParameters', ...
                'UITable', 'UITable_3', 'UITable2'};
            for name = table_components
                addlistener(app.(name{1}), 'CellEdit', @(~,~) MenuUtils.mark_project_dirty(app));
            end
        end
    end
end
