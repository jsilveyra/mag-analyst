classdef AnhystereticUtils
%ANHYSTERETICUTILS Static helpers for the Anhysteretic-fitting tab.
%   Static methods taking `app` as the first argument, called from thin
%   delegator methods on the app class (same pattern as the other tab
%   *Utils classes).

    methods (Static)
        function plot(app)
            AnhystereticUtils.plot_M(app);
            AnhystereticUtils.plot_dMdH(app);
            AnhystereticUtils.plot_HdMdH(app);

            AnhystereticUtils.init_parameters_table(app, false);
            AnhystereticUtils.init_quantities_table(app, false);

            AnhystereticUtils.sync_fitted_parameter_values_from_components(app);
            AnhystereticUtils.refresh_table_value_display(app);
            % Js [T] (saturation polarization) requires the true volume Ms,
            % not computable from a mass-native fit without a known density
            % (deferred feature, see docs/ideas/mass-density-cross-view.md).
            % Its display slot is repurposed to show the total saturation
            % mass magnetization sigma_S = sum(sigma_S,i) instead -- the
            % paper's own Eq. 13 quantity, and exactly what magnetic_parameters.Ms
            % already holds per-component when M_is_mass_based.
            app.JsTLabel.Text = char(DisplayUnits.get_Js_slot_label(app));
            if app.M_is_mass_based
                app.JsField.Value = sum(app.magnetic_parameters.Ms);
            else
                app.JsField.Value = app.magnetic_parameters.Js;
            end
            app.chiinLabel.Text = char(DisplayUnits.get_chi_total_label(app));
            app.chiinLabel.Tooltip = AnhystereticUtils.effective_field_tooltip();
            app.chiinField.Tooltip = AnhystereticUtils.effective_field_tooltip();
            app.chiinField.Value = app.magnetic_parameters.chi_in_total;


            utils = Utils();

            [HTip, ~] = utils.find_tip(app.data_curve.H, app.data_curve.M);

            % Keep the directly-fit physical parameters in physical-fit mode;
            % only recompute magnetic_parameters from the distribution
            % parameters otherwise (see calculate_parameters for the rationale).
            if ~AnhystereticUtils.use_physical_parameters(app)
                select_a = app.TableParameters.Data{1:app.number_components,5};
                app.magnetic_parameters = MagneticParameters(app.data_curve, app.Hcr, app.mcr, app.Hx, select_a);
            end


            AnhystereticUtils.update_error_display(app);
            AnhystereticUtils.sync_reduce_dof_ui(app);
        end

        function update_error_display(app)
            if ~isobject(app.data_curve) || ~isobject(app.modeled_curve)
                return;
            end

            error_type = string(app.ErrorDropDown.Value);
            try
                error_calculator = make_error_calculator(error_type, app.data_curve.H, app.data_curve.M, app.modeled_curve.H, app.modeled_curve.M);
            catch
                app.write_message("Unknown error type: " + error_type);
                return;
            end

            e = error_calculator.get_error();
            app.ErrorDisplay.Value = e;
        end

        function calculate_parameters(app)
            % Guard: no data yet
            if ~isobject(app.data_curve) || ~isprop(app.data_curve, 'H') || isempty(app.data_curve.H)
                return;
            end

            N = max(2, round(app.NofpointsEditField.Value));

            H = app.data_curve.H(:).';
            M = app.data_curve.M(:).';

            % Work only with positive H for log spacing
            Hpos = H(H > 0);
            if numel(Hpos) < 2
                app.write_message("Not enough positive H points to build modeled curve.");
                return;
            end

            % Robust HTip default + safe tip detection
            HTip = max(Hpos);
            try
                [HTip_tmp, ~] = Utils().find_tip(H, M);
                if ~isempty(HTip_tmp) && isfinite(HTip_tmp) && (HTip_tmp > 0)
                    HTip = HTip_tmp;
                end
            catch
                % keep fallback HTip
            end

            Hstart = Hpos(1);
            if HTip <= Hstart
                HTip = max(Hpos);
            end

            % In physical-fit ("reduce dof" unchecked) mode, app.magnetic_parameters
            % holds the directly-fit Ms/alpha/a and must NOT be rebuilt from the
            % now-stale distribution parameters (Hcr/mcr/Hx). Only rebuild it in
            % the default distribution mode.
            if ~AnhystereticUtils.use_physical_parameters(app)
                select_a = app.TableParameters.Data{1:app.number_components,5};
                app.magnetic_parameters = MagneticParameters(app.data_curve, app.Hcr, app.mcr, app.Hx, select_a);
            end

            point_space = string(app.PointSpaceDropDown.Value);
            if (point_space == "log") || (point_space == "Logarithmically spaced")
                Hhat = logspace(log10(Hstart), log10(HTip), N-1);
            else
                Hhat = linspace(Hstart, HTip, N-1);
            end

            Hhat = [0, Hhat];
            app.modeled_curve = ModeledAnhystereticCurve(Hhat, app.magnetic_parameters);
        end

        function tf = use_physical_parameters(app)
            % True when the tab is currently in "reduce dof" unchecked
            % (physical-fit) mode AND app.magnetic_parameters holds a valid,
            % correctly-sized directly-fit result. If the flag is set but the
            % stored object no longer matches number_components (e.g. the
            % component count changed under us), the flag is cleared and false
            % is returned, reverting cleanly to distribution mode.
            tf = false;
            if ~isprop(app, 'physical_fit_active') || ~logical(app.physical_fit_active)
                return;
            end
            mp = app.magnetic_parameters;
            if isobject(mp) && ~isempty(mp.Ms) && numel(mp.Ms) == app.number_components
                tf = true;
            else
                app.physical_fit_active = false;
            end
        end

        function reduce_dof = reduce_dof_enabled(app)
            % Defensive default: fit with reduced degrees of freedom when the
            % checkbox component is not available.
            reduce_dof = true;
            if isprop(app, 'ReduceDofCheckBox') && ~isempty(app.ReduceDofCheckBox)
                reduce_dof = logical(app.ReduceDofCheckBox.Value);
            end
        end

        function fit_parameters(app)
            if AnhystereticUtils.reduce_dof_enabled(app)
                AnhystereticUtils.fit_parameters_reduced(app);
            else
                AnhystereticUtils.fit_parameters_physical(app);
            end
            MenuUtils.mark_project_dirty(app);
        end

        function fit_parameters_reduced(app)
            N = app.NofpointsEditField.Value;
            AnhystereticUtils.calculate_parameters(app);
            select_a = app.TableParameters.Data{1:app.number_components,5};
            fit_lb = zeros(app.number_components*3 - 1, 1);
            fit_ub = zeros(app.number_components*3 - 1, 1);
            fit_select_fit = cell(app.number_components*3 - 1, 1);
            for i=1:app.number_components
                fit_lb(i) = app.lb(2*i - 1);
                fit_lb(i + app.number_components) = app.lb(2*i);
                fit_ub(i) = app.ub(2*i - 1);
                fit_ub(i + app.number_components) = app.ub(2*i);
                fit_select_fit(i) = app.select_fit(2*i - 1);
                fit_select_fit(i + app.number_components) = app.select_fit(2*i);
            end
            for i=1:(app.number_components-1)
                fit_lb(i + 2*app.number_components) = app.lb(2*app.number_components + i);
                fit_ub(i + 2*app.number_components) = app.ub(2*app.number_components + i);
                fit_select_fit(i + 2*app.number_components) = app.select_fit(2*app.number_components + i);
            end

            app.stop_fit_requested = false;

            % See if this is a plain repeat click (nothing edited since the
            % last fit) to decide whether to accumulate the fit-progress
            % history (see FitProgressUtils.open) and whether the "Fit
            % again" tip below is due.
            conditions.lb = fit_lb;
            conditions.ub = fit_ub;
            conditions.select_fit = fit_select_fit;
            conditions.error_type = string(app.ErrorDropDown.Value);
            conditions.mode = "reduced";
            seed = cat(2, app.Hcr, app.mcr, app.Hx);
            is_rerun = FitProgressUtils.check_and_remember_conditions(app, 'anh', conditions, seed);

            FitProgressUtils.open(app, 'anh', "Anhysteretic fit progress", app.ErrorDropDown.Value, is_rerun);

            app.write_message("Fitting started (mathematical parameters)");
            pause(0.01);
            tic
            try
                output_fcn = @(x, optimValues, state) app.fit_stop_output_fcn(x, optimValues, state);
                [app.Hcr, app.mcr, app.Hx] = fit(app.data_curve, seed, N, select_a, app.ErrorDropDown.Value, fit_lb, fit_ub, fit_select_fit, output_fcn);
                % Prefer the best point FitProgressUtils tracked across every
                % evaluated point during the search over minimize()'s own
                % returned point: guarantees a "Stop fit" mid-search (or any
                % other reason the search's own final iterate might not be
                % its best) never leaves worse parameters than the best the
                % search actually found.
                [best_x, ~, has_best] = FitProgressUtils.get_best(app, 'anh');
                if has_best
                    n = app.number_components;
                    app.Hcr = best_x(1:n);
                    app.mcr = best_x(n+1:2*n);
                    app.Hx = best_x(2*n+1:end);
                end
                FitProgressUtils.remember_fit_result(app, 'anh', cat(2, app.Hcr, app.mcr, app.Hx));
                elapsed = toc;
                FitProgressUtils.record_elapsed_time(app, 'anh', elapsed);
                t = sprintf("%0.2f", elapsed);
                if app.stop_fit_requested
                    app.write_message("Fitting stopped by user after " + t + " s");
                else
                    if isprop(app, 'physical_fit_active')
                        app.physical_fit_active = false;
                    end
                    app.write_message("Fitting finished after " + t + " s");
                    AnhystereticUtils.write_m_lower_bound_messages(app, select_a, fit_lb, fit_select_fit);
                    if isprop(app, 'ReduceDofCheckBox') && ~isempty(app.ReduceDofCheckBox)
                        app.write_message("Tip: uncheck 'reduce dof' and fit again to further refine the physical parameters.");
                    end
                end
            catch e
                t = sprintf("%0.2f", toc);
                app.write_message("Fitting failed after " + t + " s: " + e.message);
            end
        end

        function fit_parameters_physical(app)
            % "reduce dof" UNCHECKED: refine the physical parameters
            % (Ms, alpha, a) directly, seeded from their current values (the
            % result of a prior distribution-mode fit). Ms/alpha/a are left
            % unbounded (an individual component's Ms can be negative), so the
            % seed stays feasible and the error can only improve.
            N = app.NofpointsEditField.Value;
            n = app.number_components;

            mp = app.magnetic_parameters;
            if ~isobject(mp) || isempty(mp.Ms) || numel(mp.Ms) ~= n
                app.write_message("Run a fit with 'reduce dof' checked first to seed the physical parameters.");
                return;
            end

            % Seed straight from the current physical parameters -- do NOT call
            % calculate_parameters here, which (in distribution mode) would
            % rebuild magnetic_parameters from the stale Hcr/mcr/Hx and destroy
            % the seed.
            seed = [mp.Ms(:).', mp.alpha(:).', mp.a(:).'];

            BIG = 1e12;                       % wide finite stand-in for unbounded
            fit_lb = -BIG * ones(3*n, 1);
            fit_ub =  BIG * ones(3*n, 1);
            fit_select_fit = num2cell(true(3*n, 1));

            app.stop_fit_requested = false;

            conditions.lb = fit_lb;
            conditions.ub = fit_ub;
            conditions.select_fit = fit_select_fit;
            conditions.error_type = string(app.ErrorDropDown.Value);
            conditions.mode = "physical";
            is_rerun = FitProgressUtils.check_and_remember_conditions(app, 'anh', conditions, seed);

            FitProgressUtils.open(app, 'anh', "Anhysteretic fit progress", app.ErrorDropDown.Value, is_rerun);

            app.write_message("Fitting started (physical parameters)");
            pause(0.01);
            tic
            try
                output_fcn = @(x, optimValues, state) app.fit_stop_output_fcn(x, optimValues, state);
                [Ms, alpha, a] = fit_physical(app.data_curve, seed, N, app.ErrorDropDown.Value, fit_lb, fit_ub, fit_select_fit, output_fcn);
                % Prefer the best point tracked across the search (same
                % guarantee as the distribution path, incl. after a Stop fit).
                [best_x, ~, has_best] = FitProgressUtils.get_best(app, 'anh');
                if has_best
                    Ms = best_x(1:n);
                    alpha = best_x(n+1:2*n);
                    a = best_x(2*n+1:end);
                end
                physical.Ms = Ms;
                physical.alpha = alpha;
                physical.a = a;
                app.magnetic_parameters = MagneticParameters(app.data_curve, [], [], [], [], physical);
                if isprop(app, 'physical_fit_active')
                    app.physical_fit_active = true;
                end
                FitProgressUtils.remember_fit_result(app, 'anh', [Ms(:).', alpha(:).', a(:).']);
                elapsed = toc;
                FitProgressUtils.record_elapsed_time(app, 'anh', elapsed);
                t = sprintf("%0.2f", elapsed);
                if app.stop_fit_requested
                    app.write_message("Fitting stopped by user after " + t + " s");
                else
                    app.write_message("Fitting finished after " + t + " s");
                end
            catch e
                t = sprintf("%0.2f", toc);
                app.write_message("Fitting failed after " + t + " s: " + e.message);
            end
        end

        function sync_reduce_dof_ui(app)
            % Gray/disable the controls that don't apply in physical-fit mode:
            % the whole Mathematical-parameters (Hcr/mcr/Hx) fit table, and the
            % "Select aᵢ" column of the Physical-parameters table (the a-root
            % choice is only used by the distribution->a conversion). No-op
            % before the checkbox exists (pre-port).
            if ~isprop(app, 'ReduceDofCheckBox') || isempty(app.ReduceDofCheckBox)
                return;
            end
            reduce_dof = logical(app.ReduceDofCheckBox.Value);

            if reduce_dof
                app.TableFittedParameters.Enable = 'on';
            else
                app.TableFittedParameters.Enable = 'off';
            end

            editable = app.TableParameters.ColumnEditable;
            if numel(editable) >= 5
                editable(5) = reduce_dof;
                app.TableParameters.ColumnEditable = editable;
            end
            % Reset the physical table's styles, then gray the frozen column.
            % NOTE: matlab.ui.control.Table (the App Designer / uifigure
            % table, as opposed to the legacy Java uitable) does not support
            % styling the column HEADER: addStyle's targets are only
            % "table"/"row"/"column"/"cell" (all data cells), and ColumnName
            % does not render HTML markup (confirmed -- an earlier attempt at
            % graying the header text via '<html><font color=...>' just
            % displayed the literal tags). So only the data cells in the
            % "Select aᵢ" column are grayed; the header text itself always
            % stays plain.
            AnhystereticUtils.shade_parameters_table(app);
            if ~reduce_dof
                addStyle(app.TableParameters, ...
                    uistyle('BackgroundColor', [0.90 0.90 0.90], 'FontColor', [0.55 0.55 0.55]), ...
                    'column', 5);
            end
        end

        function on_reduce_dof_changed(app)
            % "reduce dof" was just toggled. Unchecking only grays/ungrays
            % controls (fit_parameters_physical is seeded from the CURRENT
            % magnetic_parameters, whatever mode produced them). Re-checking,
            % however, must revert to distribution mode: otherwise
            % use_physical_parameters(app) keeps reporting true (it reads
            % physical_fit_active, not the checkbox) and every downstream
            % calculate_parameters/plot call keeps silently reusing the stale
            % physical-fit result instead of recomputing magnetic_parameters
            % (and the dependent tables/error metric) from the mathematical
            % parameters (Hcr/mcr/Hx), even though the checkbox now says
            % otherwise.
            if AnhystereticUtils.reduce_dof_enabled(app) && isprop(app, 'physical_fit_active')
                app.physical_fit_active = false;
            end
            AnhystereticUtils.sync_reduce_dof_ui(app);
            AnhystereticUtils.calculate_plot_and_refresh_hysteretic_live(app);
        end

        function write_m_lower_bound_messages(app, select_a, fit_lb, fit_select_fit)
            tolerance = 1e-8;
            select_a = string(select_a);

            for i = 1:app.number_components
                m_index = app.number_components + i;
                if m_index > numel(fit_lb) || i > numel(app.mcr)
                    continue;
                end
                if m_index <= numel(fit_select_fit) && ~logical(fit_select_fit{m_index})
                    continue;
                end

                m_lower_bound = fit_lb(m_index);
                if abs(app.mcr(i) - m_lower_bound) > tolerance * max(1, abs(m_lower_bound))
                    continue;
                end

                current_select_a = lower(select_a(i));
                if current_select_a == "low"
                    alternative_select_a = "high";
                elseif current_select_a == "high"
                    alternative_select_a = "low";
                else
                    continue;
                end

                app.write_message("Component " + string(i) + " fitted m" + string(i) + "(Hcr" + string(i) + ") reached its lower bound (" + AnhystereticUtils.format_m_display(app, m_lower_bound) + ") with select a" + string(i) + " = '" + current_select_a + "'. Consider exploring a fit with select a" + string(i) + " = '" + alternative_select_a + "'.");
            end
        end

        function update_components(app)
            app.Hcr = zeros(1, app.number_components);
            app.mcr = zeros(1, app.number_components);
            app.Hx = zeros(1, max(app.number_components - 1, 0));
            offset = (3*app.number_components - 1);
            if offset > 0 && numel(app.fitted_parameter_values) >= offset && numel(app.component_row_types) >= offset
                hcr_index = 1;
                mcr_index = 1;
                hx_index = 1;
                for row = 1:offset
                    value = app.fitted_parameter_values(row);
                    switch app.component_row_types(row)
                        case "Hcr"
                            app.Hcr(hcr_index) = value;
                            hcr_index = hcr_index + 1;
                        case "m"
                            app.mcr(mcr_index) = value;
                            mcr_index = mcr_index + 1;
                        case "Hx"
                            app.Hx(hx_index) = value;
                            hx_index = hx_index + 1;
                    end
                end
            end
            app.select_fit = cell(1, offset);
            for i = 1:offset
                app.select_fit(i) = app.TableFittedParameters.Data(4*offset + i);
            end
        end

        function init_components(app)
            row_count = 3*app.number_components - 1;
            seed_Hcr = 0.01 * (1:app.number_components);
            seed_mcr = 0.521657107787896 * ones(1, app.number_components);
            seed_Hx = 0.015 * (1:max(app.number_components - 1, 0));

            has_seed_curve = false;
            try
                has_seed_curve = ~isempty(app.data_curve) && isobject(app.data_curve) && ...
                    isprop(app.data_curve, 'H') && ~isempty(app.data_curve.H);
            catch
                has_seed_curve = false;
            end

            if has_seed_curve
                try
                    [seed_Hcr, seed_mcr, seed_Hx] = retrieve_anhysteretic_seeds(app.data_curve, app.number_components);
                catch e
                    app.write_message("Seed retrieval failed; using built-in seeds: " + e.message);
                end
            end

            component_values = zeros(row_count, 1);
            lb_col = zeros(row_count, 1);
            ub_col = zeros(row_count, 1);
            row_names = cell(row_count, 1);
            row_types = strings(row_count, 1);
            for i = 1:app.number_components
                s = 'Hcr' + string(char(8320 + i));
                row_names(2*i - 1,:) = {convertStringsToChars(s + ' [A/m]')};
                component_values(2*i-1) = seed_Hcr(i); %legacy: 0.01*i;
                row_types(2*i-1) = "Hcr";
                s = 'm' + string(char(8320 + i)) + ' (' + s + ')';
                row_names(2*i,:) = {convertStringsToChars(s)};
                component_values(2*i) = seed_mcr(i); %legacy: 0.521657107787896;
                row_types(2*i) = "m";
                lb_col(2*i-1) = 0;
                lb_col(2*i) = 0.4496;
                ub_col(2*i-1) = Inf;
                ub_col(2*i) = 1;
            end

            for i = 1:(app.number_components-1)
                row_index = i + 2*app.number_components;
                s = 'Hx' + string(char(8320 + i)) + ' [A/m]';
                row_names(row_index,:) = {convertStringsToChars(s)};
                component_values(row_index) = seed_Hx(i); %legacy: i*0.015;
                row_types(row_index) = "Hx";
                lb_col(row_index) = 0;
                ub_col(row_index) = 1000000;
            end
            app.component_row_types = row_types;
            app.fitted_parameter_values = component_values;
            app.lb = lb_col(:)';
            app.ub = ub_col(:)';
            component_values = num2cell(component_values);
            lb_col_display = arrayfun(@(x) {AnhystereticUtils.format_sigfigs(x)}, lb_col);
            ub_col_display = arrayfun(@(x) {AnhystereticUtils.format_sigfigs(x)}, ub_col);
            app.select_fit = cell(row_count, 1);
            app.select_fit(:) = {true};
            t = table(row_names, component_values, lb_col_display, ub_col_display, app.select_fit);
            app.TableFittedParameters.Data = table2cell(t);
            AnhystereticUtils.refresh_table_value_display(app);
            AnhystereticUtils.shade_fitted_parameters_table(app);

            AnhystereticUtils.init_parameters_table(app, true);
            AnhystereticUtils.init_quantities_table(app, true);
        end

        function init_parameters_table(app, default_values)
            parameters_col = cell(app.number_components, 1);
            for i = 1:app.number_components
                s = string(i);
                parameters_col(i,:) = {convertStringsToChars(s)};
            end

            Ms_col = cell(app.number_components, 1);
            alpha_col = cell(app.number_components, 1);
            a_col = cell(app.number_components, 1);

            select_a_col = cell(app.number_components, 1);
            for i = 1:app.number_components
                select_a_col(i,:) = {'low'};
            end

            if ~default_values
                select_a_col = app.TableParameters.Data{:,5};

                for i = 1:app.number_components
                    Ms_col(i,:) = {AnhystereticUtils.format_scientific(app.magnetic_parameters.Ms(i))};
                    alpha_col(i,:) = {FormatUtils.format_engineering(app.magnetic_parameters.alpha(i))};
                    a_col(i,:) = {AnhystereticUtils.format_sigfigs(app.magnetic_parameters.a(i))};
                end
            end

            t = table(parameters_col, Ms_col, alpha_col, a_col, select_a_col);
            t.(5) = categorical(t.(5), {'high', 'low'}, 'Ordinal', true);

            app.TableParameters.Data = t;
            app.TableParameters.ColumnName = {'Component'; DisplayUnits.get_Ms_label(app); DisplayUnits.get_alpha_label(app); 'aᵢ [A/m]'; 'Select aᵢ'};
            app.TableParameters.Tooltip = AnhystereticUtils.effective_field_tooltip();
            AnhystereticUtils.shade_parameters_table(app);
        end

        function init_quantities_table(app, default_values)
            parameters_col = cell(app.number_components, 1);
            for i = 1:app.number_components
                s = string(i);
                parameters_col(i,:) = {convertStringsToChars(s)};
            end

            dimensionless_alphaMs_col = cell(app.number_components, 1);
            density_product_col = cell(app.number_components, 1);
            Hk_col = cell(app.number_components, 1);
            chi_in_col = cell(app.number_components, 1);

            if ~default_values
                for i = 1:app.number_components
                    dimensionless_alphaMs_col(i,:) = {AnhystereticUtils.format_sigfigs(app.magnetic_parameters.dimensionless_alphaMs(i))};
                    density_product_col(i,:) = {AnhystereticUtils.format_sigfigs(app.magnetic_parameters.density_product(i))};
                    Hk_col(i,:) = {AnhystereticUtils.format_sigfigs(app.magnetic_parameters.Hk(i))};
                    chi_in_col(i,:) = {AnhystereticUtils.format_sigfigs(app.magnetic_parameters.chi_in(i))};
                end
            end

            t = table(parameters_col, dimensionless_alphaMs_col, density_product_col, Hk_col, chi_in_col);
            app.TableQuantities.Data = t;
            app.TableQuantities.ColumnName = {'Component'; DisplayUnits.get_dimensionless_alphaMs_label(app); DisplayUnits.get_density_product_label(app); 'Hkᵢ [A/m]'; DisplayUnits.get_chi_label(app)};
            app.TableQuantities.Tooltip = AnhystereticUtils.effective_field_tooltip();
            AnhystereticUtils.shade_quantities_table(app);
        end

        function msg = effective_field_tooltip()
            % Shared tooltip for the effective/apparent quantities on this
            % tab (Weiss coefficient alpha/rho*alpha and susceptibility
            % chi_in/chi_m,init).
            msg = "Effective/apparent: not corrected for the sample's demagnetizing factor N_d (H here is the externally applied field). See Silveyra et al. 2026 JMMM, Eqs. 3, 6, 11.";
        end

        function refresh_table_value_display(app)
            row_count = size(app.TableFittedParameters.Data, 1);
            if row_count == 0 || isempty(app.component_row_types) || isempty(app.fitted_parameter_values)
                return;
            end
            valid_rows = min([row_count, numel(app.component_row_types), numel(app.fitted_parameter_values)]);
            for row = 1:valid_rows
                app.TableFittedParameters.Data(row, 2) = {AnhystereticUtils.format_value_for_display(app, row, app.fitted_parameter_values(row))};
            end
            bound_rows = min([row_count, numel(app.lb), numel(app.ub)]);
            for row = 1:bound_rows
                app.TableFittedParameters.Data(row, 3) = {AnhystereticUtils.format_sigfigs(app.lb(row))};
                app.TableFittedParameters.Data(row, 4) = {AnhystereticUtils.format_sigfigs(app.ub(row))};
            end
        end

        function sync_fitted_parameter_values_from_components(app)
            row_count = 3*app.number_components - 1;
            if row_count <= 0 || isempty(app.component_row_types)
                return;
            end
            values = zeros(row_count, 1);
            idx = 1;
            for i = 1:app.number_components
                values(idx) = app.Hcr(i);
                values(idx + 1) = app.mcr(i);
                idx = idx + 2;
            end
            for i = 1:(app.number_components - 1)
                values(idx) = app.Hx(i);
                idx = idx + 1;
            end
            app.fitted_parameter_values = values;
        end

        function ret = format_value_for_display(~, ~, value)
            ret = AnhystereticUtils.format_sigfigs(value);
        end

        function ret = format_sigfigs(value)
            ret = char(sprintf('%.6g', value));
        end

        function ret = format_scientific(value)
            ret = char(sprintf('%.5e', value));
        end

        function ret = format_value_for_edit(app, row)
            if row < 1 || row > numel(app.fitted_parameter_values)
                ret = "";
                return;
            end
            ret = char(sprintf("%.16g", app.fitted_parameter_values(row)));
        end

        function ret = format_m_display(app, value)
            ret = char(sprintf("%.4f", value));
        end

        function tf = is_m_row(app, row)
            tf = false;
            if row < 1 || row > numel(app.component_row_types)
                return;
            end
            tf = app.component_row_types(row) == "m";
        end

        function plot_M(app)
            hcr_values = [];
            if app.ShowhcrCheckBoxM.Value == 1
                hcr_values = app.Hcr;
            end
            plotter = Plotter(app.data_curve, app.modeled_curve, hcr_values, app.Colors, 5);
            cla(app.AxesM,'reset');
            plot_components = app.PlotcomponentsCheckBoxM.Value == 1;
            show_grid = app.ShowgridCheckBoxM.Value == 1;
            axis_scale = string(app.AxisScaleDropDownM.Value);
            M_label = DisplayUnits.get_M_label(app);
            if FormatUtils.axis_scale_has_x(axis_scale)
                plotter.plot_M_log(app.AxesM, plot_components, show_grid, M_label);
            else
                plotter.plot_M(app.AxesM, plot_components, show_grid, M_label);
            end
            app.apply_axis_scale(app.AxesM, axis_scale);
        end

        function plot_dMdH(app)
            hcr_values = [];
            if app.ShowhcrCheckBoxdMdH.Value == 1
                hcr_values = app.Hcr;
            end
            plotter = Plotter(app.data_curve, app.modeled_curve, hcr_values, app.Colors, 5);
            cla(app.AxesdMdH,'reset');
            plot_components = app.PlotcomponentsCheckBoxdMdH.Value == 1;
            show_grid = app.ShowgridCheckBoxdMdH.Value == 1;
            axis_scale = string(app.AxisScaleDropDowndMdH.Value);
            dMdH_label = DisplayUnits.get_dMdH_label(app);
            if FormatUtils.axis_scale_has_x(axis_scale)
                plotter.plot_dMdH_log(app.AxesdMdH, plot_components, show_grid, dMdH_label);
            else
                plotter.plot_dMdH(app.AxesdMdH, plot_components, show_grid, dMdH_label);
            end
            app.apply_axis_scale(app.AxesdMdH, axis_scale);
        end

        function plot_HdMdH(app)
            hcr_values = [];
            if app.ShowhcrCheckBoxHdMdH.Value == 1
                hcr_values = app.Hcr;
            end
            plotter = Plotter(app.data_curve, app.modeled_curve, hcr_values, app.Colors, 5);
            cla(app.AxesHdMdH,'reset');
            plot_components = app.PlotcomponentsCheckBoxHdMdH.Value == 1;
            show_grid = app.ShowgridCheckBoxHdMdH.Value == 1;
            axis_scale = string(app.AxisScaleDropDownHdMdH.Value);
            HdMdH_label = DisplayUnits.get_HdMdH_label(app);
            if FormatUtils.axis_scale_has_x(axis_scale)
                plotter.plot_HdMdH_log(app.AxesHdMdH, plot_components, show_grid, HdMdH_label);
            else
                plotter.plot_HdMdH(app.AxesHdMdH, plot_components, show_grid, HdMdH_label);
            end
            app.apply_axis_scale(app.AxesHdMdH, axis_scale);
        end

        function residual_plot_M(app)
            residue_calculator = MagnetizationResidueCalculator(app.data_curve, app.modeled_curve);
            residue = residue_calculator.get_residue();
            log_flag = FormatUtils.axis_scale_has_x(string(app.AxisScaleDropDownM.Value));
            residue_plotter = ResiduePlotter(app.data_curve.H, app.data_curve.M, app.modeled_curve.H, app.modeled_curve.M, residue, log_flag, DisplayUnits.get_M_label(app), 5, [0 0 0], app.Colors(1,:), app.Colors(1,:));
            residue_plotter.plot()
        end

        function residual_plot_dMdH(app)
            residue_calculator = SusceptibilityResidueCalculator(app.data_curve, app.modeled_curve);
            residue = residue_calculator.get_residue();
            log_flag = FormatUtils.axis_scale_has_x(string(app.AxisScaleDropDowndMdH.Value));
            residue_plotter = ResiduePlotter(app.data_curve.H, app.data_curve.dMdH, app.modeled_curve.H, app.modeled_curve.dMdH, residue, log_flag, DisplayUnits.get_dMdH_label(app), 5, [0 0 0], app.Colors(1,:), app.Colors(1,:));
            residue_plotter.plot()
        end

        function residual_plot_HdMdH(app)
            residue_calculator = SemilogDerivativeResidueCalculator(app.data_curve, app.modeled_curve);
            residue = residue_calculator.get_residue();
            log_flag = FormatUtils.axis_scale_has_x(string(app.AxisScaleDropDownHdMdH.Value));
            residue_plotter = ResiduePlotter(app.data_curve.H, app.data_curve.HdMdH, app.modeled_curve.H, app.modeled_curve.HdMdH, residue, log_flag, DisplayUnits.get_HdMdH_label(app), 5, [0 0 0], app.Colors(1,:), app.Colors(1,:));
            residue_plotter.plot()
        end

        function [ms_seed, a_seed, alpha_seed, has_seeds] = get_first_anhysteretic_seeds(app)
            % reads the full-precision source (app.magnetic_parameters) directly,
            % not the TableParameters display text -- that text is a 6-sig-fig rendering,
            % and parsing it back was silently truncating the seeds handed to the
            % Hysteretic and Playground tabs.
            has_seeds = false;
            ms_seed = NaN;
            a_seed = NaN;
            alpha_seed = NaN;

            if isempty(app.TableParameters.Data) || height(app.TableParameters.Data) < 1
                return;
            end
            if isempty(app.magnetic_parameters) || isempty(app.magnetic_parameters.Ms) ...
                    || isempty(app.magnetic_parameters.alpha) || isempty(app.magnetic_parameters.a)
                return;
            end

            ms_num = app.magnetic_parameters.Ms(1);
            alpha_num = app.magnetic_parameters.alpha(1);
            a_num = app.magnetic_parameters.a(1);
            if ~isfinite(ms_num) || ~isfinite(alpha_num) || ~isfinite(a_num)
                return;
            end

            ms_seed = ms_num;
            a_seed = a_num;
            alpha_seed = alpha_num;
            has_seeds = true;
        end

        function ret = subscript_to_number(app, str)
            chars = char(str);
            for i = 1:length(chars)
                if chars(i) >= 8272
                    chars(i) = 48 + chars(i) - '₀';
                end
            end
            ret = string(chars);
        end

        function set_colors_and_plot(app, colors)
            app.Colors = colors;
            MenuUtils.mark_project_dirty(app);
            AnhystereticUtils.apply_component_color_styles(app);
            if ~isobject(app.data_curve) || ~isprop(app.data_curve, 'H') || isempty(app.data_curve.H)
                app.write_message("Colors updated. Import data before recalculating.");
                return;
            end
            AnhystereticUtils.update_components(app);
            AnhystereticUtils.calculate_parameters(app);
            AnhystereticUtils.plot(app);
        end

        function apply_component_color_styles(app)
            AnhystereticUtils.shade_fitted_parameters_table(app);
            AnhystereticUtils.shade_parameters_table(app);
            AnhystereticUtils.shade_quantities_table(app);
        end

        function light_color = lighten_color(color)
            % Blend the component/curve color 90% of the way toward white so
            % the table cell background reads as a faint tint of the curve
            % color, not the fully-saturated line color itself.
            light_color = min(max(color + (1 - color) * 0.9, 0), 1);
        end

        function shade_fitted_parameters_table(app)
            removeStyle(app.TableFittedParameters);
            if isempty(app.Colors) || isempty(app.component_row_types) || app.number_components <= 1
                return;
            end
            for row = 1:numel(app.component_row_types)
                if app.component_row_types(row) == "Hx"
                    % Hx_i sits between components i and i+1; shade it as
                    % component (i+1), the next/right-hand component.
                    component = row - 2*app.number_components + 1;
                else
                    component = ceil(row/2);
                end
                color_row = component + 1;
                if color_row < 1 || color_row > size(app.Colors, 1)
                    continue;
                end
                addStyle(app.TableFittedParameters, ...
                    uistyle('BackgroundColor', AnhystereticUtils.lighten_color(app.Colors(color_row,:))), ...
                    'row', row);
            end
        end

        function shade_parameters_table(app)
            removeStyle(app.TableParameters);
            for col = 1:5
                addStyle(app.TableParameters, uistyle('HorizontalAlignment','right'), "column", col);
            end
            AnhystereticUtils.shade_component_table_rows(app, app.TableParameters);
        end

        function shade_quantities_table(app)
            removeStyle(app.TableQuantities);
            for col = 1:5
                addStyle(app.TableQuantities, uistyle('HorizontalAlignment','right'), "column", col);
            end
            AnhystereticUtils.shade_component_table_rows(app, app.TableQuantities);
        end

        function shade_component_table_rows(app, table)
            if isempty(app.Colors) || app.number_components <= 1
                return;
            end
            for i = 1:app.number_components
                color_row = i + 1;
                if color_row > size(app.Colors, 1)
                    continue;
                end
                addStyle(table, ...
                    uistyle('BackgroundColor', AnhystereticUtils.lighten_color(app.Colors(color_row,:))), ...
                    'row', i);
            end
        end

        function a = calculate_and_plot(app)
            path = app.InputDatasetPath.Value;
            if isfile(path)
                app.import_data(path);
                AnhystereticUtils.update_components(app);
                AnhystereticUtils.calculate_parameters(app);
                app.plot_input();
                a = 0;
            else
                FileDialogUtils.write_dataset_not_found_message(app, path);
                a = -1;
            end
        end

        function calculate_plot_and_refresh_hysteretic_live(app)
            % silent variant of app.calculate_plot_and_refresh_hysteretic for
            % live field/table-edit triggers - skips the "no dataset imported"
            % message so it doesn't spam the Messages panel while the Anhysteretic
            % tab is used before any data has been imported.
            if ~isobject(app.data_curve) || ~isprop(app.data_curve, 'H') || isempty(app.data_curve.H)
                return;
            end
            app.calculate_plot_and_refresh_hysteretic();
        end
    end
end
