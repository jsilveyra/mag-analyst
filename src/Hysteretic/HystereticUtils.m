classdef HystereticUtils
%HYSTERETICUTILS Static helpers for the Hysteretic-fitting tab.
%   Extracted 2026-07-06 from app_exported.m, mirroring the AnhystereticUtils/
%   PlaygroundUtils pattern: static methods taking `app` as the first argument,
%   called from thin delegator methods on the app class.

    methods (Static)
        function ret = format_k_seed_display(~, v)
            if ~isfinite(v)
                ret = "not available";
                return;
            end
            ret = string(sprintf('%.6g', v));
        end

        function [H_cycle, M_cycle] = build_ja_data_cycle(app)
            H_unit = app.HorizontalaxisfieldDropDown.Value;
            M_unit = app.VerticalaxisfieldDropDown.Value;
            [H_conv, M_conv] = UnitConvertor().convert_H_M(app.H_raw, H_unit, app.M_raw, M_unit);

            n_left = max(2, round(app.InputNumberofPointsEditField.Value));
            [H_left, M_left] = app.extract_left_branch_uniform_arc(H_conv, M_conv, n_left);
            H_right = -H_left;
            M_right = -M_left;

            H_cycle = [H_left H_right(2:end)];
            M_cycle = [M_left M_right(2:end)];
        end

        function [H_left, M_left] = get_hysteretic_left_branch_data(app)
            H_unit = app.HorizontalaxisfieldDropDown.Value;
            M_unit = app.VerticalaxisfieldDropDown.Value;
            [H_conv, M_conv] = UnitConvertor().convert_H_M(app.H_raw, H_unit, app.M_raw, M_unit);

            n_left = max(2, round(app.InputNumberofPointsEditField.Value));
            [H_left, M_left] = app.extract_left_branch_uniform_arc(H_conv, M_conv, n_left);
        end

        function [H_model_left, M_model_left, has_model] = get_hysteretic_left_branch_model(app)
            [H_model_left, M_model_left, has_model] = HystereticUtils.get_hysteretic_modeled_region(app);
            if ~has_model
                H_model_left = [];
                M_model_left = [];
            end
        end

        function [H_model, M_model, has_model] = get_hysteretic_modeled_region(app)
            [params, has_params] = HystereticUtils.get_ja_params_from_tab(app);
            [Htip, Mtip, has_tip] = HystereticUtils.get_ja_tip_from_tab_or_data(app);

            has_model = has_params && has_tip;
            H_model = [];
            M_model = [];
            if ~has_model
                return;
            end

            try
                opts = odeset('RelTol', 1e-7, 'AbsTol', 1e-6);
                [Hsim, Msim] = solveJA_hysteretic_region( ...
                    Htip, Mtip, params, ...
                    app.StartingpointDropDown_4.Value, ...
                    app.FittingregionDropDown.Value, ...
                    app.StopcriterionDropDown_5.Value, ...
                    HystereticUtils.get_hysteretic_repetition_value(app), ...
                    app.ReltoleranceEditField_3.Value, ...
                    HystereticUtils.get_hysteretic_max_repetitions_value(app), ...
                    opts);
                if isempty(Hsim) || isempty(Msim)
                    has_model = false;
                    return;
                end

                H_model = Hsim;
                M_model = Msim;
                has_model = numel(H_model) >= 2 && numel(M_model) >= 2;
            catch
                H_model = [];
                M_model = [];
                has_model = false;
            end
        end

        function repetitions = get_hysteretic_repetition_value(app)
            repetitions = max(1, round(app.RepetitionsEditField_3.Value));
        end

        function max_repetitions = get_hysteretic_max_repetitions_value(app)
            max_repetitions = max(1, round(app.MaxrepetEditField.Value));
        end

        function sync_hysteretic_fitting_ui(app)
            is_entire_loop = string(app.FittingregionDropDown.Value) == "Entire loop";

            if is_entire_loop
                app.StopcriterionDropDown_5Label.Enable = 'on';
                app.StopcriterionDropDown_5.Enable = 'on';
            else
                app.StopcriterionDropDown_5Label.Enable = 'off';
                app.StopcriterionDropDown_5.Enable = 'off';
            end

            app.RepetitionsEditField_3Label.Enable = 'off';
            app.RepetitionsEditField_3.Enable = 'off';
            app.ReltoleranceEditField_3Label.Enable = 'off';
            app.ReltoleranceEditField_3.Enable = 'off';
            if isprop(app, 'MaxrepetitionsEditField_3Label')
                app.MaxrepetitionsEditField_3Label.Enable = 'off';
            end
            if isprop(app, 'MaxrepetitionsEditField_3')
                app.MaxrepetEditField.Enable = 'off';
            end

            if is_entire_loop
                HystereticUtils.sync_hysteretic_stop_criterion_ui(app);
            end
        end

        function sync_hysteretic_stop_criterion_ui(app)
            is_entire_loop = string(app.FittingregionDropDown.Value) == "Entire loop";
            is_fixed = string(app.StopcriterionDropDown_5.Value) == "Fixed repetitions";

            if ~is_entire_loop
                app.StopcriterionDropDown_5Label.Enable = 'off';
                app.StopcriterionDropDown_5.Enable = 'off';
                app.RepetitionsEditField_3Label.Enable = 'off';
                app.RepetitionsEditField_3.Enable = 'off';
                app.ReltoleranceEditField_3Label.Enable = 'off';
                app.ReltoleranceEditField_3.Enable = 'off';
                if isprop(app, 'MaxrepetitionsEditField_3Label')
                    app.MaxrepetitionsEditField_3Label.Enable = 'off';
                end
                if isprop(app, 'MaxrepetitionsEditField_3')
                    app.MaxrepetEditField.Enable = 'off';
                end
                return;
            end

            app.StopcriterionDropDown_5Label.Enable = 'on';
            app.StopcriterionDropDown_5.Enable = 'on';

            if is_fixed
                app.RepetitionsEditField_3Label.Enable = 'on';
                app.RepetitionsEditField_3.Enable = 'on';
                app.ReltoleranceEditField_3Label.Enable = 'off';
                app.ReltoleranceEditField_3.Enable = 'off';
                if isprop(app, 'MaxrepetitionsEditField_3Label')
                    app.MaxrepetitionsEditField_3Label.Enable = 'off';
                end
                if isprop(app, 'MaxrepetitionsEditField_3')
                    app.MaxrepetEditField.Enable = 'off';
                end
            else
                app.RepetitionsEditField_3Label.Enable = 'off';
                app.RepetitionsEditField_3.Enable = 'off';
                app.ReltoleranceEditField_3Label.Enable = 'on';
                app.ReltoleranceEditField_3.Enable = 'on';
                if isprop(app, 'MaxrepetitionsEditField_3Label')
                    app.MaxrepetitionsEditField_3Label.Enable = 'on';
                end
                if isprop(app, 'MaxrepetitionsEditField_3')
                    app.MaxrepetEditField.Enable = 'on';
                end
            end
        end

        function plot_hysteretic_residuals(app)
            has_raw_data = ~isempty(app.H_raw) && ~isempty(app.M_raw);
            if ~has_raw_data
                app.write_message("Warning: No hysteresis loop data is currently available.");
                return;
            end
            if app.is_last_import_anhysteretic()
                app.write_message("Warning: Hysteretic residuals require a hysteresis loop dataset.");
                return;
            end

            fitting_region = string(app.FittingregionDropDown.Value);
            if fitting_region == "Left branch only"
                [H_left, M_left] = HystereticUtils.get_hysteretic_left_branch_data(app);
                [H_model_left, M_model_left, has_model] = HystereticUtils.get_hysteretic_modeled_region(app);
                if ~has_model
                    app.write_message("Warning: No hysteretic modeled curve is available.");
                    return;
                end

                residue_calculator = HystereticLeftBranchResidueCalculator(H_left, M_left, H_model_left, M_model_left);
                residue = residue_calculator.get_residue();
                residue_plotter = ResiduePlotter(H_left, M_left, H_model_left, M_model_left, residue, false, "M [A/m]", 5, [0 0 0], [1 0 0]);
                residue_plotter.plot()
            else
                [H_left, M_left] = HystereticUtils.get_hysteretic_left_branch_data(app);
                H_right = -H_left;
                M_right = -M_left;

                [H_model, M_model, has_model] = HystereticUtils.get_hysteretic_modeled_region(app);
                if ~has_model
                    app.write_message("Warning: No hysteretic modeled curve is available.");
                    return;
                end

                [H_model_left, M_model_left, H_model_right, M_model_right, has_branches] = HystereticUtils.split_hysteretic_model_branches(app, H_model, M_model);
                if ~has_branches
                    app.write_message("Warning: The hysteretic modeled curve cannot be separated into branches.");
                    return;
                end

                residue_calculator_left = HystereticLeftBranchResidueCalculator(H_left, M_left, H_model_left, M_model_left);
                residue_calculator_right = HystereticLeftBranchResidueCalculator(H_right, M_right, H_model_right, M_model_right);
                residue_left = residue_calculator_left.get_residue();
                residue_right = residue_calculator_right.get_residue();
                HystereticUtils.plot_hysteretic_branch_residuals(app, H_left, M_left, H_right, M_right, H_model_left, M_model_left, H_model_right, M_model_right, residue_left, residue_right);
            end
        end

        function update_hysteretic_error_display(app)
            app.ErrorDisplay_2.Value = "";

            has_raw_data = ~isempty(app.H_raw) && ~isempty(app.M_raw);
            if ~has_raw_data || app.is_last_import_anhysteretic()
                return;
            end

            try
                fitting_region = string(app.FittingregionDropDown.Value);
                if fitting_region == "Left branch only"
                    [H_data, M_data] = HystereticUtils.get_hysteretic_left_branch_data(app);
                else
                    [H_data, M_data] = HystereticUtils.build_ja_data_cycle(app);
                end

                [H_model, M_model, has_model] = HystereticUtils.get_hysteretic_modeled_region(app);
                if ~has_model
                    return;
                end

                error_type = string(app.ErrortominimizeDropDown_2.Value);
                [J, ok] = HystereticUtils.compute_ja_left_branch_error_core(app, error_type, H_data, M_data, H_model, M_model);
                if ok
                    app.ErrorDisplay_2.Value = app.format_engineering(J);
                end
            catch
                app.ErrorDisplay_2.Value = "";
            end
        end

        function [H_left, M_left, H_right, M_right, has_branches] = split_hysteretic_model_branches(~, H_model, M_model)
            H_model = H_model(:);
            M_model = M_model(:);
            valid = isfinite(H_model) & isfinite(M_model);
            H_model = H_model(valid);
            M_model = M_model(valid);

            has_branches = false;
            H_left = [];
            M_left = [];
            H_right = [];
            M_right = [];

            if numel(H_model) < 4 || numel(M_model) < 4
                return;
            end

            [~, min_index] = min(H_model);
            if min_index <= 1 || min_index >= numel(H_model)
                return;
            end

            H_left = H_model(1:min_index);
            M_left = M_model(1:min_index);
            H_right = H_model(min_index:end);
            M_right = M_model(min_index:end);
            has_branches = numel(H_left) >= 2 && numel(H_right) >= 2;
        end

        function plot_hysteretic_branch_residuals(~, H_left, M_left, H_right, M_right, H_model_left, M_model_left, H_model_right, M_model_right, residue_left, residue_right)
            left_color = [0 0.4470 0.7410];
            right_color = [0.8500 0.3250 0.0980];

            figure('Name', "Residual plot: M [A/m]", 'NumberTitle', 'off');
            tiledlayout(4, 1);

            ax1 = nexttile([3 1]);
            box(ax1, 'on');
            hold(ax1, 'on');
            plot(ax1, H_left, M_left, '.', 'MarkerSize', 5, 'Color', left_color, 'DisplayName', 'Measured left branch');
            plot(ax1, H_model_left, M_model_left, '-', 'LineWidth', 1.2, 'Color', left_color, 'DisplayName', 'Modeled left branch');
            plot(ax1, H_right, M_right, '.', 'MarkerSize', 5, 'Color', right_color, 'DisplayName', 'Measured right branch');
            plot(ax1, H_model_right, M_model_right, '-', 'LineWidth', 1.2, 'Color', right_color, 'DisplayName', 'Modeled right branch');
            xlabel(ax1, 'H (A/m)');
            ylabel(ax1, 'M [A/m]');
            legend(ax1, 'Location', 'best');
            hold(ax1, 'off');

            ax2 = nexttile;
            box(ax2, 'on');
            hold(ax2, 'on');
            yline(ax2, 0, 'k-', 'LineWidth', 0.8, 'HandleVisibility', 'off');
            stem(ax2, H_left, residue_left, '.', 'MarkerSize', 5, 'Color', left_color, 'DisplayName', 'Left branch residual');
            stem(ax2, H_right, residue_right, '.', 'MarkerSize', 5, 'Color', right_color, 'DisplayName', 'Right branch residual');
            xlabel(ax2, 'H (A/m)');
            ylabel(ax2, 'Residual');
            set(ax2, 'yticklabels', []);
            legend(ax2, 'Location', 'best');
            hold(ax2, 'off');
        end

        function plot_hysteretic_tab_data(app)
            ax = app.AxesM_2;
            cla(ax, 'reset');
            hold(ax, 'on');
            H_label = "H [A/m]";
            M_label = "M [A/m]";

            has_raw_data = ~isempty(app.H_raw) && ~isempty(app.M_raw);
            if has_raw_data && app.is_last_import_anhysteretic()
                plot(ax, app.data_curve.H, app.data_curve.M, '.', 'Color', [0 0 0], 'LineWidth', 1.0, 'MarkerSize', 7, 'DisplayName', 'Measured');
                app.write_message("Warning: Anhysteretic magnetization data detected. The curve can be used for Jiles–Atherton (rate‑independent) model testing, but parameter fitting is not possible.");
            elseif has_raw_data
                [H_plot, M_plot] = HystereticUtils.build_ja_data_cycle(app);
                plot(ax, H_plot, M_plot, '.', 'Color', [0 0 0], 'LineWidth', 1.0, 'MarkerSize', 7, 'DisplayName', 'Measured');
                app.write_message("Hysteresis loop data in M (A/m) vs H (A/m) successfully retrieved.");
            else
                app.write_message("Warning: No hysteresis loop data is currently available.");
            end

            [Hsim, Msim, has_model] = HystereticUtils.get_hysteretic_modeled_region(app);
            if has_model
                plot(ax, Hsim, Msim, 'r-', 'LineWidth', 1.2, 'DisplayName', 'JA simulated');
            end
            xline(ax, 0, 'k-', 'LineWidth', 1.2);
            yline(ax, 0, 'k-', 'LineWidth', 1.2);
            hx0 = xline(ax, 0, 'k-', 'LineWidth', 1.2);
            hy0 = yline(ax, 0, 'k-', 'LineWidth', 1.2);
            hx0.Annotation.LegendInformation.IconDisplayStyle = 'off';
            hy0.Annotation.LegendInformation.IconDisplayStyle = 'off';
            app.apply_detailed_grid(ax, app.ShowgridCheckBoxM_2.Value == 1);
            xlabel(ax, H_label);
            ylabel(ax, M_label);
            box(ax, 'on');
            ax.LineWidth = 1.2;
            legend(ax, 'off');
            hold(ax, 'off');
        end

        function [params, ok] = get_ja_params_from_tab(app)
            params = struct('Ms', NaN, 'a', NaN, 'alpha', NaN, 'k', NaN, 'c', NaN);
            ok = false;

            Ms = app.Ms_JA.Value;
            a = app.a_JA.Value;
            alpha = app.alpha_JA.Value;
            c = app.c_JA.Value;
            k = app.k_JA.Value;

            if isempty(Ms) || isempty(a) || isempty(alpha) || isempty(c) || isempty(k)
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

        function [params, ok] = get_playground_hysteretic_params(app)
            [params, ok] = HystereticUtils.get_ja_params_from_tab(app);
        end

        function [Htip, Mtip, ok] = get_ja_tip_from_tab_or_data(app)
            ok = false;
            Htip = NaN;
            Mtip = NaN;

            Htip_tab = app.Htip.Value;
            Mtip_tab = app.Mtip.Value;
            if ~isempty(Htip_tab) && ~isempty(Mtip_tab) && isfinite(Htip_tab) && isfinite(Mtip_tab)
                Htip = Htip_tab;
                Mtip = Mtip_tab;
                ok = true;
                return;
            end

            try
                if ~isempty(app.data_curve) && ~isempty(app.data_curve.H) && ~isempty(app.data_curve.M)
                    [Htip, Mtip] = Utils().find_tip(app.data_curve.H, app.data_curve.M);
                    ok = isfinite(Htip) && isfinite(Mtip);
                end
            catch
                ok = false;
            end
        end

        function maybe_refresh_ms_lower_bound_default(app)
            if app.hysteretic_ms_lower_bound_user_edited
                return;
            end
            [~, Mtip, ok] = HystereticUtils.get_ja_tip_from_tab_or_data(app);
            if ok
                app.MsLower_JA.Value = Mtip;
            end
        end

        function retrieve_ja_seeds(app)
            [ms_seed, a_seed, alpha_seed, has_seeds] = app.get_first_anhysteretic_seeds();
            c_seed = 1/3;
            parser_constants = ParserConstants();

            has_curve_data = ~isempty(app.data_curve) && ~isempty(app.data_curve.H) && ~isempty(app.data_curve.M);
            is_hysteretic_context = ~app.is_last_import_anhysteretic() || ...
                (strlength(string(app.CurveDropDown.Value)) > 0 && string(app.CurveDropDown.Value) ~= parser_constants.ANHYSTERETIC_CURVE_TYPE);

            if has_seeds && is_hysteretic_context
                ms_num = str2double(replace(ms_seed, ",", ""));
                a_num = str2double(replace(a_seed, ",", ""));
                alpha_num = str2double(replace(alpha_seed, ",", ""));

                app.Ms_JA.Value = ms_num;
                app.a_JA.Value = a_num;
                app.alpha_JA.Value = alpha_num;

                k_value = NaN;
                if has_curve_data && isfinite(ms_num) && isfinite(a_num) && isfinite(alpha_num) && a_num ~= 0
                    try
                        [H_cycle, M_cycle] = HystereticUtils.build_ja_data_cycle(app);
                        n_left = max(2, round(app.InputNumberofPointsEditField.Value));
                        [H_left, M_left] = app.extract_left_branch_uniform_arc(H_cycle, M_cycle, n_left);
                        k_value = HystereticUtils.estimateK_fromCoercivePoint(app, H_left, M_left, ms_num, a_num, alpha_num, c_seed);
                    catch ME
                        k_value = NaN;
                        app.write_message("k-seed debug: " + string(ME.message));
                    end
                end

                if isfinite(k_value)
                    k_display = HystereticUtils.format_k_seed_display(app, k_value);
                    app.k_JA.Value = k_value;
                    app.c_JA.Value = c_seed;
                    app.write_message("Jiles–Atherton seeds retrieved: Ms=" + ms_seed + " [A/m], a=" + a_seed + " [A/m], α=" + alpha_seed + ", c=" + app.format_short(c_seed) + ", k=" + k_display + " [A/m].");
                else
                    app.k_JA.Value = [];
                    app.c_JA.Value = c_seed;
                    app.write_message("Jiles–Atherton seeds retrieved: Ms=" + ms_seed + " [A/m], a=" + a_seed + " [A/m], α=" + alpha_seed + ", c=" + app.format_short(c_seed) + ", k=not available.");
                end
            else
                app.Ms_JA.Value = [];
                app.a_JA.Value = [];
                app.alpha_JA.Value = [];
                app.k_JA.Value = [];
                app.c_JA.Value = c_seed;
                app.write_message("Warning: No anhysteretic magnetization modelling has been performed.");
                app.write_message("Jiles–Atherton seeds for Ms, a, α, and k were not initialized; the coupling parameter c was set to 1/3.");
            end
            drawnow;
        end

        function [J, ok] = compute_ja_left_branch_error_core(~, error_type, Hleft, Mleft, Hhat, Mhat)
            BIG = 1e6;
            J = BIG;
            ok = false;
            try
                Hleft = Hleft(:);
                Mleft = Mleft(:);
                Hhat = Hhat(:);
                Mhat = Mhat(:);

                valid_data = isfinite(Hleft) & isfinite(Mleft);
                valid_model = isfinite(Hhat) & isfinite(Mhat);
                Hleft = Hleft(valid_data);
                Mleft = Mleft(valid_data);
                Hhat = Hhat(valid_model);
                Mhat = Mhat(valid_model);
                if numel(Hleft) < 2 || numel(Hhat) < 2
                    return;
                end

                if error_type == "Diagonal (H, continuous)"
                    Sx = (max(Hleft) - min(Hleft)) / 2; % Legacy (needs a Matlab extra Toolbox) Sx = range(Hleft) / 2;
                    Sy = (max(Mleft) - min(Mleft)) / 2; % Legacy (needs a Matlab extra Toolbox) Sy = range(Mleft) / 2;
                    if Sx <= 0 || ~isfinite(Sx), Sx = 1; end
                    if Sy <= 0 || ~isfinite(Sy), Sy = 1; end
                    curv = [Hhat / Sx, Mhat / Sy];
                    data = [Hleft / Sx, Mleft / Sy];
                    [~, d] = distance2curve(curv, data, 'linear');
                    J = sqrt(mean(d.^2));
                elseif error_type == "Vertical"
                    [Hhat_s, idxH] = sort(Hhat, 'ascend');
                    Mhat_s = Mhat(idxH);
                    [Hhat_u, idxHu] = unique(Hhat_s, 'stable');
                    Mhat_u = Mhat_s(idxHu);
                    Minterp = interp1(Hhat_u, Mhat_u, Hleft, 'linear', 'extrap');
                    J = sqrt(mean((Mleft - Minterp).^2));
                elseif error_type == "Horizontal"
                    [Mhat_s, idxM] = sort(Mhat, 'ascend');
                    Hhat_s = Hhat(idxM);
                    [Mhat_u, idxMu] = unique(Mhat_s, 'stable');
                    Hhat_u = Hhat_s(idxMu);
                    Hinterp = interp1(Mhat_u, Hhat_u, Mleft, 'linear', 'extrap');
                    J = sqrt(mean((Hleft - Hinterp).^2));
                else
                    return;
                end

                if ~isfinite(J)
                    J = BIG;
                    return;
                end
                ok = true;
            catch
                J = BIG;
                ok = false;
            end
        end

        function [v, ok] = read_numeric_field(~, fieldHandle)
            v = fieldHandle.Value;
            if isempty(v)
                v = NaN;
                ok = false;
            else
                ok = isfinite(v);
            end
        end

        function sync_k_fit_mode_ui(app)
            if app.kConstrainedCheckBox_2.Value
                app.FitkCheckBox.Value = false;
                app.FitkCheckBox.Enable = 'off';
            else
                app.FitkCheckBox.Value = true;
                app.FitkCheckBox.Enable = 'on';
            end
        end

        function fit_ja_parameters(app)
            mask = struct( ...
                'fitMs', logical(app.CheckBox.Value), ...
                'fita', logical(app.CheckBox_2.Value), ...
                'fitalpha', logical(app.CheckBox_3.Value), ...
                'fitc', logical(app.CheckBox_4.Value), ...
                'kDependent', logical(app.kConstrainedCheckBox_2.Value), ...
                'fitk', logical(app.FitkCheckBox.Value) && ~logical(app.kConstrainedCheckBox_2.Value));

            [params_seed, has_params] = HystereticUtils.get_ja_params_from_tab(app);
            if ~has_params && mask.kDependent
                [msVal, okMs] = HystereticUtils.read_numeric_field(app, app.Ms_JA);
                [aVal, okA] = HystereticUtils.read_numeric_field(app, app.a_JA);
                [alphaVal, okAlpha] = HystereticUtils.read_numeric_field(app, app.alpha_JA);
                [cVal, okC] = HystereticUtils.read_numeric_field(app, app.c_JA);
                if okMs && okA && okAlpha && okC && aVal ~= 0
                    params_seed = struct('Ms', msVal, 'a', aVal, 'alpha', alphaVal, 'c', cVal, 'k', 1);
                    has_params = true;
                end
            end

            [Htip, Mtip, has_tip] = HystereticUtils.get_ja_tip_from_tab_or_data(app);
            has_fit_data = false;
            H_cycle = [];
            M_cycle = [];
            try
                [H_cycle, M_cycle] = HystereticUtils.build_ja_data_cycle(app);
                has_fit_data = ~isempty(H_cycle) && ~isempty(M_cycle) && numel(H_cycle) >= 2 && numel(M_cycle) >= 2;
            catch
                has_fit_data = false;
            end

            if ~has_tip && has_fit_data
                try
                    [Htip, Mtip] = Utils().find_tip(H_cycle, M_cycle);
                    has_tip = isfinite(Htip) && isfinite(Mtip);
                catch
                    has_tip = false;
                end
            end

            if ~has_params || ~has_tip || ~has_fit_data
                app.write_message("JA fit skipped: missing parameters, tip, or input data.");
                return;
            end

            [H_conv, M_conv] = deal(H_cycle, M_cycle);
            n_left = max(2, round(app.InputNumberofPointsEditField.Value));
            [Hleft, Mleft] = app.extract_left_branch_uniform_arc(H_conv, M_conv, n_left);
            fitting_region = string(app.FittingregionDropDown.Value);
            start_mode = string(app.StartingpointDropDown_4.Value);
            stop_criterion = string(app.StopcriterionDropDown_5.Value);
            repetitions = HystereticUtils.get_hysteretic_repetition_value(app);
            rel_tolerance = app.ReltoleranceEditField_3.Value;
            max_repetitions = HystereticUtils.get_hysteretic_max_repetitions_value(app);
            opts = odeset('RelTol', 1e-7, 'AbsTol', 1e-6);
            if fitting_region == "Left branch only"
                HfitData = Hleft;
                MfitData = Mleft;
            else
                HfitData = H_cycle;
                MfitData = M_cycle;
            end

            [msLB, ok1] = JAFitUtils.readBoundFieldValue(app.MsLower_JA);
            [msUB, ok2] = JAFitUtils.readBoundFieldValue(app.MsUpper_JA);
            [aLB, ok3] = JAFitUtils.readBoundFieldValue(app.aLower_JA);
            [aUB, ok4] = JAFitUtils.readBoundFieldValue(app.aUpper_JA);
            [alphaLB, ok5] = JAFitUtils.readBoundFieldValue(app.alphaLower_JA);
            [alphaUB, ok6] = JAFitUtils.readBoundFieldValue(app.alphaUpper_JA);
            [cLB, ok7] = JAFitUtils.readBoundFieldValue(app.cLower_JA);
            [cUB, ok8] = JAFitUtils.readBoundFieldValue(app.cUpper_JA);
            [kLB, ok9] = JAFitUtils.readBoundFieldValue(app.kLower_JA);
            [kUB, ok10] = JAFitUtils.readBoundFieldValue(app.kUpper_JA);

            if ~(ok1 && ok2 && ok3 && ok4 && ok5 && ok6 && ok7 && ok8 && ok9 && ok10)
                app.write_message("JA fit skipped: invalid bounds.");
                return;
            end

            bounds = struct( ...
                'Ms', JAFitUtils.makeBoundPair(msLB, msUB), ...
                'a', JAFitUtils.makeBoundPair(aLB, aUB), ...
                'alpha', JAFitUtils.makeBoundPair(alphaLB, alphaUB), ...
                'c', JAFitUtils.makeBoundPair(cLB, cUB), ...
                'k', JAFitUtils.makeBoundPair(kLB, kUB));

            [lb, ub] = JAFitUtils.packBounds(bounds, mask);
            if any(lb > ub)
                app.write_message("JA fit skipped: lower bound is greater than upper bound.");
                return;
            end

             error_type = string(app.ErrortominimizeDropDown_2.Value);

             app.stop_fit_requested = false;
             fit_timer = tic;
            try
                modelFn = @(p) solveJA_hysteretic_region( ...
                    Htip, Mtip, p, start_mode, fitting_region, stop_criterion, ...
                    repetitions, rel_tolerance, max_repetitions, opts);

                outputFcn = @(x, optimValues, state) app.fit_stop_output_fcn(x, optimValues, state);
                fit_result = JAFitter.fit( ...
                    params_seed, mask, bounds, HfitData, MfitData, Htip, Mtip, error_type, ...
                    @(p) HystereticUtils.estimateK_fromCoercivePoint(app, Hleft, Mleft, p.Ms, p.a, p.alpha, p.c), ...
                    modelFn, ...
                    @(errType, hL, mL, hHat, mHat) HystereticUtils.compute_ja_left_branch_error_core(app, errType, hL, mL, hHat, mHat), ...
                    outputFcn);

                if ~fit_result.ok
                    error(char(fit_result.errorMessage));
                end

                params_opt = fit_result.params_opt;
                app.Ms_JA.Value = params_opt.Ms;
                app.a_JA.Value = params_opt.a;
                app.alpha_JA.Value = params_opt.alpha;
                app.c_JA.Value = params_opt.c;
                app.k_JA.Value = params_opt.k;

                app.plot_hysteretic_tab_data();
                app.ErrorDisplay_2.Value = app.format_engineering(fit_result.Jopt);

                t = toc(fit_timer);
                if app.stop_fit_requested
                    app.write_message("Fitting stopped by user after " + app.format_short(t) + " s");
                else
                    app.write_message("Fitting finished after " + app.format_short(t) + " s");
                end
            catch ME
                t = toc(fit_timer);
                app.write_message("Fitting failed after " + app.format_short(t) + " s: " + string(ME.message));
            end
        end

        function k_est = estimateK_fromCoercivePoint(app, Hleft, Mleft, Ms, a, alpha, c)
            Hleft = Hleft(:);
            Mleft = Mleft(:);

            valid = isfinite(Hleft) & isfinite(Mleft);
            Hleft = Hleft(valid);
            Mleft = Mleft(valid);

            if numel(Hleft) < 3 || numel(Mleft) < 3
                error('Insufficient left-branch points to estimate k.');
            end

            [Mleft, idxSort] = sort(Mleft, 'ascend');
            Hleft = Hleft(idxSort);

            Hc = -interp1(Mleft, Hleft, 0, 'linear', 'extrap');

            polyOrder = 3;
            W = 21;

            [~, i0] = min(abs(Mleft));
            N = numel(Mleft);
            half = floor(W/2);
            i1 = max(1, i0 - half);
            i2 = min(N, i0 + half);

            if (i2 - i1 + 1) < W
                if i1 == 1
                    i2 = min(N, i1 + W - 1);
                elseif i2 == N
                    i1 = max(1, i2 - W + 1);
                end
            end

            Mseg = Mleft(i1:i2);
            Hseg = Hleft(i1:i2);
            pOrd = min(polyOrder, numel(Mseg) - 1);

            M0 = mean(Mseg);
            Mscl = max(abs(Mseg - M0));
            if Mscl == 0
                error('Degenerate magnetization window near coercive point.');
            end

            x = (Mseg - M0) / Mscl;
            y = Hseg;

            p = polyfit(x, y, pOrd);
            dp = polyder(p);
            chi_inv_c = polyval(dp, (0 - M0)/Mscl) / Mscl;
            if ~isfinite(chi_inv_c)
                error('chi_inv_c is not finite.');
            end

            h = -Hc / a;
            Lh = Langevin(h, 0);
            dLdh = Langevin(h, 1);
            if ~isfinite(Lh) || ~isfinite(dLdh)
                error('Langevin terms are not finite.');
            end

            num = Ms * Lh;
            den = c * (Ms/a) * dLdh - 1/(chi_inv_c + alpha);
            if ~isfinite(den) || abs(den) < eps
                error("Invalid denominator in k estimation. Hc=" + string(Hc) + ", chi_inv_c=" + string(chi_inv_c) + ", alpha=" + string(alpha));
            end
            k_est = num / den;
            if ~isfinite(k_est)
                error("k_est is not finite. num=" + string(num) + ", den=" + string(den));
            end
        end
    end
end
