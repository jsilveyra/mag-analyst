classdef InputUtils
%INPUTUTILS Static helpers for the Input-data tab.
%   Static methods taking `app` as the first argument, called from thin
%   delegator methods on the app class (same pattern as the other tab
%   *Utils classes).

    methods (Static)
        function plot_input(app)
            if ~isobject(app.data_curve) || ~isprop(app.data_curve, 'H') || isempty(app.data_curve.H)
                return
            end
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

        function apply_detected_import_settings(app, path)
            %APPLY_DETECTED_IMPORT_SETTINGS Guess H/M axis units (from the
            %   CSV's header row, if any) and curve type (anhysteretic vs.
            %   hysteresis loop, from the shape of the data) for a newly
            %   selected file, and set the Input-tab dropdowns accordingly.
            %   Only overwrites a dropdown when a confident guess was found;
            %   otherwise the current selection is left untouched. Must only
            %   be called at new-file-selection time (browse / path field
            %   edit), never on reprocess (same file, different N points or
            %   curve type), or a manual override would be silently reverted.
            [H_unit_guess, M_unit_guess, curve_type_guess] = InputUtils.detect_import_settings(path);
            if strlength(H_unit_guess) > 0
                app.HorizontalaxisfieldDropDown.Value = char(H_unit_guess);
            end
            if strlength(M_unit_guess) > 0
                app.VerticalaxisfieldDropDown.Value = char(M_unit_guess);
            end
            if strlength(curve_type_guess) > 0
                app.CurvetypeDropDown.Value = char(curve_type_guess);
            end
        end

        function [H_unit, M_unit, curve_type] = detect_import_settings(path)
            H_unit = "";
            M_unit = "";
            curve_type = "";

            try
                fid = fopen(path, 'r');
                if fid == -1
                    return;
                end
                first_line = fgetl(fid);
                fclose(fid);
            catch
                return;
            end

            if ischar(first_line)
                parts = strtrim(strsplit(string(first_line), {',', ';', char(9)}));
                if numel(parts) >= 2 && any(isnan(str2double(parts(1:2))))
                    H_unit = InputUtils.match_unit_label(parts(1), true);
                    M_unit = InputUtils.match_unit_label(parts(2), false);
                end
            end

            try
                T = readtable(path, "VariableNamingRule", "preserve");
                A = table2array(T);
                if size(A, 2) >= 1
                    curve_type = InputUtils.guess_curve_type(A(:,1));
                end
            catch
            end
        end

        function label = match_unit_label(raw_header, is_horizontal)
            label = "";
            normalized = InputUtils.normalize_unit_text(raw_header);
            if strlength(normalized) == 0
                return;
            end
            constants = ParserConstants();
            if is_horizontal
                candidates = [constants.H_AMPERE_PER_METER, constants.H_KILO_AMPERE_PER_METER, ...
                    constants.H_OERSTED, constants.H_KILO_OERSTED, constants.BEXT_TESLA, ...
                    constants.BEXT_GAUSS, constants.BEXT_KILO_GAUSS];
            else
                candidates = [constants.M_AMPERE_PER_METER, constants.M_KILO_AMPERE_PER_METER, ...
                    constants.M_MEGA_AMPERE_PER_METER, constants.M_ELECTROMAGNETIC_UNIT_PER_CUBE_CENTIMETER, ...
                    constants.SIGMA_ELECTROMAGNETIC_UNIT_PER_GRAM, constants.J_TESLA, constants.B_TESLA, ...
                    constants.B_GAUSS, constants.B_KILO_GAUSS];
            end
            for i = 1:numel(candidates)
                candidate_normalized = InputUtils.normalize_unit_text(candidates(i));
                % A candidate like "σ [emu/g=Am^2/kg]" lists two equivalent
                % units (mass-normalized emu, and the SI Am^2/kg form) for
                % the same physical quantity (sigma, mass magnetization) --
                % match a header giving either one on its own, e.g.
                % "sigma [emu/g]" or "sigma [Am^2/kg]".
                candidate_alternatives = InputUtils.expand_unit_alternatives(candidate_normalized);
                if any(normalized == candidate_alternatives)
                    label = candidates(i);
                    return;
                end
            end
        end

        function alternatives = expand_unit_alternatives(normalized)
            alternatives = normalized;
            tok = regexp(normalized, '^(.*)\[(.*)\]$', 'tokens', 'once');
            if isempty(tok)
                return;
            end
            prefix = tok{1};
            unit_parts = strsplit(tok{2}, "=");
            if numel(unit_parts) < 2
                return;
            end
            alternatives = strings(1, numel(unit_parts));
            for k = 1:numel(unit_parts)
                alternatives(k) = prefix + "[" + unit_parts(k) + "]";
            end
        end

        function normalized = normalize_unit_text(raw)
            normalized = lower(strtrim(string(raw)));
            normalized = strrep(normalized, "(", "[");
            normalized = strrep(normalized, ")", "]");
            normalized = regexprep(normalized, "\s+", "");
            % Accept the spelled-out Greek letter name as an alias for the
            % symbol (e.g. a CSV header "sigma [emu/g]" for σ).
            normalized = strrep(normalized, "sigma", string(char(963)));
        end

        function stripped = strip_unit_annotation(normalized)
            stripped = regexprep(normalized, "=[^\]]*", "");
        end

        function curve_type = guess_curve_type(H_col)
            % A hysteresis-loop sweep reverses direction (up then down, or
            % vice versa), so a substantial fraction of consecutive H steps
            % point the "other" way; an anhysteretic sweep is recorded in one
            % direction, so only a small minority of steps (attributable to
            % noise) should point backwards. 5% is a generous noise margin --
            % a real reversal produces roughly a 50/50 split, not a handful
            % of stray steps.
            curve_type = "";
            H = H_col(:);
            H = H(isfinite(H));
            n = numel(H);
            if n < 8
                return;
            end
            range_H = max(H) - min(H);
            if range_H <= 0
                return;
            end
            noise_tol = 0.01 * range_H;
            dH = diff(H);
            step_sign = sign(dH);
            step_sign(abs(dH) < noise_tol) = 0;
            pos = sum(step_sign > 0);
            neg = sum(step_sign < 0);
            total = pos + neg;
            if total == 0
                return;
            end
            minority_fraction = min(pos, neg) / total;
            constants = ParserConstants();
            if minority_fraction > 0.05
                curve_type = constants.HYSTERESIS_LOOP_TYPE;
            else
                curve_type = constants.ANHYSTERETIC_CURVE_TYPE;
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
                FileDialogUtils.write_dataset_not_found_message(app, dataset_path);
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
