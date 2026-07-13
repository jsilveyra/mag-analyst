classdef MenuUtils
%MENUUTILS Static helpers for project Open/Save/Save-As.
%   Extracted from app_exported.m, mirroring the AnhystereticUtils/
%   HystereticUtils/PlaygroundUtils pattern: static methods taking `app` as
%   the first argument, called from thin delegator methods on the app class.
%   This logic is inherently cross-tab (a project file touches nearly every
%   field in the app), unlike the other Utils files which are scoped to one
%   tab.

    methods (Static)
        function save(app)
            file = fopen(app.ProjectPath,'w');

            s.fitted_parameters_value = app.fitted_parameter_values(:);
            s.fitted_parameters_lower_bound = app.TableFittedParameters.Data(:,3);
            s.fitted_parameters_upper_bound = app.TableFittedParameters.Data(:,4);
            s.number_components = app.number_components;
            s.select_a = app.TableParameters.Data.(5);
            s.number_points = app.NofpointsEditField.Value;
            s.point_space = app.PointSpaceDropDown.Value;
            s.error_type = app.ErrorDropDown.Value;
            s.input_path = app.InputDatasetPath.Value;
            s.horizontal_axis = app.HorizontalaxisfieldDropDown.Value;
            s.vertical_axis = app.VerticalaxisfieldDropDown.Value;
            s.curve_type = app.CurvetypeDropDown.Value;
            s.description = app.DescriptionTextArea.Value;

            s.input_axis_scale = app.InputAxisScaleDropDown.Value;
            s.axis_scale_m = app.AxisScaleDropDownM.Value;
            s.axis_scale_dMdH = app.AxisScaleDropDowndMdH.Value;
            s.axis_scale_hdMdH = app.AxisScaleDropDownHdMdH.Value;
            s.fitting_show_grid_checkbox = app.ShowgridCheckBoxHdMdH.Value;
            s.fitting_plot_components_checkbox = app.PlotcomponentsCheckBoxHdMdH.Value;
            s.fitting_show_hcr_checkbox = app.ShowhcrCheckBoxHdMdH.Value;

            s.params = struct( ...
                'Ms', app.Ms_JA.Value, ...
                'a', app.a_JA.Value, ...
                'alpha', app.alpha_JA.Value, ...
                'c', app.c_JA.Value, ...
                'k', app.k_JA.Value ...
            );

            data = jsonencode(s, PrettyPrint=true);
            fprintf(file, "%s", data);
            fclose(file);
            app.write_message("Project saved at " + app.ProjectPath);
        end

        function open_project(app)
            app.write_message("Opening new project");
            pause(0.01);

            fullpath = app.safe_getfile('*.txt', ...
                app.default_data_folder(), ...
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
            app.init_parameters_table(true);
            app.init_quantities_table(true);
            app.NofcompSpinner.Value = app.number_components;

            app.TableFittedParameters.Data(:,2) = s.fitted_parameters_value;
            app.TableFittedParameters.Data(:,3) = s.fitted_parameters_lower_bound;
            app.TableFittedParameters.Data(:,4) = s.fitted_parameters_upper_bound;


            app.TableParameters.Data.(5) = cellstr(s.select_a);
            app.TableParameters.Data.(5) = categorical(app.TableParameters.Data.(5), {'high', 'low'}, 'Ordinal', true);

            app.NofpointsEditField.Value = s.number_points;
            app.PointSpaceDropDown.Value = s.point_space;
            loaded_error_type = string(s.error_type);
            if (loaded_error_type == "Diagonal") || (loaded_error_type == "Diagonal (continuous)")
                loaded_error_type = "Diagonal (logH, continuous)";
            elseif (loaded_error_type == "Diagonal (sampled)")
                loaded_error_type = "Diagonal (logH, sampled)";
            end
            if any(strcmp(app.ErrorDropDown.Items, char(loaded_error_type)))
                app.ErrorDropDown.Value = char(loaded_error_type);
            else
                app.ErrorDropDown.Value = app.ErrorDropDown.Items{1};
            end
            app.InputDatasetPath.Value = s.input_path;
            app.HorizontalaxisfieldDropDown.Value = s.horizontal_axis;
            app.VerticalaxisfieldDropDown.Value = s.vertical_axis;
            app.CurvetypeDropDown.Value = s.curve_type;
            app.DescriptionTextArea.Value = s.description;

            app.ShowgridCheckBoxHdMdH.Value = s.fitting_show_grid_checkbox;
            app.PlotcomponentsCheckBoxHdMdH.Value = s.fitting_plot_components_checkbox;
            if isfield(s, 'fitting_show_hcr_checkbox')
                show_hcr_value = s.fitting_show_hcr_checkbox;
            else
                show_hcr_value = 1;
            end
            app.ShowhcrCheckBoxM.Value = show_hcr_value;
            app.ShowhcrCheckBoxdMdH.Value = show_hcr_value;
            app.ShowhcrCheckBoxHdMdH.Value = show_hcr_value;

            if isfield(s, 'params')
                if isfield(s.params, 'Ms'); app.Ms_JA.Value = str2double(string(s.params.Ms)); end
                if isfield(s.params, 'a'); app.a_JA.Value = str2double(string(s.params.a)); end
                if isfield(s.params, 'alpha'); app.alpha_JA.Value = str2double(string(s.params.alpha)); end
                if isfield(s.params, 'c'); app.c_JA.Value = str2double(string(s.params.c)); end
                if isfield(s.params, 'k'); app.k_JA.Value = str2double(string(s.params.k)); end
            end

            if isfield(s, 'hysteretic_starting_point'); app.StartingpointDropDown_4.Value = s.hysteretic_starting_point; end
            if isfield(s, 'hysteretic_fitting_region'); app.FittingregionDropDown.Value = s.hysteretic_fitting_region; end
            if isfield(s, 'hysteretic_stop_criterion'); app.StopcriterionDropDown_5.Value = s.hysteretic_stop_criterion; end
            if isfield(s, 'hysteretic_repetitions')
                app.RepetitionsEditField_3.Value = max(1, round(s.hysteretic_repetitions));
            end
            if isfield(s, 'hysteretic_rel_tolerance')
                app.RelativetoleranceEditField.Value = max(0, s.hysteretic_rel_tolerance);
            end
            if isfield(s, 'hysteretic_max_repetitions')
                app.MaximumrepetitionsEditField.Value = max(1, round(s.hysteretic_max_repetitions));
            end
            app.sync_hysteretic_fitting_ui();

            if (app.calculate_and_plot() == -1)
                return
            end
            app.calculate_plot_and_refresh_hysteretic();

            [~, name, ext] = fileparts(app.ProjectPath);
            app.write_message(name + ext + " was opened successfully");
        end

        function save_project(app)
            start_folder = app.default_data_folder();
            fullpath = app.safe_putfile('*.txt', start_folder, ...
                "Save project", "project.txt");

            if fullpath == ""
                return;
            end

            app.ProjectPath = fullpath;
            app.save();
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
