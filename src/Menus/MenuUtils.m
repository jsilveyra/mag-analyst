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
            s.error_type = app.ErrortominimizeDropDown.Value;
            s.input_path = app.InputDatasetPath.Value;
            s.horizontal_axis = app.HorizontalaxisfieldDropDown.Value;
            s.vertical_axis = app.VerticalaxisfieldDropDown.Value;
            s.curve_type = app.CurveDropDown.Value;
            s.description = app.DescriptionTextArea.Value;
            s.data_set_path = app.OutputDatasetPath.Value;

            s.experimental_anhysteretic_magnetization_file_name = app.EditFieldFileNameExperimentalMagnetizationData.Value;
            s.magnetization_file_name = app.EditFieldFileNameModeledAnhystereticMagnetization.Value;
            s.parameters_file_name = app.EditFieldFileNameParameters.Value;
            s.magnetization_plots_file_name = app.EditFieldFileNamePlotMagnetization.Value;
            s.suceptibility_plots_file_name = app.EditFieldFileNamePlotSusceptibility.Value;
            s.magnetization_derivative_file_name = app.EditFieldFileNamePlotSemiLogMagDerivative.Value;
            s.magnetization_residual_file_name = app.EditFieldFileNameResiduesMagnetization.Value;
            s.susceptibility_residual_file_name = app.EditFieldFileNameResiduesSusceptibility.Value;
            s.semi_log_derivative_file_name = app.EditFieldFileNameResiduesSemiLogMagDerivative.Value;

            s.input_axis_scale = app.InputAxisScaleDropDown.Value;
            s.axis_scale_m = app.AxisScaleDropDownM.Value;
            s.axis_scale_dMdH = app.AxisScaleDropDowndMdH.Value;
            s.axis_scale_hdMdH = app.AxisScaleDropDownHdMdH.Value;
            s.fitting_show_grid_checkbox = app.ShowgridCheckBoxHdMdH.Value;
            s.fitting_plot_components_checkbox = app.PlotcomponentsCheckBoxHdMdH.Value;
            s.fitting_show_hcr_checkbox = app.ShowhcrCheckBoxHdMdH.Value;

            s.model_magnetization_checkbox = app.CheckBoxOutputMagnetizationDataFittedAnhystereticMagnetization.Value;
            s.model_magnetization_components_checkbox = app.OutputSeparateComponentsCheckBox.Value;
            s.fitted_parameters_checkbox = app.ExportFittedparametersCheckBox.Value;
            s.model_parameters_checkbox = app.ExportModelparametersCheckBox.Value;
            s.other_quantities_checkbox = app.ExportOtherquantitiesCheckBox.Value;
            s.errors_checkbox = app.ExportErrorsCheckBox.Value;
            s.magnetization_plots_checkbox = app.CheckBoxExportPlotMagnetization.Value;
            s.susceptibility_plots_checkbox = app.CheckBoxExportPlotSusceptibility.Value;
            s.magnetization_derivatives_checkbox = app.CheckBoxExportPlotSemiLogMagDerivative.Value;

            s.experimental_anhysteretic_magnetization_checkbox = app.CheckBoxExperimentalMagnetization.Value;
            s.magnetization_residual_checkbox = app.CheckBoxExportResiduesMagnetization.Value;
            s.susceptibility_residual_checkbox = app.CheckBoxExportResiduesSusceptibility.Value;
            s.semi_log_derivative_residual_checkbox = app.CheckBoxExportResiduesSemiLogMagDerivative.Value;

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

        function select_output_folder(app)
            startFolder = string(app.OutputDatasetPath.Value);
            folder = app.safe_getdir(startFolder, ...
                "Select output folder");

            if folder == ""
                return;
            end

            app.ensure_folder(folder);
            app.OutputDatasetPath.Value = char(folder);
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
            if any(strcmp(app.ErrortominimizeDropDown.Items, char(loaded_error_type)))
                app.ErrortominimizeDropDown.Value = char(loaded_error_type);
            else
                app.ErrortominimizeDropDown.Value = app.ErrortominimizeDropDown.Items{1};
            end
            app.InputDatasetPath.Value = s.input_path;
            app.HorizontalaxisfieldDropDown.Value = s.horizontal_axis;
            app.VerticalaxisfieldDropDown.Value = s.vertical_axis;
            app.CurveDropDown.Value = s.curve_type;
            app.DescriptionTextArea.Value = s.description;

            app.OutputDatasetPath.Value = s.data_set_path;
            app.EditFieldFileNameExperimentalMagnetizationData.Value = s.experimental_anhysteretic_magnetization_file_name;
            app.EditFieldFileNameModeledAnhystereticMagnetization.Value = s.magnetization_file_name;
            app.EditFieldFileNameParameters.Value = s.parameters_file_name;
            app.EditFieldFileNamePlotMagnetization.Value = s.magnetization_plots_file_name;
            app.EditFieldFileNamePlotSusceptibility.Value = s.suceptibility_plots_file_name;
            app.EditFieldFileNamePlotSemiLogMagDerivative.Value = s.magnetization_derivative_file_name;
            app.EditFieldFileNameResiduesMagnetization.Value = s.magnetization_residual_file_name;
            app.EditFieldFileNameResiduesSusceptibility.Value = s.susceptibility_residual_file_name;
            app.EditFieldFileNameResiduesSemiLogMagDerivative.Value = s.semi_log_derivative_file_name;

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
            app.CheckBoxOutputMagnetizationDataFittedAnhystereticMagnetization.Value = s.model_magnetization_checkbox;
            app.OutputSeparateComponentsCheckBox.Value = s.model_magnetization_components_checkbox;
            app.ExportFittedparametersCheckBox.Value = s.fitted_parameters_checkbox;
            app.ExportModelparametersCheckBox.Value = s.model_parameters_checkbox;
            app.ExportOtherquantitiesCheckBox.Value = s.other_quantities_checkbox;
            app.ExportErrorsCheckBox.Value = s.errors_checkbox;
            app.CheckBoxExportPlotMagnetization.Value = s.magnetization_plots_checkbox;
            app.CheckBoxExportPlotSusceptibility.Value = s.susceptibility_plots_checkbox;
            app.CheckBoxExportPlotSemiLogMagDerivative.Value = s.magnetization_derivatives_checkbox;

            app.CheckBoxExperimentalMagnetization.Value = s.experimental_anhysteretic_magnetization_checkbox;
            app.CheckBoxExportResiduesMagnetization.Value = s.magnetization_residual_checkbox;
            app.CheckBoxExportResiduesSusceptibility.Value = s.susceptibility_residual_checkbox;
            app.CheckBoxExportResiduesSemiLogMagDerivative.Value = s.semi_log_derivative_residual_checkbox;

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
                app.ReltoleranceEditField_3.Value = max(0, s.hysteretic_rel_tolerance);
            end
            if isfield(s, 'hysteretic_max_repetitions')
                app.MaxrepetEditField.Value = max(1, round(s.hysteretic_max_repetitions));
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
            startFolder = app.default_data_folder();
            fullpath = app.safe_putfile('*.txt', startFolder, ...
                "Save project", "project.txt");

            if fullpath == ""
                return;
            end

            app.ProjectPath = fullpath;
            app.save();
        end
    end
end
