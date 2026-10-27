classdef AnhystereticUtils
%ANHYSTERETICUTILS Static helpers for the Anhysteretic-fitting tab.
%   Static methods taking `app` as the first argument, called from thin
%   delegator methods on the app class (same pattern as the other tab
%   *Utils classes).

    properties (Constant)
        % Plot/table color of the linear term (component 0); the Langevin
        % components keep app.Colors (row 1 = total, row i+1 = component i).
        LINEAR_COLOR = [0.45 0.45 0.45]
    end

    methods (Static)
        % ---------------------------------------------------------------
        % Linear term (component 0, M0 = chi0*H) and the physical-table
        % Fit columns (added 2026-10-03). The linear term is the FIRST row
        % of the mathematical-parameters table (row type "chi0"); its value
        % lives in app.fitted_parameter_values like every other row, and is
        % the one row still editable when 'Constrained by n data points' is
        % unchecked.
        % ---------------------------------------------------------------
        function tf = linear_term_enabled(app)
            tf = isprop(app, 'LinearTermCheckBox') && ~isempty(app.LinearTermCheckBox) ...
                && logical(app.LinearTermCheckBox.Value);
        end

        function rows = rows_of_type(app, type)
            rows = [];
            if ~isempty(app.component_row_types)
                rows = find(string(app.component_row_types(:)).' == type);
            end
        end

        function chi0 = chi0_value(app)
            % Current linear-term value (0 when the term is off).
            chi0 = 0;
            r = AnhystereticUtils.rows_of_type(app, "chi0");
            if AnhystereticUtils.linear_term_enabled(app) && ~isempty(r) && r(1) <= numel(app.fitted_parameter_values)
                chi0 = app.fitted_parameter_values(r(1));
            end
        end

        function chi0 = chi0_seed(data_curve)
            % Slope of the top 20 % of the field range (>= 0): an upper
            % estimate of chi0, since the approach to saturation still adds
            % slope there.
            chi0 = 0;
            H = data_curve.H(:);
            M = data_curve.M(:);
            k = H >= 0.8 * max(H);
            if nnz(k) >= 2
                p = polyfit(H(k), M(k), 1);
                if isfinite(p(1))
                    chi0 = max(p(1), 0);
                end
            end
        end

        function data = seed_curve(app)
            % The curve the component seeds are retrieved from: the data
            % minus the linear term when it is on.
            data = app.data_curve;
            if AnhystereticUtils.linear_term_enabled(app)
                chi0 = AnhystereticUtils.chi0_seed(app.data_curve);
                data = DataAnhystereticCurve(app.data_curve.H, app.data_curve.M - chi0 * app.data_curve.H);
            end
        end

        function [lb, ub, sf, linear, i0] = with_linear(app, lb, ub, sf)
            % Prepend the chi0 row's bounds and Fit flag to the reduced fit
            % vectors (3n-1 layout) when the linear term is on.
            i0 = AnhystereticUtils.rows_of_type(app, "chi0");
            linear = AnhystereticUtils.linear_term_enabled(app) && ~isempty(i0);
            if linear
                lb = [app.lb(i0(1)); lb(:)];
                ub = [app.ub(i0(1)); ub(:)];
                sf = [app.select_fit(i0(1)); sf(:)];
            end
        end

        function on_linear_term_changed(app)
            % "Linear term" checkbox toggled: insert or remove the chi0 row
            % (first row of the mathematical-parameters table) in place,
            % keeping every other parameter, then recompute and replot.
            on = AnhystereticUtils.linear_term_enabled(app);
            i0 = AnhystereticUtils.rows_of_type(app, "chi0");
            if on && isempty(i0)
                chi0 = 0;
                if isobject(app.data_curve) && isprop(app.data_curve, 'H') && ~isempty(app.data_curve.H)
                    chi0 = AnhystereticUtils.chi0_seed(app.data_curve);
                end
                app.component_row_types = ["chi0"; string(app.component_row_types(:))];
                app.fitted_parameter_values = [chi0; app.fitted_parameter_values(:)];
                app.lb = [0, app.lb(:).'];
                app.ub = [Inf, app.ub(:).'];
                app.select_fit = [{true}, reshape(app.select_fit, 1, [])];
                app.TableFittedParameters.Data = [{char(DisplayUnits.get_chi0_label(app)), '', '', '', true}; app.TableFittedParameters.Data];
            elseif ~on && ~isempty(i0)
                keep = true(1, numel(app.component_row_types));
                keep(i0) = false;
                app.component_row_types = app.component_row_types(keep);
                app.fitted_parameter_values = app.fitted_parameter_values(keep);
                app.lb = app.lb(keep);
                app.ub = app.ub(keep);
                app.select_fit = app.select_fit(keep);
                app.TableFittedParameters.Data = app.TableFittedParameters.Data(keep, :);
            end
            AnhystereticUtils.refresh_table_value_display(app);
            AnhystereticUtils.sync_reduce_dof_ui(app);
            % plot() rewrites the equation too, but only once data is loaded.
            app.LWModel_eq.Text = DisplayUnits.get_lw_model_eq(app);
            MenuUtils.mark_project_dirty(app);
            AnhystereticUtils.calculate_plot_and_refresh_hysteretic_live(app);
        end

        function rejected = reject_fitted_table_edit(app, event)
            % With 'Constrained by n data points' unchecked, the mathematical
            % parameters are not used; only the chi0 row stays editable
            % (the table is disabled altogether when the linear term is off).
            rejected = false;
            if AnhystereticUtils.reduce_dof_enabled(app) || isempty(event.Indices)
                return;
            end
            row = event.Indices(1, 1);
            if row <= numel(app.component_row_types) && app.component_row_types(row) == "chi0"
                return;
            end
            rejected = true;
            app.TableFittedParameters.Data(event.Indices(1, 1), event.Indices(1, 2)) = {event.PreviousData};
            app.write_message("Only " + DisplayUnits.get_chi0_label(app) + " is fitted here while 'Constrained by n data points' is unchecked; the mathematical parameters are not used.");
        end

        function flags = physical_fit_flags(app)
            % Fit flags of the physical table, in fit_physical's order
            % [Ms(1..n), alpha(1..n), a(1..n)] (all true when unavailable).
            n = app.number_components;
            flags = true(3*n, 1);
            t = app.TableParameters.Data;
            if istable(t) && height(t) == n && all(ismember({'fit_Ms_col', 'fit_alpha_col', 'fit_a_col'}, t.Properties.VariableNames))
                flags = [logical(t.fit_Ms_col(:)); logical(t.fit_alpha_col(:)); logical(t.fit_a_col(:))];
            end
        end

        function select_a = select_a_values(app)
            % The "Select aᵢ" column (one entry per component).
            t = app.TableParameters.Data;
            if istable(t) && ismember('select_a_col', t.Properties.VariableNames)
                select_a = t.select_a_col(1:app.number_components);
            else
                select_a = t{1:app.number_components, end};
            end
        end

        function on_parameters_cell_selection(app, event)
            % Physical table: show the full-precision value of the selected
            % Ms/alpha/a cell (columns 2, 4, 6; 3, 5, 7 are Fit flags).
            if isempty(event.Indices)
                return
            end
            row = event.Indices(1,1);
            col = event.Indices(1,2);
            if row > height(app.TableParameters.Data) || isempty(app.magnetic_parameters) || row > numel(app.magnetic_parameters.Ms)
                return
            end
            AnhystereticUtils.init_parameters_table(app, false);
            switch col
                case 2
                    app.TableParameters.Data.Ms_col{row} = sprintf('%.16g', app.magnetic_parameters.Ms(row));
                case 4
                    app.TableParameters.Data.alpha_col{row} = sprintf('%.16g', app.magnetic_parameters.alpha(row));
                case 6
                    app.TableParameters.Data.a_col{row} = sprintf('%.16g', app.magnetic_parameters.a(row));
            end
        end

        function on_quantities_cell_selection(app, event)
            % Calculated-quantities table: full-precision value of the
            % selected cell (row 1 is component 0 when the linear term is on).
            if isempty(event.Indices)
                return
            end
            row = event.Indices(1,1);
            col = event.Indices(1,2);
            mp = app.magnetic_parameters;
            if row > height(app.TableQuantities.Data) || isempty(mp)
                return
            end
            AnhystereticUtils.init_quantities_table(app, false);
            k0 = double(AnhystereticUtils.linear_term_enabled(app));
            if k0 && row == 1
                if col == 5
                    app.TableQuantities.Data.chi_in_col{1} = sprintf('%.16g', mp.chi0);
                end
                return
            end
            i = row - k0;
            if i < 1 || i > numel(mp.dimensionless_alphaMs)
                return
            end
            switch col
                case 2
                    app.TableQuantities.Data.dimensionless_alphaMs_col{row} = sprintf('%.16g', mp.dimensionless_alphaMs(i));
                case 3
                    app.TableQuantities.Data.density_product_col{row} = sprintf('%.16g', mp.density_product(i));
                case 4
                    app.TableQuantities.Data.Hk_col{row} = sprintf('%.16g', mp.Hk(i));
                case 5
                    app.TableQuantities.Data.chi_in_col{row} = sprintf('%.16g', mp.chi_in(i));
            end
        end

        function plot(app)
            AnhystereticUtils.plot_M(app);
            AnhystereticUtils.plot_dMdH(app);
            AnhystereticUtils.plot_HdMdH(app);

            AnhystereticUtils.init_parameters_table(app, false);
            AnhystereticUtils.init_quantities_table(app, false);

            AnhystereticUtils.sync_fitted_parameter_values_from_components(app);
            AnhystereticUtils.refresh_table_value_display(app);
            % Js [T] (saturation polarization) requires the true volume Ms,
            % which a mass-native fit cannot supply without a known density.
            % Its display slot is repurposed to show the total saturation
            % mass magnetization sigma_S = sum(sigma_S,i) instead -- exactly
            % what magnetic_parameters.Ms already holds per-component when
            % M_is_mass_based.
            app.LWModel_eq.Text = DisplayUnits.get_lw_model_eq(app);
            app.JsTLabel.Text = char(DisplayUnits.get_Js_slot_label(app));
            if app.M_is_mass_based
                app.JsField.Value = sum(app.magnetic_parameters.Ms);
            else
                app.JsField.Value = app.magnetic_parameters.Js;
            end
            app.chiinLabel.Text = char(DisplayUnits.get_chi_total_label(app));
            app.chiinField.Value = app.magnetic_parameters.chi_in_total;
            if isprop(app, 'LinearTermCheckBox') && ~isempty(app.LinearTermCheckBox)
                app.LinearTermCheckBox.Text = char(DisplayUnits.get_linear_term_text(app));
            end

            % Keep the directly-fit physical parameters in physical-fit mode;
            % only recompute magnetic_parameters from the distribution
            % parameters otherwise (see calculate_parameters for the rationale).
            if ~AnhystereticUtils.use_physical_parameters(app)
                select_a = AnhystereticUtils.select_a_values(app);
                app.magnetic_parameters = MagneticParameters(app.data_curve, app.Hcr, app.mcr, app.Hx, select_a, [], AnhystereticUtils.chi0_value(app));
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

            Hhat = AnhystereticUtils.modeled_H_grid(app);
            if isempty(Hhat)
                app.write_message("Not enough positive H points to build modeled curve.");
                return;
            end

            % In physical-fit ("reduce dof" unchecked) mode, app.magnetic_parameters
            % holds the directly-fit Ms/alpha/a and must NOT be rebuilt from the
            % now-stale distribution parameters (Hcr/mcr/Hx). Only rebuild it in
            % the default distribution mode.
            if ~AnhystereticUtils.use_physical_parameters(app)
                select_a = AnhystereticUtils.select_a_values(app);
                app.magnetic_parameters = MagneticParameters(app.data_curve, app.Hcr, app.mcr, app.Hx, select_a, [], AnhystereticUtils.chi0_value(app));
                % 'Constrained by n data points' unchecked: Ms/alpha/a are
                % free parameters from here on. Freeze the ones just derived
                % (the physical fit's seed) instead of waiting for a physical
                % fit, or every chi0 edit would re-solve the tip/Hx
                % constraints on M - chi0*H and move them.
                if ~AnhystereticUtils.reduce_dof_enabled(app) && isprop(app, 'physical_fit_active')
                    app.physical_fit_active = true;
                end
            else
                % Physical mode: keep Ms/alpha/a, but take chi0 from its
                % (still editable) table row, so editing it or toggling the
                % linear term takes effect at once.
                mp = app.magnetic_parameters;
                chi0 = AnhystereticUtils.chi0_value(app);
                if mp.chi0 ~= chi0
                    app.magnetic_parameters = MagneticParameters(app.data_curve, [], [], [], [], ...
                        struct('Ms', mp.Ms, 'alpha', mp.alpha, 'a', mp.a, 'chi0', chi0));
                end
            end

            app.modeled_curve = ModeledAnhystereticCurve(Hhat, app.magnetic_parameters);
        end

        function Hhat = modeled_H_grid(app)
            %MODELED_H_GRID The field grid of the modeled anhysteretic curve
            %   (0 plus N-1 points up to the tip, log- or linearly spaced as
            %   the tab says); [] when the data has fewer than two positive H.
            N = max(2, round(app.NofpointsEditField.Value));
            H = app.data_curve.H(:).';
            M = app.data_curve.M(:).';

            % Work only with positive H for log spacing
            Hpos = H(H > 0);
            if numel(Hpos) < 2
                Hhat = [];
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

            point_space = string(app.PointSpaceDropDown.Value);
            if (point_space == "log") || (point_space == "Logarithmically spaced")
                Hhat = logspace(log10(Hstart), log10(HTip), N-1);
            else
                Hhat = linspace(Hstart, HTip, N-1);
            end
            Hhat = [0, Hhat];
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

        function n_sig = significant_digits(app)
            %SIGNIFICANT_DIGITS Number of significant digits the Anhysteretic
            %   fit polishes its parameters to (Inf = full precision), from
            %   the tab's "Significant digits" dropdown; 3 when the app has
            %   no such component (older .mlapp).
            n_sig = 3;
            if isprop(app, 'SignificantdigitsDropDown') && ~isempty(app.SignificantdigitsDropDown)
                n_sig = SolverUtils.n_sig_from_dropdown(app.SignificantdigitsDropDown.Value);
            end
        end

        function tf = was_polished(polish)
            tf = isstruct(polish) && isfield(polish, 'moves');
        end

        function write_polish_message(app, polish)
            %WRITE_POLISH_MESSAGE One line in the Messages panel about the
            %   lattice polish (shared wording with the Hysteretic tab).
            if ~AnhystereticUtils.was_polished(polish)
                return;
            end
            app.write_message(SolverUtils.polish_summary(polish));
        end

        function reduce_dof = reduce_dof_enabled(app)
            % Defensive default: fit with reduced degrees of freedom when the
            % checkbox component is not available.
            reduce_dof = true;
            if isprop(app, 'ReduceDofCheckBox') && ~isempty(app.ReduceDofCheckBox)
                reduce_dof = logical(app.ReduceDofCheckBox.Value);
            end
        end

        function fit_parameters(app, polish_only)
            % polish_only (default false): skip the solver and run only the
            % lattice polish on the parameters the tab already holds -- the
            % "Polish" button (see polish_fit). A plain Fit never polishes.
            if nargin < 2 || isempty(polish_only)
                polish_only = false;
            end
            if ~isobject(app.data_curve) || ~isprop(app.data_curve, 'H') || isempty(app.data_curve.H)
                app.write_message("No dataset imported yet. Please import a dataset on the Input data tab first.");
                return;
            end
            SolverUtils.eval_limit_info(struct('hit', false, 'limit', 0));
            if AnhystereticUtils.reduce_dof_enabled(app)
                AnhystereticUtils.fit_parameters_reduced(app, polish_only);
            else
                AnhystereticUtils.fit_parameters_physical(app, polish_only);
            end
            MenuUtils.mark_project_dirty(app);
        end

        function polish_fit(app)
            %POLISH_FIT "Polish" button of the Anhysteretic-fitting tab.
            %   Runs SolverUtils.lattice_polish on the parameters the tab
            %   already holds, at the significant digits chosen in the
            %   Digits dropdown, without refitting. Which parameters are
            %   polished follows the same "reduce dof" switch the fit
            %   follows: checked, the mathematical parameters (Hcr, m(Hcr),
            %   Hx); unchecked, the physical ones (Ms, alpha, a).
            if ~isfinite(AnhystereticUtils.significant_digits(app))
                app.write_message("Choose the number of significant digits before polishing ('Full precision' means no polish).");
                return;
            end
            AnhystereticUtils.fit_parameters(app, true);
        end

        function verb = run_verb(polish_only, tail, refinement)
            %RUN_VERB "Fitting <tail>", "Refinement <tail>" or "Polishing
            %   <tail>" for the Messages panel, so the Polish button never
            %   reports a "fit" and the second, unconstrained stage of either
            %   tab ('Constrained by n data points' / 'Constrained by Hc'
            %   unchecked) reads as the refinement it is.
            if nargin < 3 || isempty(refinement)
                refinement = false;
            end
            if polish_only
                verb = "Polishing " + tail;
            elseif refinement
                verb = "Refinement " + tail;
            else
                verb = "Fitting " + tail;
            end
        end

        function write_eval_limit_message(app)
            %WRITE_EVAL_LIMIT_MESSAGE After a fit: tell the user when the
            %   solver stopped at its evaluation limit (see
            %   SolverUtils.eval_limit_message); nothing otherwise.
            msg = SolverUtils.eval_limit_message();
            if strlength(msg) > 0
                app.write_message(msg);
            end
        end

        function write_polish_tip(app)
            %WRITE_POLISH_TIP After a refinement: the fit is full precision;
            %   polishing rounds it so the printed values reproduce it.
            app.write_message("Tip: to report reproducible values, choose the number of significant digits and press Polish.");
        end

        function fit_parameters_reduced(app, polish_only)
            if nargin < 2 || isempty(polish_only)
                polish_only = false;
            end
            N = app.NofpointsEditField.Value;
            AnhystereticUtils.calculate_parameters(app);
            select_a = AnhystereticUtils.select_a_values(app);
            % Fit vectors in fit.m's order [Hcr(1..n), m(1..n), Hx(1..n-1)],
            % picked from the table rows by type (the chi0 row, when the
            % linear term is on, is prepended by with_linear below).
            order = [AnhystereticUtils.rows_of_type(app, "Hcr"), AnhystereticUtils.rows_of_type(app, "m"), ...
                     AnhystereticUtils.rows_of_type(app, "Hx")];
            fit_lb = reshape(app.lb(order), [], 1);
            fit_ub = reshape(app.ub(order), [], 1);
            fit_select_fit = reshape(app.select_fit(order), [], 1);
            [lin_lb, lin_ub, lin_select_fit, linear, i0] = AnhystereticUtils.with_linear(app, fit_lb, fit_ub, fit_select_fit);

            app.stop_fit_requested = false;

            % See if this is a plain repeat click (nothing edited since the
            % last fit) to decide whether to accumulate the fit-progress
            % history (see FitProgressUtils.open) and whether the "Fit
            % again" tip below is due.
            conditions.lb = lin_lb;
            conditions.ub = lin_ub;
            conditions.select_fit = lin_select_fit;
            conditions.error_type = string(app.ErrorDropDown.Value);
            conditions.mode = "reduced";
            if polish_only
                conditions.mode = "reduced-polish";
            end
            seed = cat(2, app.Hcr, app.mcr, app.Hx);
            if linear
                seed = [AnhystereticUtils.chi0_value(app), seed];
            end
            is_rerun = FitProgressUtils.check_and_remember_conditions(app, 'anh', conditions, seed);

            if polish_only
                FitProgressUtils.open(app, 'anh', "Anhysteretic polish progress", app.ErrorDropDown.Value, is_rerun);
                app.write_message("Polishing started (mathematical parameters)");
            else
                FitProgressUtils.open(app, 'anh', "Anhysteretic fit progress", app.ErrorDropDown.Value, is_rerun);
                app.write_message("Fitting started (mathematical parameters)");
            end
            pause(0.01);
            tic
            try
                output_fcn = @(x, optimValues, state) app.fit_stop_output_fcn(x, optimValues, state);
                solver = SolverUtils.solver_code_from_dropdown(app.SolverDropDown.Value);
                % The lattice polish runs only when the user asks for it with
                % the "Polish" button: a plain Fit always returns the solver's
                % full-precision result (see polish_fit).
                n_sig = Inf;
                if polish_only
                    n_sig = AnhystereticUtils.significant_digits(app);
                end
                [app.Hcr, app.mcr, app.Hx, polish, chi0] = fit(app.data_curve, seed, N, select_a, app.ErrorDropDown.Value, lin_lb, lin_ub, lin_select_fit, output_fcn, solver, n_sig, polish_only, linear);
                % Prefer the best point FitProgressUtils tracked across every
                % evaluated point during the search over minimize()'s own
                % returned point: guarantees a "Stop fit" mid-search (or any
                % other reason the search's own final iterate might not be
                % its best) never leaves worse parameters than the best the
                % search actually found. Not when the fit was polished on
                % the significant-digit lattice: the tracker also saw the
                % full-precision points, whose error can be marginally lower
                % than the lattice optimum's, and the whole point of the
                % polish is to report the lattice values.
                [best_x, ~, has_best] = FitProgressUtils.get_best(app, 'anh');
                if has_best && ~AnhystereticUtils.was_polished(polish)
                    n = app.number_components;
                    k0 = double(linear);
                    if linear
                        chi0 = best_x(1);
                    end
                    app.Hcr = best_x(k0+1:k0+n);
                    app.mcr = best_x(k0+n+1:k0+2*n);
                    app.Hx = best_x(k0+2*n+1:end);
                end
                if linear
                    app.fitted_parameter_values(i0(1)) = chi0;
                    FitProgressUtils.remember_fit_result(app, 'anh', [chi0, app.Hcr, app.mcr, app.Hx]);
                else
                    FitProgressUtils.remember_fit_result(app, 'anh', cat(2, app.Hcr, app.mcr, app.Hx));
                end
                AnhystereticUtils.write_polish_message(app, polish);
                if ~polish_only
                    % 'auto (low)'/'auto (high)' components that ended on the
                    % junction of the two roots: try the other root.
                    AnhystereticUtils.auto_explore_roots(app, select_a, N, fit_lb, fit_ub, ...
                        fit_select_fit, output_fcn, solver);
                    select_a = AnhystereticUtils.select_a_values(app);
                end
                elapsed = toc;
                FitProgressUtils.record_elapsed_time(app, 'anh', elapsed);
                SolverUtils.last_fit_time(elapsed);
                t = sprintf("%0.2f", elapsed);
                if app.stop_fit_requested
                    app.write_message(AnhystereticUtils.run_verb(polish_only, "stopped by user") + " after " + t + " s");
                elseif polish_only
                    app.write_message("Polishing finished after " + t + " s");
                else
                    if isprop(app, 'physical_fit_active')
                        app.physical_fit_active = false;
                    end
                    app.write_message("Fitting finished after " + t + " s");
                    AnhystereticUtils.write_eval_limit_message(app);
                    AnhystereticUtils.write_m_lower_bound_messages(app, select_a, fit_lb, fit_select_fit);
                    if isprop(app, 'ReduceDofCheckBox') && ~isempty(app.ReduceDofCheckBox)
                        app.write_message("Tip: uncheck 'Constrained by n data points' and fit again to further refine the physical parameters.");
                    end
                end
            catch e
                t = sprintf("%0.2f", toc);
                app.write_message(AnhystereticUtils.run_verb(polish_only, "failed") + " after " + t + " s: " + e.message);
            end
        end

        function fit_parameters_physical(app, polish_only)
            if nargin < 2 || isempty(polish_only)
                polish_only = false;
            end
            % "reduce dof" UNCHECKED: refine the physical parameters
            % (Ms, alpha, a) directly, seeded from their current values (the
            % result of a prior distribution-mode fit). Ms/alpha/a are left
            % unbounded (an individual component's Ms can be negative), so the
            % seed stays feasible and the error can only improve.
            N = app.NofpointsEditField.Value;
            n = app.number_components;

            mp = app.magnetic_parameters;
            if ~isobject(mp) || isempty(mp.Ms) || numel(mp.Ms) ~= n
                app.write_message("Run a fit with 'Constrained by n data points' checked first to seed the physical parameters.");
                return;
            end

            % Seed straight from the current physical parameters -- do NOT call
            % calculate_parameters here, which (in distribution mode) would
            % rebuild magnetic_parameters from the stale Hcr/mcr/Hx and destroy
            % the seed.
            seed = [mp.Ms(:).', mp.alpha(:).', mp.a(:).'];

            % Unbounded: pass +/-Inf, which minimize() leaves untransformed
            % (until 2026-09-19 a finite 1e12 stand-in was used, which forced
            % its asin bound transform and needed a cap in fit_physical.m).
            % Which parameters are fitted: the Fit columns of the physical
            % table (unticked = held at its value, excluded from the solver).
            fit_lb = -Inf(3*n, 1);
            fit_ub =  Inf(3*n, 1);
            fit_select_fit = num2cell(AnhystereticUtils.physical_fit_flags(app));
            % Linear term: first parameter, with the bounds and Fit flag of
            % its row in the mathematical-parameters table.
            [fit_lb, fit_ub, fit_select_fit, linear, i0] = AnhystereticUtils.with_linear(app, fit_lb, fit_ub, fit_select_fit);
            if linear
                seed = [AnhystereticUtils.chi0_value(app), seed];
            end
            if ~any(cellfun(@logical, fit_select_fit))
                app.write_message("Nothing to fit: tick at least one Fit box.");
                return;
            end

            app.stop_fit_requested = false;

            conditions.lb = fit_lb;
            conditions.ub = fit_ub;
            conditions.select_fit = fit_select_fit;
            conditions.error_type = string(app.ErrorDropDown.Value);
            conditions.mode = "physical";
            if polish_only
                conditions.mode = "physical-polish";
            end
            is_rerun = FitProgressUtils.check_and_remember_conditions(app, 'anh', conditions, seed);

            if polish_only
                FitProgressUtils.open(app, 'anh', "Anhysteretic polish progress", app.ErrorDropDown.Value, is_rerun);
                app.write_message("Polishing started (physical parameters)");
            else
                FitProgressUtils.open(app, 'anh', "Anhysteretic fit progress", app.ErrorDropDown.Value, is_rerun);
                app.write_message("Refinement started (physical parameters)");
            end
            pause(0.01);
            tic
            try
                output_fcn = @(x, optimValues, state) app.fit_stop_output_fcn(x, optimValues, state);
                solver = SolverUtils.solver_code_from_dropdown(app.SolverDropDown.Value);
                % Polish only on request -- see fit_parameters_reduced.
                n_sig = Inf;
                if polish_only
                    n_sig = AnhystereticUtils.significant_digits(app);
                end
                [Ms, alpha, a, polish, chi0] = fit_physical(app.data_curve, seed, N, app.ErrorDropDown.Value, fit_lb, fit_ub, fit_select_fit, output_fcn, solver, n_sig, polish_only, linear);
                % Prefer the best point tracked across the search (same
                % guarantee as the distribution path, incl. after a Stop
                % fit) -- unless the fit was polished on the lattice (see
                % the distribution path for why).
                [best_x, ~, has_best] = FitProgressUtils.get_best(app, 'anh');
                if has_best && ~AnhystereticUtils.was_polished(polish)
                    k0 = double(linear);
                    if linear
                        chi0 = best_x(1);
                    end
                    Ms = best_x(k0+1:k0+n);
                    alpha = best_x(k0+n+1:k0+2*n);
                    a = best_x(k0+2*n+1:end);
                end
                AnhystereticUtils.write_polish_message(app, polish);
                physical.Ms = Ms;
                physical.alpha = alpha;
                physical.a = a;
                physical.chi0 = 0;
                if linear
                    physical.chi0 = chi0;
                    app.fitted_parameter_values(i0(1)) = chi0;
                    AnhystereticUtils.refresh_table_value_display(app);
                end
                app.magnetic_parameters = MagneticParameters(app.data_curve, [], [], [], [], physical);
                if isprop(app, 'physical_fit_active')
                    app.physical_fit_active = true;
                end
                if linear
                    FitProgressUtils.remember_fit_result(app, 'anh', [chi0, Ms(:).', alpha(:).', a(:).']);
                else
                    FitProgressUtils.remember_fit_result(app, 'anh', [Ms(:).', alpha(:).', a(:).']);
                end
                elapsed = toc;
                FitProgressUtils.record_elapsed_time(app, 'anh', elapsed);
                SolverUtils.last_fit_time(elapsed);
                t = sprintf("%0.2f", elapsed);
                if app.stop_fit_requested
                    app.write_message(AnhystereticUtils.run_verb(polish_only, "stopped by user", true) + " after " + t + " s");
                else
                    app.write_message(AnhystereticUtils.run_verb(polish_only, "finished", true) + " after " + t + " s");
                    if ~polish_only
                        AnhystereticUtils.write_eval_limit_message(app);
                        AnhystereticUtils.write_polish_tip(app);
                    end
                end
            catch e
                t = sprintf("%0.2f", toc);
                app.write_message(AnhystereticUtils.run_verb(polish_only, "failed", true) + " after " + t + " s: " + e.message);
            end
        end

        function sync_reduce_dof_ui(app)
            % Gray/disable the controls that don't apply in physical-fit mode:
            % the whole Mathematical-parameters (Hcr/mcr/Hx) fit table, and the
            % "Select aᵢ" column of the Physical-parameters table (the a-root
            % choice is only used by the distribution->a conversion). No-op
            % when the checkbox component is not present.
            if ~isprop(app, 'ReduceDofCheckBox') || isempty(app.ReduceDofCheckBox)
                return;
            end
            reduce_dof = logical(app.ReduceDofCheckBox.Value);
            linear = AnhystereticUtils.linear_term_enabled(app);

            % Mathematical parameters: in physical mode only the chi0 row
            % (linear term) is still used, so the table stays enabled just
            % for it (its other rows are grayed below and their edits are
            % rejected by reject_fitted_table_edit).
            if reduce_dof || linear
                app.TableFittedParameters.Enable = 'on';
            else
                app.TableFittedParameters.Enable = 'off';
            end
            AnhystereticUtils.shade_fitted_parameters_table(app);

            % Physical parameters: columns Component | Ms | Fit | alpha | Fit
            % | a | Fit | Select aᵢ. The Fit boxes apply to the physical fit
            % (unchecked mode); Select aᵢ only to the distribution->a
            % conversion (checked mode).
            app.TableParameters.ColumnEditable = [false false ~reduce_dof false ~reduce_dof false ~reduce_dof reduce_dof];
            % Reset the physical table's styles, then gray the frozen columns.
            % NOTE: matlab.ui.control.Table (the App Designer / uifigure
            % table, as opposed to the legacy Java uitable) does not support
            % styling the column HEADER: addStyle's targets are only
            % "table"/"row"/"column"/"cell" (all data cells), and ColumnName
            % does not render HTML markup. So only the data cells of the
            % frozen columns are grayed; the header text itself always stays
            % plain.
            AnhystereticUtils.shade_parameters_table(app);
            gray = uistyle('BackgroundColor', [0.90 0.90 0.90], 'FontColor', [0.55 0.55 0.55]);
            if reduce_dof
                addStyle(app.TableParameters, gray, 'column', [3 5 7]);
            else
                addStyle(app.TableParameters, gray, 'column', 8);
            end
        end

        function on_reduce_dof_changed(app)
            % "reduce dof" was just toggled. Unchecking freezes the current
            % Ms/alpha/a as free parameters (calculate_parameters sets
            % physical_fit_active); fit_parameters_physical is seeded from
            % them. Re-checking,
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

        function options = select_a_options()
            %SELECT_A_OPTIONS Choices of the "Select aᵢ" column, in dropdown
            %   order. 'low'/'high' fix the root of the a(Hcr, m(Hcr))
            %   equation; the auto modes start on the named root and switch to
            %   the other one when that fits better (auto_explore_roots).
            options = {'low', 'high', 'auto (low)', 'auto (high)'};
        end

        function label = select_a_default()
            % 'low' since 2026-09-25 ('auto (low)' 2026-09-24 only): on the
            % benchmark loops the auto switch improved the anhysteretic fit
            % but not the JA fits seeded from it (Americo's BOBYQA fit got
            % worse), so the switch is opt-in.
            label = 'low';
        end

        function at_bound = components_at_m_lower_bound(app, fit_lb, fit_select_fit)
            %COMPONENTS_AT_M_LOWER_BOUND True for each component whose fitted
            %   m(Hcr) sits on its lower bound, where the low and high roots of
            %   a(Hcr, m(Hcr)) meet (only components whose m was fitted).
            tolerance = 1e-8;
            n = app.number_components;
            at_bound = false(n, 1);
            for i = 1:n
                m_index = n + i;
                if m_index > numel(fit_lb) || i > numel(app.mcr)
                    continue;
                end
                if m_index <= numel(fit_select_fit) && ~logical(fit_select_fit{m_index})
                    continue;
                end
                m_lower_bound = fit_lb(m_index);
                at_bound(i) = abs(app.mcr(i) - m_lower_bound) <= tolerance * max(1, abs(m_lower_bound));
            end
        end

        function e = anhysteretic_error(app, Hcr, mcr, Hx, select_a, chi0)
            %ANHYSTERETIC_ERROR The error the tab displays (ErrorDisplay) for
            %   the given mathematical parameters and roots, on the same
            %   modeled-curve grid as calculate_parameters (chi0 defaults to
            %   the table's linear term).
            if nargin < 6
                chi0 = AnhystereticUtils.chi0_value(app);
            end
            Hhat = AnhystereticUtils.modeled_H_grid(app);
            mp = MagneticParameters(app.data_curve, Hcr, mcr, Hx, select_a, [], chi0);
            curve = ModeledAnhystereticCurve(Hhat, mp);
            calc = make_error_calculator(string(app.ErrorDropDown.Value), ...
                app.data_curve.H, app.data_curve.M, curve.H, curve.M);
            e = calc.get_error();
        end

        function auto_explore_roots(app, select_a, N, fit_lb, fit_ub, fit_select_fit, output_fcn, solver)
            %AUTO_EXPLORE_ROOTS The "auto" modes of the Select aᵢ column.
            %   A component whose m(Hcr) ends on its lower bound sits where the
            %   low and high roots of a(Hcr, m(Hcr)) meet, so the optimum may
            %   lie on the other root. For every component in an auto mode
            %   that ended there, the fit is repeated from the current result
            %   with that component on the other root (all such components
            %   together, once). The other root is kept, and the column
            %   switches to 'auto (<other root>)', only if the displayed error
            %   decreases; otherwise the first result stands. Fixed 'low' /
            %   'high' components never switch (write_m_lower_bound_messages
            %   suggests the other root instead).
            labels = string(select_a(:));
            n = app.number_components;
            labels = labels(1:n);
            is_auto = startsWith(lower(labels), "auto");
            flip = is_auto & AnhystereticUtils.components_at_m_lower_bound(app, fit_lb, fit_select_fit);
            if ~any(flip) || app.stop_fit_requested
                return;
            end
            roots_now = select_a_root(labels);
            roots_new = roots_now;
            roots_new(flip & roots_now == "low") = "high";
            roots_new(flip & roots_now == "high") = "low";

            chi0_now = AnhystereticUtils.chi0_value(app);
            e_now = AnhystereticUtils.anhysteretic_error(app, app.Hcr, app.mcr, app.Hx, roots_now, chi0_now);
            seed = cat(2, app.Hcr, app.mcr, app.Hx);
            [lin_lb, lin_ub, lin_select_fit, linear, i0] = AnhystereticUtils.with_linear(app, fit_lb, fit_ub, fit_select_fit);
            if linear
                seed = [chi0_now, seed];
            end
            [Hcr2, mcr2, Hx2, ~, chi02] = fit(app.data_curve, seed, N, cellstr(roots_new), app.ErrorDropDown.Value, ...
                lin_lb, lin_ub, lin_select_fit, output_fcn, solver, Inf, false, linear);
            e_new = AnhystereticUtils.anhysteretic_error(app, Hcr2, mcr2, Hx2, roots_new, chi02);

            keep_new = isfinite(e_new) && e_new < e_now && ~app.stop_fit_requested;
            for i = find(flip).'
                if keep_new
                    app.write_message("Component " + i + ": m" + i + "(Hcr" + i + ") reached its lower bound on the '" + ...
                        roots_now(i) + "' root of a" + i + "; the '" + roots_new(i) + "' root fits better and is kept (auto).");
                else
                    app.write_message("Component " + i + ": m" + i + "(Hcr" + i + ") reached its lower bound on the '" + ...
                        roots_now(i) + "' root of a" + i + "; the '" + roots_new(i) + "' root does not fit better (auto).");
                end
            end
            if ~keep_new
                return;
            end
            app.Hcr = Hcr2;
            app.mcr = mcr2;
            app.Hx = Hx2;
            labels(flip) = "auto (" + roots_new(flip) + ")";
            column = app.TableParameters.Data.select_a_col;
            column(1:n) = categorical(cellstr(labels), AnhystereticUtils.select_a_options(), 'Ordinal', true);
            app.TableParameters.Data.select_a_col = column;
            if linear
                app.fitted_parameter_values(i0(1)) = chi02;
                FitProgressUtils.remember_fit_result(app, 'anh', [chi02, app.Hcr, app.mcr, app.Hx]);
            else
                FitProgressUtils.remember_fit_result(app, 'anh', cat(2, app.Hcr, app.mcr, app.Hx));
            end
        end

        function write_m_lower_bound_messages(app, select_a, fit_lb, fit_select_fit)
            % Suggest the other root for FIXED 'low'/'high' components whose
            % m(Hcr) ended on its lower bound (auto components are handled by
            % auto_explore_roots and never get this message).
            select_a = string(select_a);
            at_bound = AnhystereticUtils.components_at_m_lower_bound(app, fit_lb, fit_select_fit);

            for i = 1:app.number_components
                if ~at_bound(i)
                    continue;
                end
                m_lower_bound = fit_lb(app.number_components + i);

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
            % 3n-1 rows, plus the chi0 row (first) when the linear term is on;
            % rows are read by type, so their order does not matter here.
            row_count = size(app.TableFittedParameters.Data, 1);
            offset = min([row_count, numel(app.fitted_parameter_values), numel(app.component_row_types)]);
            if offset > 0
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
            app.select_fit = cell(1, row_count);
            for i = 1:row_count
                app.select_fit(i) = app.TableFittedParameters.Data(i, 5);
            end
        end

        function recompute_hx_after_hcr_edit(app, row)
            % Hx_i is the crossover seed between components i and i+1
            % (0.5*(Hcr_i + Hcr_(i+1))). When the user manually edits an
            % Hcr_i cell, the adjacent Hx defaults are stale until a refit;
            % recompute them immediately so the table stays consistent.
            % No-op for edits to any other row type (m, or Hx itself).
            if isempty(app.component_row_types) || row < 1 || row > numel(app.component_row_types)
                return;
            end
            if app.component_row_types(row) ~= "Hcr"
                return;
            end
            n = app.number_components;
            if n < 2 || numel(app.Hcr) < n
                return;
            end
            hx_rows = AnhystereticUtils.rows_of_type(app, "Hx");
            for i = 1:min(n - 1, numel(hx_rows))
                hx_row = hx_rows(i);
                new_hx = 0.5 * (app.Hcr(i) + app.Hcr(i + 1));
                app.Hx(i) = new_hx;
                if hx_row <= numel(app.fitted_parameter_values)
                    app.fitted_parameter_values(hx_row) = new_hx;
                end
            end
            AnhystereticUtils.refresh_table_value_display(app);
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

            % For 2+ components, retrieve_anhysteretic_seeds runs a joint
            % nonlinear fit of the halo templates against the measured
            % curve (needed to separate overlapping components -- see the
            % User's Guide) and can take several seconds; show an
            % indeterminate progress dialog so the user waits instead of
            % thinking the app stalled. onCleanup guarantees it closes even
            % if the fit throws.
            progress_dlg = [];
            if has_seed_curve && app.number_components > 1
                try
                    progress_dlg = uiprogressdlg(app.MagAnalystUIFigure, ...
                        'Title', 'Estimating seeds', ...
                        'Message', 'Fitting component seeds to the measured curve...', ...
                        'Indeterminate', 'on', 'Cancelable', 'off');
                    drawnow;
                catch
                end
            end
            close_progress = onCleanup(@() AnhystereticUtils.close_progress_dialog(progress_dlg)); %#ok<NASGU>

            if has_seed_curve
                try
                    [seed_Hcr, seed_mcr, seed_Hx] = retrieve_anhysteretic_seeds(AnhystereticUtils.seed_curve(app), app.number_components);
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
                component_values(2*i-1) = seed_Hcr(i);
                row_types(2*i-1) = "Hcr";
                s = 'm' + string(char(8320 + i)) + ' (' + s + ')';
                row_names(2*i,:) = {convertStringsToChars(s)};
                component_values(2*i) = seed_mcr(i);
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
                component_values(row_index) = seed_Hx(i);
                row_types(row_index) = "Hx";
                lb_col(row_index) = 0;
                ub_col(row_index) = 1000000;
            end
            if AnhystereticUtils.linear_term_enabled(app)
                % Linear term chi0 first ("component 0"): seeded from the
                % high-field slope, bounds [0, Inf) by default (set a
                % negative lower bound for a diamagnetic term).
                chi0 = 0;
                if has_seed_curve
                    chi0 = AnhystereticUtils.chi0_seed(app.data_curve);
                end
                row_names = [{char(DisplayUnits.get_chi0_label(app))}; row_names];
                component_values = [chi0; component_values];
                lb_col = [0; lb_col];
                ub_col = [Inf; ub_col];
                row_types = ["chi0"; row_types];
                row_count = row_count + 1;
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

        function close_progress_dialog(progress_dlg)
            if ~isempty(progress_dlg) && isvalid(progress_dlg)
                close(progress_dlg);
            end
        end

        function apply_axis_scale_quiet(app, ax, axis_scale)
            %APPLY_AXIS_SCALE_QUIET  Set an axes' scale without the console
            %   "Negative data ignored" warning that MATLAB prints whenever a
            %   log axis is applied to already-plotted non-positive data (the
            %   Silveyra-Conde Garrido model allows a negative Msi, whose
            %   component curve is then entirely negative -- see
            %   notify_negative_log_values, which surfaces this to the user
            %   in the Messages log instead of the command window).
            warning_state = warning('off', 'MATLAB:Axes:NegativeDataInLogAxis');
            cleanup_warning = onCleanup(@() warning(warning_state)); %#ok<NASGU>
            app.apply_axis_scale(ax, axis_scale);
        end

        function notify_negative_log_values(app, axis_scale, quantity_label, total_values, plot_components, component_values)
            %NOTIFY_NEGATIVE_LOG_VALUES  Warn in the Messages log (not the
            %   command window) when a semilog-y/log-log plot will silently
            %   hide a curve because of non-positive values -- most notably a
            %   component with a negative Msi, whose curve is then negative
            %   everywhere and invisible on a log axis. Only checks the
            %   curves that are actually drawn (components only when the
            %   "plot components" checkbox is on) and only fires once in a
            %   row for the same note, so it does not spam the log on every
            %   replot while the same fit is displayed.
            if ~FormatUtils.axis_scale_has_y(axis_scale)
                return;
            end

            negative_components = [];
            if plot_components && ~isempty(component_values)
                negative_components = find(all(component_values <= 0, 2))';
            end

            if isempty(negative_components) && all(total_values > 0)
                return;
            end

            if isempty(negative_components)
                message = "Note: the " + quantity_label + " curve has non-positive values and is partly hidden on this log-scale plot.";
            else
                message = "Note: " + quantity_label + " component(s) " + strjoin(string(negative_components), ", ") + ...
                    " have a non-positive value everywhere (e.g. a negative Ms) and are hidden on this log-scale plot.";
            end

            existing = app.MessagesTextArea.Value;
            if ~isempty(existing) && endsWith(string(existing{end}), message)
                return;
            end
            app.write_message(message);
        end

        function init_parameters_table(app, default_values)
            parameters_col = cell(app.number_components, 1);
            for i = 1:app.number_components
                s = string(i);
                parameters_col(i,:) = {convertStringsToChars(s)};
            end

            n = app.number_components;
            Ms_col = cell(n, 1);
            alpha_col = cell(n, 1);
            a_col = cell(n, 1);
            % Fit flags of the physical fit ('Constrained by n data points'
            % unchecked): one per parameter, kept across refreshes.
            fit_Ms_col = true(n, 1);
            fit_alpha_col = true(n, 1);
            fit_a_col = true(n, 1);

            select_a_col = cell(n, 1);
            for i = 1:n
                select_a_col(i,:) = {AnhystereticUtils.select_a_default()};
            end

            if ~default_values
                old = app.TableParameters.Data;
                select_a_col = AnhystereticUtils.select_a_values(app);
                if istable(old) && height(old) == n && all(ismember({'fit_Ms_col', 'fit_alpha_col', 'fit_a_col'}, old.Properties.VariableNames))
                    fit_Ms_col = logical(old.fit_Ms_col);
                    fit_alpha_col = logical(old.fit_alpha_col);
                    fit_a_col = logical(old.fit_a_col);
                end

                for i = 1:n
                    Ms_col(i,:) = {AnhystereticUtils.format_scientific(app.magnetic_parameters.Ms(i))};
                    alpha_col(i,:) = {FormatUtils.format_engineering(app.magnetic_parameters.alpha(i))};
                    a_col(i,:) = {AnhystereticUtils.format_sigfigs(app.magnetic_parameters.a(i))};
                end
            end

            t = table(parameters_col, Ms_col, fit_Ms_col, alpha_col, fit_alpha_col, a_col, fit_a_col, select_a_col);
            t.select_a_col = categorical(t.select_a_col, AnhystereticUtils.select_a_options(), 'Ordinal', true);

            app.TableParameters.Data = t;
            app.TableParameters.ColumnName = {'Component'; DisplayUnits.get_Ms_label(app); 'Fit'; DisplayUnits.get_alpha_label(app); 'Fit'; 'aᵢ [A/m]'; 'Fit'; 'Select aᵢ'};
            % Fit check boxes only need the width of their header, so the
            % value columns fit without the horizontal scroller.
            app.TableParameters.ColumnWidth = {'auto', 'auto', 36, 'auto', 36, 'auto', 36, 'auto'};
            reduce_dof = AnhystereticUtils.reduce_dof_enabled(app);
            app.TableParameters.ColumnEditable = [false false ~reduce_dof false ~reduce_dof false ~reduce_dof reduce_dof];
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

            if AnhystereticUtils.linear_term_enabled(app)
                % Component 0 (linear term) first: only its susceptibility.
                chi0_text = '';
                if ~default_values && isobject(app.magnetic_parameters)
                    chi0_text = AnhystereticUtils.format_sigfigs(app.magnetic_parameters.chi0);
                end
                parameters_col = [{'0 (linear)'}; parameters_col];
                dimensionless_alphaMs_col = [{'—'}; dimensionless_alphaMs_col];
                density_product_col = [{'—'}; density_product_col];
                Hk_col = [{'—'}; Hk_col];
                chi_in_col = [{chi0_text}; chi_in_col];
            end
            t = table(parameters_col, dimensionless_alphaMs_col, density_product_col, Hk_col, chi_in_col);
            app.TableQuantities.Data = t;
            app.TableQuantities.ColumnName = {'Component'; DisplayUnits.get_dimensionless_alphaMs_label(app); DisplayUnits.get_density_product_label(app); 'Hkᵢ [A/m]'; DisplayUnits.get_chi_label(app)};
            AnhystereticUtils.shade_quantities_table(app);
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
            % The chi0 row's name depends on the data units (mass/volume).
            for row = AnhystereticUtils.rows_of_type(app, "chi0")
                if row <= row_count
                    app.TableFittedParameters.Data(row, 1) = {char(DisplayUnits.get_chi0_label(app))};
                end
            end
        end

        function sync_fitted_parameter_values_from_components(app)
            % Write Hcr/mcr/Hx back into their rows (by row type); the chi0
            % row, when present, keeps its own value.
            row_count = numel(app.component_row_types);
            if row_count <= 0 || 3*app.number_components - 1 <= 0
                return;
            end
            values = zeros(row_count, 1);
            values(1:min(row_count, numel(app.fitted_parameter_values))) = ...
                app.fitted_parameter_values(1:min(row_count, numel(app.fitted_parameter_values)));
            rows = AnhystereticUtils.rows_of_type(app, "Hcr");
            values(rows) = app.Hcr(1:numel(rows));
            rows = AnhystereticUtils.rows_of_type(app, "m");
            values(rows) = app.mcr(1:numel(rows));
            rows = AnhystereticUtils.rows_of_type(app, "Hx");
            values(rows) = app.Hx(1:numel(rows));
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
            AnhystereticUtils.notify_negative_log_values(app, axis_scale, "M", app.modeled_curve.M, plot_components, app.modeled_curve.Mi);
            AnhystereticUtils.apply_axis_scale_quiet(app, app.AxesM, axis_scale);
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
            AnhystereticUtils.notify_negative_log_values(app, axis_scale, "dM/dH", app.modeled_curve.dMdH, plot_components, app.modeled_curve.dMidH);
            AnhystereticUtils.apply_axis_scale_quiet(app, app.AxesdMdH, axis_scale);
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
            AnhystereticUtils.notify_negative_log_values(app, axis_scale, "H·dM/dlnH", app.modeled_curve.HdMdH, plot_components, app.modeled_curve.HdMidH);
            AnhystereticUtils.apply_axis_scale_quiet(app, app.AxesHdMdH, axis_scale);
        end

        function residual_plot_M(app)
            if ~isobject(app.data_curve) || ~isprop(app.data_curve, 'H') || isempty(app.data_curve.H)
                app.write_message("No dataset imported yet. Please import a dataset on the Input data tab first.");
                return;
            end
            residue_calculator = MagnetizationResidueCalculator(app.data_curve, app.modeled_curve);
            residue = residue_calculator.get_residue();
            log_flag = FormatUtils.axis_scale_has_x(string(app.AxisScaleDropDownM.Value));
            residue_plotter = ResiduePlotter(app.data_curve.H, app.data_curve.M, app.modeled_curve.H, app.modeled_curve.M, residue, log_flag, DisplayUnits.get_M_label(app), 5, [0 0 0], app.Colors(1,:), app.Colors(1,:));
            residue_plotter.plot()
        end

        function residual_plot_dMdH(app)
            if ~isobject(app.data_curve) || ~isprop(app.data_curve, 'H') || isempty(app.data_curve.H)
                app.write_message("No dataset imported yet. Please import a dataset on the Input data tab first.");
                return;
            end
            residue_calculator = SusceptibilityResidueCalculator(app.data_curve, app.modeled_curve);
            residue = residue_calculator.get_residue();
            log_flag = FormatUtils.axis_scale_has_x(string(app.AxisScaleDropDowndMdH.Value));
            residue_plotter = ResiduePlotter(app.data_curve.H, app.data_curve.dMdH, app.modeled_curve.H, app.modeled_curve.dMdH, residue, log_flag, DisplayUnits.get_dMdH_label(app), 5, [0 0 0], app.Colors(1,:), app.Colors(1,:));
            residue_plotter.plot()
        end

        function residual_plot_HdMdH(app)
            if ~isobject(app.data_curve) || ~isprop(app.data_curve, 'H') || isempty(app.data_curve.H)
                app.write_message("No dataset imported yet. Please import a dataset on the Input data tab first.");
                return;
            end
            residue_calculator = SemilogDerivativeResidueCalculator(app.data_curve, app.modeled_curve);
            residue = residue_calculator.get_residue();
            log_flag = FormatUtils.axis_scale_has_x(string(app.AxisScaleDropDownHdMdH.Value));
            residue_plotter = ResiduePlotter(app.data_curve.H, app.data_curve.HdMdH, app.modeled_curve.H, app.modeled_curve.HdMdH, residue, log_flag, DisplayUnits.get_HdMdH_label(app), 5, [0 0 0], app.Colors(1,:), app.Colors(1,:));
            residue_plotter.plot()
        end

        function [ms_seed, a_seed, alpha_seed, has_seeds] = get_first_anhysteretic_seeds(app)
            % Reads the full-precision source (app.magnetic_parameters)
            % directly rather than the TableParameters display text, which is
            % only a 6-significant-figure rendering: parsing it back would
            % truncate the seeds handed to the Hysteretic and Playground tabs.
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
            if isempty(app.component_row_types)
                return;
            end
            types = string(app.component_row_types(:)).';
            hcr_seen = 0;
            m_seen = 0;
            hx_seen = 0;
            for row = 1:numel(types)
                switch types(row)
                    case "chi0"
                        color = AnhystereticUtils.LINEAR_COLOR;
                    otherwise
                        if types(row) == "Hcr"
                            hcr_seen = hcr_seen + 1;
                            component = hcr_seen;
                        elseif types(row) == "m"
                            m_seen = m_seen + 1;
                            component = m_seen;
                        else
                            % Hx_i sits between components i and i+1; shade
                            % it as component (i+1), the right-hand one.
                            hx_seen = hx_seen + 1;
                            component = hx_seen + 1;
                        end
                        color_row = component + 1;
                        if isempty(app.Colors) || app.number_components <= 1 || color_row > size(app.Colors, 1)
                            continue;
                        end
                        color = app.Colors(color_row,:);
                end
                addStyle(app.TableFittedParameters, ...
                    uistyle('BackgroundColor', AnhystereticUtils.lighten_color(color)), 'row', row);
            end
            % Physical-fit mode with the linear term: every row but chi0 is
            % unused (and its edits rejected), so gray it.
            if ~AnhystereticUtils.reduce_dof_enabled(app) && AnhystereticUtils.linear_term_enabled(app)
                unused = find(types ~= "chi0");
                if ~isempty(unused)
                    addStyle(app.TableFittedParameters, ...
                        uistyle('BackgroundColor', [0.90 0.90 0.90], 'FontColor', [0.55 0.55 0.55]), 'row', unused);
                end
            end
        end

        function shade_parameters_table(app)
            removeStyle(app.TableParameters);
            for col = 1:width(app.TableParameters.Data)
                addStyle(app.TableParameters, uistyle('HorizontalAlignment','right'), "column", col);
            end
            AnhystereticUtils.shade_component_table_rows(app, app.TableParameters, 0);
        end

        function shade_quantities_table(app)
            removeStyle(app.TableQuantities);
            for col = 1:5
                addStyle(app.TableQuantities, uistyle('HorizontalAlignment','right'), "column", col);
            end
            % Row 1 is component 0 (linear term) when it is on.
            k0 = double(AnhystereticUtils.linear_term_enabled(app));
            if k0
                addStyle(app.TableQuantities, ...
                    uistyle('BackgroundColor', AnhystereticUtils.lighten_color(AnhystereticUtils.LINEAR_COLOR)), 'row', 1);
            end
            AnhystereticUtils.shade_component_table_rows(app, app.TableQuantities, k0);
        end

        function shade_component_table_rows(app, table, row_offset)
            if nargin < 3
                row_offset = 0;
            end
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
                    'row', i + row_offset);
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
