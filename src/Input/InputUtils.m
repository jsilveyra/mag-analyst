classdef InputUtils
%INPUTUTILS Static helpers for the Input-data tab.
%   Static methods taking `app` as the first argument, called from thin
%   delegator methods on the app class (same pattern as the other tab
%   *Utils classes).

    methods (Static)
        function plot_input(app)
            [HTip, MTip] = Utils().find_tip(app.data_curve.H, app.data_curve.M);
            app.MTipField.Value = MTip;
            app.HTipField.Value = HTip;
            app.Htip.Value = HTip;
            app.Mtip.Value = MTip;
            cla(app.AxesProcessedInputData, 'reset')
            cla(app.AxesRawInputData, 'reset')
            plotter = Plotter(app.data_curve, app.modeled_curve, [], app.Colors, 5);

            axis_scale = string(app.InputAxisScaleDropDown.Value);
            H_label = DisplayUnits.get_H_label(app);
            M_label = DisplayUnits.get_M_label(app);
            if FormatUtils.axis_scale_has_x(axis_scale)
                plotter.plot_raw_log(app.AxesProcessedInputData, app.data_curve.H, app.data_curve.M, H_label, M_label, 'Processed input data');
                plotter.plot_raw_log(app.AxesRawInputData, app.H_raw, app.M_raw, app.HorizontalaxisfieldDropDown.Value, app.VerticalaxisfieldDropDown.Value, 'Raw input data');
            else
                plotter.plot_raw(app.AxesProcessedInputData, app.data_curve.H, app.data_curve.M, H_label, M_label, 'Processed input data');
                plotter.plot_raw(app.AxesRawInputData, app.H_raw, app.M_raw, app.HorizontalaxisfieldDropDown.Value, app.VerticalaxisfieldDropDown.Value, 'Raw input data');
            end

            app.apply_axis_scale(app.AxesProcessedInputData, axis_scale);
            app.apply_axis_scale(app.AxesRawInputData, axis_scale);
        end

        function import_data(app, path)
            number_of_points = app.InputNumberofPointsEditField.Value;
            H_unit = app.HorizontalaxisfieldDropDown.Value;
            M_unit = app.VerticalaxisfieldDropDown.Value;
            curve_type = app.CurvetypeDropDown.Value;
            app.imported_curve_type = string(curve_type);
            app.M_is_mass_based = InputUtils.is_mass_unit(M_unit);

            % Reading + resampling a large CSV can take a few seconds; show an
            % indeterminate progress dialog so the user waits instead of
            % re-triggering the import. onCleanup guarantees it closes even
            % if the parse throws.
            progress_dlg = [];
            try
                progress_dlg = uiprogressdlg(app.MagAnalystUIFigure, ...
                    'Title', 'Importing data', ...
                    'Message', 'Reading and processing the dataset...', ...
                    'Indeterminate', 'on', 'Cancelable', 'off');
                drawnow;
            catch
            end
            close_progress = onCleanup(@() InputUtils.close_progress_dialog(progress_dlg)); %#ok<NASGU>

            [H, M, app.H_raw, app.M_raw] = Parser(path, H_unit, M_unit, curve_type, number_of_points).import();

            app.data_curve = DataAnhystereticCurve(H, M);
            % New data invalidates any prior physical-fit ("reduce dof"
            % unchecked) result; revert to distribution mode so the next
            % replot rebuilds magnetic_parameters from the fitted parameters.
            if isprop(app, 'physical_fit_active')
                app.physical_fit_active = false;
            end
            app.refresh_playground_data_curve();
            app.maybe_refresh_minor_loop_defaults();   % update Htip_i defaults from the newly imported data tip
            app.maybe_refresh_degaussing_defaults();   % update Degaussing amplitude defaults from the newly imported data tip
            app.sync_degaussing_ui();                  % refresh Degaussing start-point display from the new data
            app.maybe_refresh_harmonics_defaults();    % update harmonic amplitude defaults from the newly imported data tip
            app.sync_harmonics_ui();                   % refresh harmonic start-point display from the new data
            app.maybe_refresh_ms_lower_bound_default(); % update the Hysteretic tab's Ms lower bound default from the newly imported data tip
            PlaygroundUtils.sync_major_ui(app);
            PlaygroundUtils.sync_playground_mass_ui(app);
            PlaygroundUtils.clear_simulation(app);
        end

        function close_progress_dialog(progress_dlg)
            if ~isempty(progress_dlg) && isvalid(progress_dlg)
                close(progress_dlg);
            end
        end

        function is_mass = is_mass_unit(M_unit)
            % True when the vertical-axis unit is mass magnetization
            % (sigma, emu/g = Am^2/kg) rather than volume magnetization.
            is_mass = string(M_unit) == "σ [emu/g=Am^2/kg]";
        end

        function is_anhysteretic = is_last_import_anhysteretic(app)
            parser_constants = ParserConstants();
            curve_type = string(app.imported_curve_type);
            if strlength(curve_type) == 0
                curve_type = string(app.CurvetypeDropDown.Value);
            end
            is_anhysteretic = curve_type == parser_constants.ANHYSTERETIC_CURVE_TYPE;
        end

        function reprocess_dataset(app)
            % shared by CurveDropDownValueChanged and InputApplyPointsButtonPushed
            % (now wired to both the N° of points field and, historically, its
            % Apply button) -- previously identical logic duplicated in app_exported.m.
            dataset_path = app.InputDatasetPath.Value;
            if dataset_path == ""
                app.write_message("Select a dataset before applying point count.");
                return
            end

            try
                app.import_data(dataset_path);
                app.update_components();
                app.calculate_parameters();
                app.plot_input();
            catch e
                app.write_message("Reprocessing failed: " + e.message);
            end
        end
    end
end
