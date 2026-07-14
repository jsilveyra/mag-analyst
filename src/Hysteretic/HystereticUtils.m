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
            [H_cycle, M_cycle] = HystereticUtils.build_ja_data_cycle_core( ...
                app.H_raw, app.M_raw, ...
                app.HorizontalaxisfieldDropDown.Value, ...
                app.VerticalaxisfieldDropDown.Value, ...
                app.InputNumberofPointsEditField.Value);
        end

        function [H_left, M_left] = get_hysteretic_left_branch_data(app)
            [~, ~, H_left, M_left] = HystereticUtils.build_ja_data_cycle_core( ...
                app.H_raw, app.M_raw, ...
                app.HorizontalaxisfieldDropDown.Value, ...
                app.VerticalaxisfieldDropDown.Value, ...
                app.InputNumberofPointsEditField.Value);
        end

        function [H_cycle, M_cycle, H_left, M_left] = build_ja_data_cycle_core(H_raw, M_raw, H_unit, M_unit, number_of_points)
            % Pure (app-independent) core shared by build_ja_data_cycle and
            % get_hysteretic_left_branch_data, and callable directly from
            % command-line scripts/demos (which have no live app to read the
            % Input tab's unit dropdowns / number-of-points field from):
            % convert the raw imported columns to base units (A/m), extract a
            % uniformly arc-length-sampled descending (left) branch, then
            % reflect it into a full, point-symmetric cycle. Keeping this one
            % copy means the demo's data cycle is byte-for-byte the app's.
            [H_conv, M_conv] = UnitConvertor().convert_H_M(H_raw, H_unit, M_raw, M_unit);

            n_left = max(2, round(number_of_points));
            [H_left, M_left] = extract_left_branch_uniform_arc(H_conv, M_conv, n_left);
            H_right = -H_left;
            M_right = -M_left;

            H_cycle = [H_left H_right(2:end)];
            M_cycle = [M_left M_right(2:end)];
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
                [Hsim, Msim] = solve_ja_hysteretic_region( ...
                    Htip, Mtip, params, ...
                    app.StartingpointDropDown_4.Value, ...
                    app.FittingregionDropDown.Value, ...
                    app.StopcriterionDropDown_5.Value, ...
                    HystereticUtils.get_hysteretic_repetition_value(app), ...
                    app.RelativetoleranceEditField.Value, ...
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
            max_repetitions = max(1, round(app.MaximumrepetitionsEditField.Value));
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
            app.RelativetoleranceEditFieldLabel.Enable = 'off';
            app.RelativetoleranceEditField.Enable = 'off';
            if isprop(app, 'MaximumrepetitionsEditFieldLabel')
                app.MaximumrepetitionsEditFieldLabel.Enable = 'off';
            end
            if isprop(app, 'MaximumrepetitionsEditField')
                app.MaximumrepetitionsEditField.Enable = 'off';
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
                app.RelativetoleranceEditFieldLabel.Enable = 'off';
                app.RelativetoleranceEditField.Enable = 'off';
                if isprop(app, 'MaximumrepetitionsEditFieldLabel')
                    app.MaximumrepetitionsEditFieldLabel.Enable = 'off';
                end
                if isprop(app, 'MaximumrepetitionsEditField')
                    app.MaximumrepetitionsEditField.Enable = 'off';
                end
                return;
            end

            app.StopcriterionDropDown_5Label.Enable = 'on';
            app.StopcriterionDropDown_5.Enable = 'on';

            if is_fixed
                app.RepetitionsEditField_3Label.Enable = 'on';
                app.RepetitionsEditField_3.Enable = 'on';
                app.RelativetoleranceEditFieldLabel.Enable = 'off';
                app.RelativetoleranceEditField.Enable = 'off';
                if isprop(app, 'MaximumrepetitionsEditFieldLabel')
                    app.MaximumrepetitionsEditFieldLabel.Enable = 'off';
                end
                if isprop(app, 'MaximumrepetitionsEditField')
                    app.MaximumrepetitionsEditField.Enable = 'off';
                end
            else
                app.RepetitionsEditField_3Label.Enable = 'off';
                app.RepetitionsEditField_3.Enable = 'off';
                app.RelativetoleranceEditFieldLabel.Enable = 'on';
                app.RelativetoleranceEditField.Enable = 'on';
                if isprop(app, 'MaximumrepetitionsEditFieldLabel')
                    app.MaximumrepetitionsEditFieldLabel.Enable = 'on';
                end
                if isprop(app, 'MaximumrepetitionsEditField')
                    app.MaximumrepetitionsEditField.Enable = 'on';
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
                residue_plotter = ResiduePlotter(H_left, M_left, H_model_left, M_model_left, residue, false, DisplayUnits.get_M_label(app), 5, [0 0 0], [1 0 0], [1 0 0], true);
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
            app.ErrorDisplay_2.Value = [];

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
                    app.ErrorDisplay_2.Value = J;
                end
            catch
                app.ErrorDisplay_2.Value = [];
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

        function plot_hysteretic_branch_residuals(app, H_left, M_left, H_right, M_right, H_model_left, M_model_left, H_model_right, M_model_right, residue_left, residue_right)
            left_color = [0 0.4470 0.7410];
            right_color = [0.8500 0.3250 0.0980];
            M_label = DisplayUnits.get_M_label(app);

            figure('Name', "Residual plot: " + M_label, 'NumberTitle', 'off');
            tiledlayout(4, 1);

            ax1 = nexttile([3 1]);
            box(ax1, 'on');
            hold(ax1, 'on');
            plot(ax1, H_left, M_left, '.', 'MarkerSize', 5, 'Color', left_color, 'DisplayName', 'Measured left branch');
            plot(ax1, H_model_left, M_model_left, '-', 'LineWidth', 1.2, 'Color', left_color, 'DisplayName', 'Modeled left branch');
            plot(ax1, H_right, M_right, '.', 'MarkerSize', 5, 'Color', right_color, 'DisplayName', 'Measured right branch');
            plot(ax1, H_model_right, M_model_right, '-', 'LineWidth', 1.2, 'Color', right_color, 'DisplayName', 'Modeled right branch');
            xline(ax1, 0, 'k-', 'LineWidth', 1.2, 'HandleVisibility', 'off');
            yline(ax1, 0, 'k-', 'LineWidth', 1.2, 'HandleVisibility', 'off');
            HystereticUtils.apply_residual_detailed_grid(ax1);
            xlabel(ax1, 'H (A/m)');
            ylabel(ax1, M_label);
            legend(ax1, 'Location', 'best');
            hold(ax1, 'off');

            ax2 = nexttile;
            box(ax2, 'on');
            hold(ax2, 'on');
            xline(ax2, 0, 'k-', 'LineWidth', 1.2, 'HandleVisibility', 'off');
            yline(ax2, 0, 'k-', 'LineWidth', 1.2, 'HandleVisibility', 'off');
            HystereticUtils.apply_residual_detailed_grid(ax2);
            stem(ax2, H_left, residue_left, '.', 'MarkerSize', 5, 'Color', left_color, 'DisplayName', 'Left branch residual');
            stem(ax2, H_right, residue_right, '.', 'MarkerSize', 5, 'Color', right_color, 'DisplayName', 'Right branch residual');
            xlabel(ax2, 'H (A/m)');
            ylabel(ax2, 'Residual');
            set(ax2, 'yticklabels', []);
            hold(ax2, 'off');
        end

        function apply_residual_detailed_grid(ax)
            grid(ax, 'on');
            ax.XMinorGrid = 'on';
            ax.YMinorGrid = 'on';
            if isprop(ax, 'XMinorTick')
                ax.XMinorTick = 'on';
            end
            if isprop(ax, 'YMinorTick')
                ax.YMinorTick = 'on';
            end
        end

        function plot_hysteretic_tab_data(app)
            ax = app.AxesM_2;
            cla(ax, 'reset');
            hold(ax, 'on');
            H_label = DisplayUnits.get_H_label(app);
            M_label = DisplayUnits.get_M_label(app);
            DisplayUnits.apply_ja_labels(app, app.Ms_JALabel, app.alpha_JALabel);
            app.MtipLabel.Text = char(DisplayUnits.get_Mtip_label(app));

            has_raw_data = ~isempty(app.H_raw) && ~isempty(app.M_raw);
            if has_raw_data && app.is_last_import_anhysteretic()
                plot(ax, app.data_curve.H, app.data_curve.M, '.', 'Color', [0 0 0], 'LineWidth', 1.0, 'MarkerSize', 7, 'DisplayName', 'Measured');
                app.write_message("Warning: Anhysteretic magnetization data detected. The curve can be used for Jiles–Atherton (rate‑independent) model testing, but parameter fitting is not possible.");
            elseif has_raw_data
                [H_plot, M_plot] = HystereticUtils.build_ja_data_cycle(app);
                plot(ax, H_plot, M_plot, '.', 'Color', [0 0 0], 'LineWidth', 1.0, 'MarkerSize', 7, 'DisplayName', 'Measured');
                app.write_message("Hysteresis loop data in " + M_label + " vs " + H_label + " successfully retrieved.");
            else
                app.write_message("Warning: No hysteresis loop data is currently available.");
            end

            [Hsim, Msim, has_model] = HystereticUtils.get_hysteretic_modeled_region(app);
            if has_model
                plot(ax, Hsim, Msim, 'r-', 'LineWidth', 1.2, 'DisplayName', 'JA simulated');
            elseif ~isempty(app.k_JA.Value) && isfinite(app.k_JA.Value) && app.k_JA.Value < 0
                app.write_message("Warning: The magnetization path cannot be computed with the current unphysical k<0 parameter.");
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

            % k == 0 is the physical zero-pinning limit (M collapses onto the
            % anhysteretic curve, handled directly in solve_ja_monotonic) --
            % only genuinely unphysical k < 0 is rejected here.
            if Ms <= 0 || a <= 0 || k < 0 || c < 0 || c > 1
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
                (strlength(string(app.CurvetypeDropDown.Value)) > 0 && string(app.CurvetypeDropDown.Value) ~= parser_constants.ANHYSTERETIC_CURVE_TYPE);

            if has_seeds && is_hysteretic_context
                ms_num = ms_seed;
                a_num = a_seed;
                alpha_num = alpha_seed;

                app.Ms_JA.Value = ms_num;
                app.a_JA.Value = a_num;
                app.alpha_JA.Value = alpha_num;

                ms_display = AnhystereticUtils.format_sigfigs(ms_num);
                a_display = AnhystereticUtils.format_sigfigs(a_num);
                alpha_display = AnhystereticUtils.format_sigfigs(alpha_num);

                k_value = NaN;
                if has_curve_data && isfinite(ms_num) && isfinite(a_num) && isfinite(alpha_num) && a_num ~= 0
                    try
                        [H_cycle, M_cycle] = HystereticUtils.build_ja_data_cycle(app);
                        n_left = max(2, round(app.InputNumberofPointsEditField.Value));
                        [H_left, M_left] = extract_left_branch_uniform_arc(H_cycle, M_cycle, n_left);
                        k_value = HystereticUtils.estimate_k_from_coercive_point(app, H_left, M_left, ms_num, a_num, alpha_num, c_seed);
                    catch ME
                        k_value = NaN;
                        app.write_message("k-seed debug: " + string(ME.message));
                    end
                end

                Ms_seed_label = DisplayUnits.get_Ms_scalar_label(app);
                alpha_seed_label = DisplayUnits.get_alpha_scalar_label(app);
                DisplayUnits.apply_ja_labels(app, app.Ms_JALabel, app.alpha_JALabel);
                if isfinite(k_value)
                    k_display = HystereticUtils.format_k_seed_display(app, k_value);
                    app.k_JA.Value = k_value;
                    app.c_JA.Value = c_seed;
                    app.write_message("Jiles–Atherton seeds retrieved: " + Ms_seed_label + "=" + ms_display + ", a=" + a_display + " [A/m], " + alpha_seed_label + "=" + alpha_display + ", c=" + FormatUtils.format_short(c_seed) + ", k=" + k_display + " [A/m].");
                else
                    app.k_JA.Value = [];
                    app.c_JA.Value = c_seed;
                    app.write_message("Jiles–Atherton seeds retrieved: " + Ms_seed_label + "=" + ms_display + ", a=" + a_display + " [A/m], " + alpha_seed_label + "=" + alpha_display + ", c=" + FormatUtils.format_short(c_seed) + ", k=not available.");
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
            % Delegates to the same ErrorCalculator hierarchy the
            % Anhysteretic fit uses (src/Common), with use_log_h=false since
            % the hysteretic branch spans negative H and a log transform
            % does not apply. See src/Common/ErrorCalculator.m for why.
            %
            % When the fitting region is the entire loop, Hleft/Mleft (data)
            % and Hhat/Mhat (model) are full, closed loops. The three
            % single-valued-projection metrics -- sampled Diagonal, Vertical,
            % Horizontal -- interpolate one curve onto the other's abscissa
            % (interp1 of M(H) or H(M)); those projections are undefined on a
            % closed loop (two H per M, two M per H) and silently return
            % garbage. So for those three we first reduce both curves to their
            % descending (left) branch via descending_branch(), which is
            % single-valued and -- for the point-symmetric JA major loop --
            % fully determines the fit (this is also the branch the blind
            % method of Conde Garrido et al., IEEE TMAG 2025, compares).
            % The continuous Diagonal metric uses distance2curve, which is
            % loop-safe, so it is left on the full loop unchanged. (For the
            % "Left branch only" fitting region every input is already a
            % single descending branch, so descending_branch() is a no-op.)
            BIG = 1e6;
            J = BIG;
            ok = false;
            try
                switch error_type
                    case "Diagonal (H, continuous)"
                        calculator = DiagonalErrorCalculator(Hleft, Mleft, Hhat, Mhat, false, true);
                    case "Diagonal (H, sampled)"
                        [Hd, Md] = HystereticUtils.descending_branch(Hleft, Mleft);
                        [Hhd, Mhd] = HystereticUtils.descending_branch(Hhat, Mhat);
                        calculator = DiagonalErrorCalculator(Hd, Md, Hhd, Mhd, false, false);
                    case "Vertical"
                        [Hd, Md] = HystereticUtils.descending_branch(Hleft, Mleft);
                        [Hhd, Mhd] = HystereticUtils.descending_branch(Hhat, Mhat);
                        calculator = VerticalErrorCalculator(Hd, Md, Hhd, Mhd, false);
                    case "Horizontal"
                        [Hd, Md] = HystereticUtils.descending_branch(Hleft, Mleft);
                        [Hhd, Mhd] = HystereticUtils.descending_branch(Hhat, Mhat);
                        calculator = HorizontalErrorCalculator(Hd, Md, Hhd, Mhd, false);
                    otherwise
                        return;
                end

                if numel(calculator.X) < 2 || numel(calculator.Xhat) < 2
                    return;
                end

                J = calculator.get_error();
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

        function [Hd, Md] = descending_branch(H, M)
            % Descending (upper/left) branch of a loop or branch: the portion
            % from the starting corner (+Htip) down to the minimum-H point.
            % For an already-single descending branch (min-H at the end, as in
            % "Left branch only" mode) this returns the whole curve unchanged;
            % for a full closed loop it returns just the first, descending half.
            H = H(:);
            M = M(:);
            valid = isfinite(H) & isfinite(M);
            H = H(valid);
            M = M(valid);
            if numel(H) < 2
                Hd = H;
                Md = M;
                return;
            end
            [~, imin] = min(H);
            if imin < 2
                % min-H at the very start (degenerate); no descending
                % sub-branch to isolate, so use the whole curve.
                imin = numel(H);
            end
            Hd = H(1:imin);
            Md = M(1:imin);
        end

        function [v, ok] = read_numeric_field(~, field_handle)
            v = field_handle.Value;
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
                'fit_Ms', logical(app.CheckBox.Value), ...
                'fita', logical(app.CheckBox_2.Value), ...
                'fitalpha', logical(app.CheckBox_3.Value), ...
                'fitc', logical(app.CheckBox_4.Value), ...
                'k_dependent', logical(app.kConstrainedCheckBox_2.Value), ...
                'fitk', logical(app.FitkCheckBox.Value) && ~logical(app.kConstrainedCheckBox_2.Value));

            [params_seed, has_params] = HystereticUtils.get_ja_params_from_tab(app);
            if ~has_params && mask.k_dependent
                [ms_val, ok_Ms] = HystereticUtils.read_numeric_field(app, app.Ms_JA);
                [a_val, ok_A] = HystereticUtils.read_numeric_field(app, app.a_JA);
                [alpha_val, ok_alpha] = HystereticUtils.read_numeric_field(app, app.alpha_JA);
                [c_val, ok_C] = HystereticUtils.read_numeric_field(app, app.c_JA);
                if ok_Ms && ok_A && ok_alpha && ok_C && a_val ~= 0
                    params_seed = struct('Ms', ms_val, 'a', a_val, 'alpha', alpha_val, 'c', c_val, 'k', 1);
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
            [Hleft, Mleft] = extract_left_branch_uniform_arc(H_conv, M_conv, n_left);
            fitting_region = string(app.FittingregionDropDown.Value);
            start_mode = string(app.StartingpointDropDown_4.Value);
            stop_criterion = string(app.StopcriterionDropDown_5.Value);
            repetitions = HystereticUtils.get_hysteretic_repetition_value(app);
            rel_tolerance = app.RelativetoleranceEditField.Value;
            max_repetitions = HystereticUtils.get_hysteretic_max_repetitions_value(app);
            opts = odeset('RelTol', 1e-7, 'AbsTol', 1e-6);
            if fitting_region == "Left branch only"
                HfitData = Hleft;
                MfitData = Mleft;
            else
                HfitData = H_cycle;
                MfitData = M_cycle;
            end

            [ms_lb, ok1] = JAFitUtils.read_bound_field_value(app.MsLower_JA);
            [ms_ub, ok2] = JAFitUtils.read_bound_field_value(app.MsUpper_JA);
            [a_lb, ok3] = JAFitUtils.read_bound_field_value(app.aLower_JA);
            [a_ub, ok4] = JAFitUtils.read_bound_field_value(app.aUpper_JA);
            [alpha_lb, ok5] = JAFitUtils.read_bound_field_value(app.alphaLower_JA);
            [alpha_ub, ok6] = JAFitUtils.read_bound_field_value(app.alphaUpper_JA);
            [c_lb, ok7] = JAFitUtils.read_bound_field_value(app.cLower_JA);
            [c_ub, ok8] = JAFitUtils.read_bound_field_value(app.cUpper_JA);
            [k_lb, ok9] = JAFitUtils.read_bound_field_value(app.kLower_JA);
            [k_ub, ok10] = JAFitUtils.read_bound_field_value(app.kUpper_JA);

            if ~(ok1 && ok2 && ok3 && ok4 && ok5 && ok6 && ok7 && ok8 && ok9 && ok10)
                app.write_message("JA fit skipped: invalid bounds.");
                return;
            end

            bounds = struct( ...
                'Ms', JAFitUtils.make_bound_pair(ms_lb, ms_ub), ...
                'a', JAFitUtils.make_bound_pair(a_lb, a_ub), ...
                'alpha', JAFitUtils.make_bound_pair(alpha_lb, alpha_ub), ...
                'c', JAFitUtils.make_bound_pair(c_lb, c_ub), ...
                'k', JAFitUtils.make_bound_pair(k_lb, k_ub));

            [lb, ub] = JAFitUtils.pack_bounds(bounds, mask);
            if any(lb > ub)
                app.write_message("JA fit skipped: lower bound is greater than upper bound.");
                return;
            end

             error_type = string(app.ErrortominimizeDropDown_2.Value);

             app.stop_fit_requested = false;

             % See if this is a plain repeat click (nothing edited since the
             % last fit) to decide whether to accumulate the fit-progress
             % history (see FitProgressUtils.open) and whether the "Fit
             % again" tip below is due.
             conditions.mask = mask;
             conditions.bounds = bounds;
             conditions.error_type = error_type;
             conditions.fitting_region = fitting_region;
             conditions.start_mode = start_mode;
             conditions.stop_criterion = stop_criterion;
             conditions.repetitions = repetitions;
             conditions.rel_tolerance = rel_tolerance;
             conditions.max_repetitions = max_repetitions;
             is_rerun = FitProgressUtils.check_and_remember_conditions(app, 'hyst', conditions, params_seed);

             FitProgressUtils.open(app, 'hyst', "Hysteretic (JA) fit progress", error_type, is_rerun);

             fit_timer = tic;
            try
                model_fn = @(p) solve_ja_hysteretic_region( ...
                    Htip, Mtip, p, start_mode, fitting_region, stop_criterion, ...
                    repetitions, rel_tolerance, max_repetitions, opts);

                output_fcn = @(x, optimValues, state) app.fit_stop_output_fcn(x, optimValues, state);
                estimate_k_fn = @(p) HystereticUtils.estimate_k_from_coercive_point(app, Hleft, Mleft, p.Ms, p.a, p.alpha, p.c);
                fit_result = JAFitter.fit( ...
                    params_seed, mask, bounds, HfitData, MfitData, Htip, Mtip, error_type, ...
                    estimate_k_fn, ...
                    model_fn, ...
                    @(err_type, hL, mL, hHat, mHat) HystereticUtils.compute_ja_left_branch_error_core(app, err_type, hL, mL, hHat, mHat), ...
                    output_fcn);

                if ~fit_result.ok
                    error(char(fit_result.error_message));
                end

                % Prefer the best point FitProgressUtils tracked across every
                % evaluated point during the search over JAFitter.fit's own
                % returned point -- see the matching comment in
                % AnhystereticUtils.fit_parameters.
                [best_x, best_val, has_best] = FitProgressUtils.get_best(app, 'hyst');
                if has_best
                    [~, map] = JAFitUtils.pack_params(params_seed, mask);
                    fit_result.params_opt = JAFitUtils.unpack_params(best_x, map, params_seed, mask, estimate_k_fn);
                    fit_result.Jopt = best_val;
                end

                params_opt = fit_result.params_opt;
                app.Ms_JA.Value = params_opt.Ms;
                app.a_JA.Value = params_opt.a;
                app.alpha_JA.Value = params_opt.alpha;
                app.c_JA.Value = params_opt.c;
                app.k_JA.Value = params_opt.k;

                app.plot_hysteretic_tab_data();
                app.ErrorDisplay_2.Value = fit_result.Jopt;

                FitProgressUtils.remember_fit_result(app, 'hyst', params_opt);
                t = toc(fit_timer);
                FitProgressUtils.record_elapsed_time(app, 'hyst', t);
                if app.stop_fit_requested
                    app.write_message("Fitting stopped by user after " + FormatUtils.format_short(t) + " s");
                else
                    app.write_message("Fitting finished after " + FormatUtils.format_short(t) + " s");
                end
            catch ME
                t = toc(fit_timer);
                FitProgressUtils.record_elapsed_time(app, 'hyst', t);
                app.write_message("Fitting failed after " + FormatUtils.format_short(t) + " s: " + string(ME.message));
            end
        end

        function k_est = estimate_k_from_coercive_point(app, Hleft, Mleft, Ms, a, alpha, c)
            Hleft = Hleft(:);
            Mleft = Mleft(:);

            valid = isfinite(Hleft) & isfinite(Mleft);
            Hleft = Hleft(valid);
            Mleft = Mleft(valid);

            if numel(Hleft) < 3 || numel(Mleft) < 3
                error('Insufficient left-branch points to estimate k.');
            end

            [Mleft, idx_sort] = sort(Mleft, 'ascend');
            Hleft = Hleft(idx_sort);

            Hc = -interp1(Mleft, Hleft, 0, 'linear', 'extrap');

            poly_order = 3;
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
            p_ord = min(poly_order, numel(Mseg) - 1);

            M0 = mean(Mseg);
            Mscl = max(abs(Mseg - M0));
            if Mscl == 0
                error('Degenerate magnetization window near coercive point.');
            end

            x = (Mseg - M0) / Mscl;
            y = Hseg;

            p = polyfit(x, y, p_ord);
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
