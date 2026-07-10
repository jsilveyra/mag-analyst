classdef InputUtils
%INPUTUTILS Static helpers for the Input-data tab.
%   Extracted from app_exported.m, mirroring the AnhystereticUtils/
%   HystereticUtils/PlaygroundUtils pattern: static methods taking `app` as
%   the first argument, called from thin delegator methods on the app class.

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
            if app.axis_scale_has_x(axis_scale)
                plotter.plot_raw_log(app.AxesProcessedInputData, app.data_curve.H, app.data_curve.M, 'H [A/m]', 'M [A/m]', 'Processed input data');
                plotter.plot_raw_log(app.AxesRawInputData, app.H_raw, app.M_raw, app.HorizontalaxisfieldDropDown.Value, app.VerticalaxisfieldDropDown.Value, 'Raw input data');
            else
                plotter.plot_raw(app.AxesProcessedInputData, app.data_curve.H, app.data_curve.M, 'H [A/m]', 'M [A/m]', 'Processed input data');
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
            [H, M, app.H_raw, app.M_raw] = Parser(path, H_unit, M_unit, curve_type, number_of_points).import();

            app.data_curve = DataAnhystereticCurve(H, M);
            app.refresh_playground_data_curve();
            app.maybe_refresh_minor_loop_defaults();   % MOD: update Htip_i defaults from the newly imported data tip
            app.maybe_refresh_degaussing_defaults();   % MOD: update Degaussing amplitude defaults from the newly imported data tip
            app.sync_degaussing_ui();                  % MOD: refresh Degaussing start-point display from the new data
            app.maybe_refresh_harmonics_defaults();    % MOD: update harmonic amplitude defaults from the newly imported data tip
            app.sync_harmonics_ui();                   % MOD: refresh harmonic start-point display from the new data
            app.maybe_refresh_ms_lower_bound_default(); % MOD: update the Hysteretic tab's Ms lower bound default from the newly imported data tip
            PlaygroundUtils.sync_major_ui(app);
            PlaygroundUtils.clear_simulation(app);
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
            % MOD: shared by CurveDropDownValueChanged and InputApplyPointsButtonPushed
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
