classdef ExportDialogUtils
%EXPORTDIALOGUTILS Unified "Export..." dialog (replaces the deprecated
%   Output-data tab). A single Project > Export... action opens a code-built
%   uifigure listing every exportable artifact across the whole app as
%   checkboxes, with shared output-folder / file-prefix / figure-format
%   settings. Generic file-IO lives in the standalone ExportUtils.m; the
%   methods here read the app's (public) state, so they take `app` as the
%   first argument, same pattern as AnhystereticUtils/HystereticUtils/
%   PlaygroundUtils. State for the currently-open dialog is kept in
%   app.export_dialog (rebuilt each open); persisted settings (folder/
%   prefix/format/checked items) round-trip through app.export_settings.

    methods (Static)
        function open_dialog(app)
            if isstruct(app.export_dialog) && isfield(app.export_dialog, 'Fig') ...
                    && ~isempty(app.export_dialog.Fig) && isvalid(app.export_dialog.Fig)
                ExportDialogUtils.refresh_availability(app);
                try
                    app.export_dialog.Fig.Visible = 'off';
                    app.export_dialog.Fig.Visible = 'on';   % re-raise to front
                catch
                end
                return;
            end

            d = struct();
            d.Boxes = struct();
            d.ItemIds = {};

            % Magnetization symbol switches M -> sigma when the imported
            % vertical axis was mass magnetization (app.M_is_mass_based), so
            % every label mirrors the tab labels/plots (see DisplayUnits).
            if app.M_is_mass_based
                Msym = 'σ';
            else
                Msym = 'M';
            end
            trip = sprintf('%s, d%s/dH, H*d%s/dH', Msym, Msym, Msym);

            % One row per entry: {'header'|'item', id/headerText, label}
            spec = {
                'header', 'Measured data', '';
                'item',   'm_proc',  ['Processed data (' trip ') [SI base units]'];
                'header', 'Anhysteretic fit', '';
                'item',   'a_curve', ['Curves (total + components: ' trip ') [SI base units]'];
                'item',   'a_param', 'Metadata (fitted and model parameters, calculated quantities, error metrics)';
                'item',   'a_resid', ['Residuals (' trip ')'];
                'item',   'a_prog',  'Convergence history';
                'header', 'Hysteretic (Jiles-Atherton) fit', '';
                'item',   'j_loop',  'Loop';
                'item',   'j_param', 'Metadata (model parameters, tip point, fitting conditions, error metrics)';
                'item',   'j_prog',  'Convergence history';
                'header', 'Playground (current mode)', '';
                'item',   'p_modeled', 'Measured curve [selected units]';
                'item',   'p_curve', 'Simulated curve [selected units]';
                'item',   'p_info',  'Metadata';
                'header', 'Plots', '';
                'item',   'f_raw',   'Input: raw-data plot';
                'item',   'f_proc',  'Input: processed-data plot';
                'item',   'f_M',     ['Anhysteretic: ' Msym '(H) plot'];
                'item',   'f_dMdH',  ['Anhysteretic: d' Msym '/dH plot'];
                'item',   'f_HdMdH', ['Anhysteretic: H*d' Msym '/dH plot'];
                'item',   'f_anh_prog',  'Anhysteretic: fit convergence plot';
                'item',   'f_hys',   'Hysteretic: loop plot';
                'item',   'f_hyst_prog', 'Hysteretic: fit convergence plot';
                'item',   'f_play',  'Playground: simulation plot';
                };

            settings = struct();
            if isstruct(app.export_settings)
                settings = app.export_settings;
            end
            default_folder = char(FileDialogUtils.default_export_folder(app));
            if isfield(settings, 'folder') && ~isempty(settings.folder)
                default_folder = char(settings.folder);
            end
            default_prefix = '';
            try
                [~, in_base, ~] = fileparts(char(app.InputDatasetPath.Value));
                default_prefix = in_base;
            catch
            end
            if isfield(settings, 'prefix')
                default_prefix = char(settings.prefix);
            end
            default_fmt = '.png';
            if isfield(settings, 'figure_format')
                default_fmt = char(settings.figure_format);
            end
            checked = struct();
            if isfield(settings, 'checked')
                checked = settings.checked;
            end

            fig = uifigure('Name', 'Export data');
            scr = get(groot, 'ScreenSize');
            w = 540;
            h = min(680, scr(4) - 140);
            x = scr(1) + max(0, (scr(3) - w) / 2);
            y = scr(2) + max(0, (scr(4) - h) / 2);
            fig.Position = [x y w h];
            try
                fig.Icon = app.MagAnalystUIFigure.Icon;
            catch
            end
            fig.CloseRequestFcn = @(s,e) ExportDialogUtils.close_dialog(app);
            d.Fig = fig;

            % Mirror the main window's palette (app_exported.m's
            % theme_palette) so this standalone dialog reads as part of the
            % same app rather than a bare default uifigure. Kept as local
            % literals rather than calling app.theme_palette() because that
            % method is a private app-class method, not reachable from this
            % external classdef.
            accent = [0.945 0.353 0.161]; % #F15A29 brand orange
            ink    = [0.149 0.153 0.173];
            canvas = [0.957 0.949 0.937];
            fig.Color = canvas;
            try
                set(findall(fig, '-property', 'FontName'), 'FontName', 'Segoe UI');
            catch
            end

            outer = uigridlayout(fig, [6 1]);
            outer.RowHeight = {'fit', 'fit', '1x', 'fit', 'fit', 'fit'};
            outer.ColumnWidth = {'1x'};

            % --- Output folder row ---
            folderPanel = uigridlayout(outer, [1 3]);
            folderPanel.ColumnWidth = {90, '1x', 'fit'};
            folderPanel.Padding = [0 0 0 0];
            folderPanel.Layout.Row = 1;
            uilabel(folderPanel, 'Text', 'Output folder:');
            d.FolderField = uieditfield(folderPanel, 'text', 'Value', default_folder);
            browseBtn = uibutton(folderPanel, 'Text', 'Browse...');
            browseBtn.ButtonPushedFcn = @(s,e) ExportDialogUtils.browse(app);

            % --- File-name prefix row ---
            prefixPanel = uigridlayout(outer, [1 2]);
            prefixPanel.ColumnWidth = {90, '1x'};
            prefixPanel.Padding = [0 0 0 0];
            prefixPanel.Layout.Row = 2;
            lblPrefix = uilabel(prefixPanel, 'Text', 'File prefix:');
            lblPrefix.Tooltip = 'Prepended (with an underscore) to every exported file name. Defaults to the input-data file name.';
            d.PrefixField = uieditfield(prefixPanel, 'text', 'Value', default_prefix);

            % --- Scrollable list of artifacts ---
            listGrid = uigridlayout(outer, [size(spec, 1) 1]);
            listGrid.RowHeight = repmat({'fit'}, 1, size(spec, 1));
            listGrid.ColumnWidth = {'1x'};
            listGrid.Scrollable = 'on';
            listGrid.Layout.Row = 3;
            for i = 1:size(spec, 1)
                kind = spec{i, 1};
                key = spec{i, 2};
                label = spec{i, 3};
                if strcmp(kind, 'header')
                    lbl = uilabel(listGrid, 'Text', key, 'FontWeight', 'bold', ...
                        'FontColor', ink, 'FontSize', 13);
                    lbl.Layout.Row = i;
                    lbl.Layout.Column = 1;
                else
                    is_checked = isfield(checked, key) && checked.(key);
                    cb = uicheckbox(listGrid, 'Text', label, 'Value', is_checked);
                    cb.Layout.Row = i;
                    cb.Layout.Column = 1;
                    d.Boxes.(key) = cb;
                    d.ItemIds{end+1} = key;
                end
            end

            % --- Figure format ---
            optsPanel = uigridlayout(outer, [1 3]);
            optsPanel.ColumnWidth = {'fit', 'fit', '1x'};
            optsPanel.Padding = [0 0 0 0];
            optsPanel.Layout.Row = 4;
            uilabel(optsPanel, 'Text', 'Plot format:');
            fmt_items = {'.png', '.pdf', '.svg'};
            if ~ismember(default_fmt, fmt_items)
                default_fmt = '.png';
            end
            d.FigFormat = uidropdown(optsPanel, 'Items', fmt_items, 'Value', default_fmt);

            % --- Status line ---
            d.Status = uilabel(outer, 'Text', '', 'WordWrap', 'on');
            d.Status.Layout.Row = 5;

            % --- Buttons ---
            btnPanel = uigridlayout(outer, [1 3]);
            btnPanel.ColumnWidth = {'1x', '1x', 'fit'};
            btnPanel.Padding = [0 0 0 0];
            btnPanel.Layout.Row = 6;
            allBtn = uibutton(btnPanel, 'Text', 'Export all available');
            allBtn.ButtonPushedFcn = @(s,e) ExportDialogUtils.do_export(app, 'all');
            selBtn = uibutton(btnPanel, 'Text', 'Export selected');
            selBtn.ButtonPushedFcn = @(s,e) ExportDialogUtils.do_export(app, 'selected');
            selBtn.BackgroundColor = accent;
            selBtn.FontColor = [1 1 1];
            selBtn.FontWeight = 'bold';
            closeBtn = uibutton(btnPanel, 'Text', 'Close');
            closeBtn.ButtonPushedFcn = @(s,e) ExportDialogUtils.close_dialog(app);

            app.export_dialog = d;
            ExportDialogUtils.refresh_availability(app);
        end

        function browse(app)
            startFolder = string(app.export_dialog.FolderField.Value);
            folder = app.safe_getdir(startFolder, "Select output folder");
            if folder == ""
                return;
            end
            app.ensure_folder(folder);
            app.export_dialog.FolderField.Value = char(folder);
        end

        function close_dialog(app)
            ExportDialogUtils.capture_settings(app);
            if isstruct(app.export_dialog) && isfield(app.export_dialog, 'Fig') ...
                    && ~isempty(app.export_dialog.Fig) && isvalid(app.export_dialog.Fig)
                delete(app.export_dialog.Fig);
            end
            app.export_dialog = struct();
        end

        function capture_settings(app)
            if ~(isstruct(app.export_dialog) && isfield(app.export_dialog, 'Boxes'))
                return;
            end
            d = app.export_dialog;
            s = struct();
            s.folder = char(d.FolderField.Value);
            s.prefix = char(d.PrefixField.Value);
            s.figure_format = char(d.FigFormat.Value);
            checked = struct();
            for i = 1:numel(d.ItemIds)
                id = d.ItemIds{i};
                if isvalid(d.Boxes.(id))
                    checked.(id) = logical(d.Boxes.(id).Value);
                end
            end
            s.checked = checked;
            app.export_settings = s;
        end

        function fname = export_filename(app, base)
            prefix = "";
            if isstruct(app.export_dialog) && isfield(app.export_dialog, 'PrefixField') ...
                    && ~isempty(app.export_dialog.PrefixField) && isvalid(app.export_dialog.PrefixField)
                prefix = strtrim(string(app.export_dialog.PrefixField.Value));
            end
            prefix = regexprep(prefix, '[<>:"/\\|?*]', '_');
            if strlength(prefix) > 0
                fname = char(prefix + "_" + string(base));
            else
                fname = char(string(base));
            end
        end

        function set_status(app, text)
            if isstruct(app.export_dialog) && isfield(app.export_dialog, 'Status') ...
                    && ~isempty(app.export_dialog.Status) && isvalid(app.export_dialog.Status)
                app.export_dialog.Status.Text = char(text);
            end
        end

        function a = availability(app)
            has_raw = ~isempty(app.H_raw) && ~isempty(app.M_raw);
            has_proc = ~isempty(app.data_curve) && ~isempty(app.data_curve.H) && ~isempty(app.data_curve.M);
            has_model = ~isempty(app.modeled_curve) && ~isempty(app.modeled_curve.H);
            has_params = has_model && ~isempty(app.magnetic_parameters);
            [~, ja_ok] = app.get_ja_params_from_tab();
            [~, ~, tip_ok] = app.get_ja_tip_from_tab_or_data();
            [~, ~, ~, play_ok] = PlaygroundUtils.get_simulation_export(app);
            [~, ~, play_data_ok] = app.get_playground_data_curve();
            [~, ~, ~, has_anh_prog]  = FitProgressUtils.get_history(app, 'anh');
            [~, ~, ~, has_hyst_prog] = FitProgressUtils.get_history(app, 'hyst');

            a.m_proc = has_proc;
            a.a_curve = has_model;
            a.a_param = has_params;
            a.a_resid = has_proc && has_model;
            a.a_prog  = has_anh_prog;
            a.j_param = ja_ok;
            a.j_loop  = ja_ok && tip_ok;
            a.j_prog  = has_hyst_prog;
            a.p_modeled = play_data_ok;
            a.p_curve = play_ok;
            a.p_info  = play_ok;
            a.f_raw   = has_raw;
            a.f_proc  = has_proc;
            a.f_M     = has_proc || has_model;
            a.f_dMdH  = has_proc || has_model;
            a.f_HdMdH = has_proc || has_model;
            a.f_hys   = has_raw;
            a.f_play  = play_ok;
            a.f_anh_prog  = has_anh_prog;
            a.f_hyst_prog = has_hyst_prog;
        end

        function refresh_availability(app)
            if ~(isstruct(app.export_dialog) && isfield(app.export_dialog, 'Boxes'))
                return;
            end
            a = ExportDialogUtils.availability(app);
            ids = fieldnames(app.export_dialog.Boxes);
            for i = 1:numel(ids)
                id = ids{i};
                cb = app.export_dialog.Boxes.(id);
                if isempty(cb) || ~isvalid(cb)
                    continue;
                end
                if isfield(a, id) && a.(id)
                    cb.Enable = 'on';
                else
                    cb.Enable = 'off';
                    cb.Value = false;
                end
            end
        end

        function do_export(app, mode)
            ExportDialogUtils.capture_settings(app);
            d = app.export_dialog;
            folder = strtrim(string(d.FolderField.Value));
            if strlength(folder) == 0
                ExportDialogUtils.set_status(app, "Choose an output folder first.");
                return;
            end
            app.ensure_folder(folder);
            folder = char(folder);

            a = ExportDialogUtils.availability(app);
            selected = {};
            for i = 1:numel(d.ItemIds)
                id = d.ItemIds{i};
                if ~a.(id)
                    continue;
                end
                if strcmp(mode, 'all') || d.Boxes.(id).Value
                    selected{end+1} = id; %#ok<AGROW>
                end
            end
            if isempty(selected)
                if strcmp(mode, 'all')
                    ExportDialogUtils.set_status(app, "Nothing available to export yet.");
                else
                    ExportDialogUtils.set_status(app, "No available items are selected.");
                end
                return;
            end

            fmt = char(d.FigFormat.Value);
            saved = strings(0, 1);
            failed = strings(0, 1);
            progress = uiprogressdlg(d.Fig, 'Title', 'Exporting', ...
                'Message', 'Preparing...', 'Indeterminate', 'off', 'Cancelable', 'off');
            for i = 1:numel(selected)
                id = selected{i};
                progress.Value = (i - 1) / numel(selected);
                progress.Message = sprintf('Exporting %d of %d (%s)...', i, numel(selected), id);
                try
                    names = ExportDialogUtils.export_one(app, id, folder, fmt);
                    saved = [saved; names(:)]; %#ok<AGROW>
                catch ME
                    failed(end+1, 1) = string(id) + " (" + string(ME.message) + ")"; %#ok<AGROW>
                end
            end
            progress.Value = 1;
            close(progress);

            msg = "Exported " + numel(saved) + " file(s) to " + string(folder);
            if ~isempty(failed)
                msg = msg + "; " + numel(failed) + " failed";
            end
            ExportDialogUtils.set_status(app, msg + ".");
            app.write_message(msg + ".");
            for i = 1:numel(saved)
                app.write_message("  saved " + saved(i));
            end
            for i = 1:numel(failed)
                app.write_message("  FAILED " + failed(i));
            end
        end

        function names = export_one(app, id, folder, fmt)
            names = strings(0, 1);
            switch id
                case 'm_proc';  names = ExportDialogUtils.export_measured_processed(app, folder);
                case 'a_curve'; names = ExportDialogUtils.export_anh_curve(app, folder);
                case 'a_param'; names = ExportDialogUtils.export_anh_parameters(app, folder);
                case 'a_resid'; names = ExportDialogUtils.export_anh_residuals(app, folder);
                case 'a_prog';  names = ExportDialogUtils.export_fit_progress_csv(app, 'anh', folder);
                case 'j_param'; names = ExportDialogUtils.export_ja_parameters(app, folder);
                case 'j_loop';  names = ExportDialogUtils.export_ja_loop(app, folder);
                case 'j_prog';  names = ExportDialogUtils.export_fit_progress_csv(app, 'hyst', folder);
                case 'p_modeled'; names = ExportDialogUtils.export_playground_modeled(app, folder);
                case 'p_curve'; names = ExportDialogUtils.export_playground_curve(app, folder);
                case 'p_info';  names = ExportDialogUtils.export_playground_info(app, folder);
                case 'f_raw';   names = ExportDialogUtils.export_axes_image(app, app.AxesRawInputData, 'input_raw', folder, fmt);
                case 'f_proc';  names = ExportDialogUtils.export_axes_image(app, app.AxesProcessedInputData, 'input_processed', folder, fmt);
                case 'f_M';     names = ExportDialogUtils.export_axes_image(app, app.AxesM, 'anh_M', folder, fmt);
                case 'f_dMdH';  names = ExportDialogUtils.export_axes_image(app, app.AxesdMdH, 'anh_dMdH', folder, fmt);
                case 'f_HdMdH'; names = ExportDialogUtils.export_axes_image(app, app.AxesHdMdH, 'anh_dMdlnH', folder, fmt);
                case 'f_hys';   names = ExportDialogUtils.export_axes_image(app, app.AxesM_2, 'JA_hysteresis_fit', folder, fmt);
                case 'f_play';  names = ExportDialogUtils.export_axes_image(app, app.AxesM_5, 'playground', folder, fmt);
                case 'f_anh_prog';  names = ExportDialogUtils.export_fit_progress_fig(app, 'anh', folder, fmt);
                case 'f_hyst_prog'; names = ExportDialogUtils.export_fit_progress_fig(app, 'hyst', folder, fmt);
            end
        end

        % ---- Fit convergence history (shared by Anhysteretic/Hysteretic) ----

        function [iters, vals, err_name, base, elapsed_time] = fit_progress_data(app, kind)
            [iters, vals, err_name, has_history, elapsed_time] = FitProgressUtils.get_history(app, kind);
            if ~has_history
                error('MagAnalyst:export', 'No fit convergence history is available.');
            end
            if strcmp(kind, 'anh')
                base = 'anh_fit_convergence';
            else
                base = 'hysteretic_fit_convergence';
            end
        end

        function names = export_fit_progress_csv(app, kind, folder)
            [iters, vals, err_name, base] = ExportDialogUtils.fit_progress_data(app, kind);
            file_name = ExportDialogUtils.export_filename(app, [base '.csv']);
            ExportUtils.write_columns_csv(fullfile(folder, file_name), ...
                {'iteration', char("error (" + err_name + ")")}, {iters, vals});
            names = string(file_name);
        end

        function names = export_fit_progress_fig(app, kind, folder, fmt)
            [iters, vals, err_name, base] = ExportDialogUtils.fit_progress_data(app, kind);
            fig = figure('Visible', 'off');
            cleanup = onCleanup(@() close(fig)); %#ok<NASGU>
            ax = axes(fig);
            semilogy(ax, iters, vals, '-o', 'LineWidth', 1.2, 'MarkerSize', 4, 'Color', [0.945 0.353 0.161]);
            grid(ax, 'on');
            xlabel(ax, 'Iteration');
            ylabel(ax, char("Best " + err_name + " error so far"));
            title(ax, 'Fit convergence');
            file_name = ExportDialogUtils.export_filename(app, [base char(string(fmt))]);
            ExportUtils.save_axes_image(ax, fullfile(folder, file_name), 400);
            names = string(file_name);
        end

        % ---- Individual artifact builders (read app's public state) ----

        function names = export_measured_processed(app, folder)
            dc = app.data_curve;
            file_name = ExportDialogUtils.export_filename(app, 'anh_processed_data.csv');
            ExportUtils.write_columns_csv(fullfile(folder, file_name), ...
                {'H [A/m]', char(DisplayUnits.get_M_label(app)), char(DisplayUnits.get_dMdH_label(app)), char(DisplayUnits.get_HdMdH_label(app))}, ...
                {dc.H, dc.M, dc.dMdH, dc.HdMdH});
            names = string(file_name);
        end

        function names = export_anh_curve(app, folder)
            mc = app.modeled_curve;
            M_label = char(DisplayUnits.get_M_label(app));
            dMdH_label = char(DisplayUnits.get_dMdH_label(app));
            HdMdH_label = char(DisplayUnits.get_HdMdH_label(app));
            if app.number_components > 1
                t = table(transpose(mc.H), transpose(mc.M), array2table(transpose(mc.Mi)), transpose(mc.dMdH), array2table(transpose(mc.dMidH)), transpose(mc.HdMdH), array2table(transpose(mc.HdMidH)));
                t = splitvars(t);
                variable_names = cell(4 + app.number_components*3, 1);
                variable_names(1) = {'H [A/m]'};
                variable_names(2) = {M_label};
                variable_names(app.number_components + 3) = {dMdH_label};
                variable_names(2*app.number_components + 4) = {HdMdH_label};
                for i = 1:app.number_components
                    variable_names(i + 2) = {ExportDialogUtils.indexed_label(M_label, i)};
                    variable_names(i + app.number_components + 3) = {ExportDialogUtils.indexed_label(dMdH_label, i)};
                    variable_names(i + 2*app.number_components + 4) = {ExportDialogUtils.indexed_label(HdMdH_label, i)};
                end
                t.Properties.VariableNames = variable_names;
            else
                t = table(transpose(mc.H), transpose(mc.M), transpose(mc.dMdH), transpose(mc.HdMdH));
                t.Properties.VariableNames(:) = {'H [A/m]', M_label, dMdH_label, HdMdH_label};
            end
            file_name = ExportDialogUtils.export_filename(app, 'modeled_anhysteretic_magnetization.csv');
            ExportUtils.write_table_csv(t, fullfile(folder, file_name));
            names = string(file_name);
        end

        function names = export_anh_parameters(app, folder)
            nl = newline;
            lines = "ANHYSTERETIC FIT PARAMETERS";
            lines = lines + nl + "===========================";

            % --- Fitted parameters ---
            lines = lines + nl + nl + "Fitted parameters";
            lines = lines + nl + "-----------------";
            for i = 1:height(app.TableFittedParameters.Data)
                name = app.subscript_to_number(string(app.TableFittedParameters.Data(i, 1)));
                value = str2double(app.TableFittedParameters.Data(i, 2));
                lines = lines + nl + sprintf("  %-14s = %14.6g", name, value);
            end

            % --- Model-retrieved parameters (per component) ---
            if app.M_is_mass_based
                Ms_name = 'sigma_s'; Ms_unit = 'Am^2/kg';
                alpha_name = 'rho*alpha'; alpha_unit = 'kg/m^3';
            else
                Ms_name = 'Ms'; Ms_unit = 'A/m';
                alpha_name = 'alpha'; alpha_unit = '';
            end
            lines = lines + nl + nl + "Model-retrieved parameters";
            lines = lines + nl + "--------------------------";
            for i = 1:height(app.TableParameters.Data)
                Ms_value = str2double(app.TableParameters.Data(i, 2).Ms_col);
                alpha_value = str2double(app.TableParameters.Data(i, 3).alpha_col);
                a_value = str2double(app.TableParameters.Data(i, 4).a_col);
                Ms_label = sprintf("%s%d%s", Ms_name, i, ExportDialogUtils.bracket_unit(Ms_unit));
                alpha_label = sprintf("%s%d%s", alpha_name, i, ExportDialogUtils.bracket_unit(alpha_unit));
                lines = lines + nl + sprintf("  Component %d", i);
                lines = lines + nl + sprintf("    %-20s = %14.6g", Ms_label, Ms_value);
                lines = lines + nl + sprintf("    %-20s = %14.6g", alpha_label, alpha_value);
                lines = lines + nl + sprintf("    %-20s = %14.6g", sprintf("a%d [A/m]", i), a_value);
            end

            % --- Calculated quantities (per component) ---
            if app.M_is_mass_based
                alphaMs_name = 'rho*alpha*|sigma_s|/(3a)';
                density_unit = 'J/kg';
                chi_name = 'chi_m,in'; chi_unit = 'm^3/kg';
            else
                alphaMs_name = 'alpha*|Ms|/(3a)';
                density_unit = 'J/m^3';
                chi_name = 'chi_in'; chi_unit = '';
            end
            lines = lines + nl + nl + "Calculated quantities";
            lines = lines + nl + "---------------------";
            for i = 1:height(app.TableQuantities.Data)
                alpha_Ms_value = str2double(app.TableQuantities.Data(i, 2).dimensionless_alphaMs_col);
                density_product_value = str2double(app.TableQuantities.Data(i, 3).density_product_col);
                Hk_value = str2double(app.TableQuantities.Data(i, 4).Hk_col);
                chi_in_value = str2double(app.TableQuantities.Data(i, 5).chi_in_col);
                lines = lines + nl + sprintf("  Component %d", i);
                lines = lines + nl + sprintf("    %-26s = %14.6g", sprintf("%s (component %d)", alphaMs_name, i), alpha_Ms_value);
                lines = lines + nl + sprintf("    %-26s = %14.6g", sprintf("N%d*kB*T [%s]", i, density_unit), density_product_value);
                lines = lines + nl + sprintf("    %-26s = %14.6g", sprintf("Hk%d [A/m]", i), Hk_value);
                lines = lines + nl + sprintf("    %-26s = %14.6g", sprintf("%s%d%s", chi_name, i, ExportDialogUtils.bracket_unit(chi_unit)), chi_in_value);
            end

            % --- Errors (all six error definitions) ---
            dc = app.data_curve;
            mc = app.modeled_curve;
            err_specs = { ...
                'Diagonal (H, sampled)',       DiagonalErrorCalculator(dc.H, dc.M, mc.H, mc.M, false, false); ...
                'Diagonal (H, continuous)',    DiagonalErrorCalculator(dc.H, dc.M, mc.H, mc.M, false, true); ...
                'Diagonal (logH, sampled)',    DiagonalErrorCalculator(dc.H, dc.M, mc.H, mc.M, true,  false); ...
                'Diagonal (logH, continuous)', DiagonalErrorCalculator(dc.H, dc.M, mc.H, mc.M, true,  true); ...
                'Vertical',                    VerticalErrorCalculator(dc.H, dc.M, mc.H, mc.M, true); ...
                'Horizontal',                  HorizontalErrorCalculator(dc.H, dc.M, mc.H, mc.M, true)};
            lines = lines + nl + nl + "Errors";
            lines = lines + nl + "------";
            for k = 1:size(err_specs, 1)
                val = err_specs{k, 2}.get_error();
                lines = lines + nl + sprintf("  %-28s = %12.4e", err_specs{k, 1}, val);
            end

            % --- Fitting conditions (error metric + stop criterion) ---
            lines = lines + nl + nl + "Fitting conditions";
            lines = lines + nl + "------------------";
            lines = lines + nl + sprintf("  %-18s = %s", "Error metric", ...
                strtrim(string(app.ErrorDropDown.Value)));
            lines = lines + nl + sprintf("  %-18s = %s", "Stop criterion", ...
                strtrim(string(app.StopcriterionDropDown.Value)));
            if strcmp(app.StopcriterionDropDown.Value, 'Fixed repetitions')
                lines = lines + nl + sprintf("  %-18s = %d", "Repetitions", ...
                    int32(app.RepetitionsEditField.Value));
            end

            % --- Total elapsed time ---
            [~, ~, ~, ~, elapsed_time] = FitProgressUtils.get_history(app, 'anh');
            if elapsed_time > 0
                lines = lines + nl + nl + "Total elapsed time";
                lines = lines + nl + "-------------------";
                lines = lines + nl + sprintf("  %g seconds", elapsed_time);
            end

            file_name = ExportDialogUtils.export_filename(app, 'anh_parameters.txt');
            ExportUtils.write_text(fullfile(folder, file_name), lines);
            names = string(file_name);
        end

        function labeled = indexed_label(label, i)
            % Insert a component index right after the symbol, before any
            % unit bracket -- e.g. "M [A/m]" + 1 -> "M1 [A/m]", "dM/dH" + 1
            % -> "dM/dH1" (labels without a unit have no bracket to split on).
            label = char(label);
            bracket_pos = strfind(label, ' [');
            if isempty(bracket_pos)
                labeled = sprintf('%s%d', label, i);
            else
                pos = bracket_pos(1);
                labeled = [label(1:pos-1) sprintf('%d', i) label(pos:end)];
            end
        end

        function bracketed = bracket_unit(unit)
            if strlength(string(unit)) == 0
                bracketed = '';
            else
                bracketed = char(" [" + string(unit) + "]");
            end
        end

        function txt = format_bound(field)
            % Render a JA bound field for the "Fitting conditions" section:
            % an empty/blank field means "auto" (no user-set bound), +-Inf
            % print as such, everything else as %.6g.
            try
                v = field.Value;
            catch
                txt = 'auto';
                return;
            end
            if isempty(v)
                txt = 'auto';
            elseif ~isfinite(v)
                if v > 0
                    txt = '+Inf';
                else
                    txt = '-Inf';
                end
            else
                txt = sprintf('%.6g', v);
            end
        end

        function names = export_anh_residuals(app, folder)
            names = strings(0, 1);
            r = MagnetizationResidueCalculator(app.data_curve, app.modeled_curve).get_residue();
            names(end+1, 1) = ExportDialogUtils.write_residual_csv(app, r, 'anh_residual_M.csv', folder);
            r = SusceptibilityResidueCalculator(app.data_curve, app.modeled_curve).get_residue();
            names(end+1, 1) = ExportDialogUtils.write_residual_csv(app, r, 'anh_residual_dMdH.csv', folder);
            r = SemilogDerivativeResidueCalculator(app.data_curve, app.modeled_curve).get_residue();
            names(end+1, 1) = ExportDialogUtils.write_residual_csv(app, r, 'anh_residual_dMdlnH.csv', folder);
        end

        function name = write_residual_csv(app, residue, base_name, folder)
            file_name = ExportDialogUtils.export_filename(app, base_name);
            ExportUtils.write_columns_csv(fullfile(folder, file_name), ...
                {'H [A/m]', 'residue'}, {app.data_curve.H, residue});
            name = string(file_name);
        end

        function names = export_ja_parameters(app, folder)
            [p, ok] = app.get_ja_params_from_tab();
            if ~ok
                error('MagAnalyst:export', 'Jiles-Atherton parameters are not valid.');
            end
            [Htip, Mtip, tip_ok] = app.get_ja_tip_from_tab_or_data();
            % Mass-magnetization awareness (see DisplayUnits): Ms/alpha and
            % the tip magnetization switch to sigma-side labels when the
            % imported vertical axis was mass magnetization. a, k (both A/m)
            % and c (dimensionless) are unaffected.
            if app.M_is_mass_based
                Ms_lbl = "sigma_s [Am^2/kg]";
                alpha_lbl = "rho*alpha [kg/m^3]";
                Mtip_lbl = "sigma_tip [Am^2/kg]";
            else
                Ms_lbl = "Ms [A/m]";
                alpha_lbl = "alpha";
                Mtip_lbl = "Mtip [A/m]";
            end
            nl = newline;
            lines = "JILES-ATHERTON HYSTERESIS FIT";
            lines = lines + nl + "=============================";
            lines = lines + nl + nl + "Model parameters";
            lines = lines + nl + "----------------";
            lines = lines + nl + sprintf("  %-18s = %14.6g", Ms_lbl, p.Ms);
            lines = lines + nl + sprintf("  %-18s = %14.6g", "a [A/m]", p.a);
            lines = lines + nl + sprintf("  %-18s = %14.6g", alpha_lbl, p.alpha);
            lines = lines + nl + sprintf("  %-18s = %14.6g", "k [A/m]", p.k);
            lines = lines + nl + sprintf("  %-18s = %14.6g", "c", p.c);
            if tip_ok
                lines = lines + nl + nl + "Tip point";
                lines = lines + nl + "---------";
                lines = lines + nl + sprintf("  %-18s = %14.6g", "Htip [A/m]", Htip);
                lines = lines + nl + sprintf("  %-18s = %14.6g", Mtip_lbl, Mtip);
            end

            % --- Fitting conditions ---
            lines = lines + nl + nl + "Fitting conditions";
            lines = lines + nl + "------------------";
            lines = lines + nl + sprintf("  %-18s = %s", "Starting point", ...
                strtrim(string(app.StartingpointDropDown_4.Value)));
            lines = lines + nl + sprintf("  %-18s = %s", "Fitting region", ...
                strtrim(string(app.FittingregionDropDown.Value)));
            lines = lines + nl + sprintf("  %-18s = %s", "Stop criterion", ...
                strtrim(string(app.StopcriterionDropDown_5.Value)));
            if strcmp(app.StopcriterionDropDown_5.Value, 'Fixed repetitions')
                % Need to find the repetitions field for Hysteretic -- it may not
                % be directly visible in the tab structure, so check if it exists.
                % For now, rely on the displayed value if available.
            end
            lines = lines + nl + sprintf("  %-18s = %s", "Error metric", ...
                strtrim(string(app.ErrortominimizeDropDown_2.Value)));
            bound_specs = { ...
                "Ms bounds",    app.MsLower_JA,    app.MsUpper_JA; ...
                "a bounds",     app.aLower_JA,     app.aUpper_JA; ...
                "alpha bounds", app.alphaLower_JA, app.alphaUpper_JA; ...
                "k bounds",     app.kLower_JA,     app.kUpper_JA; ...
                "c bounds",     app.cLower_JA,     app.cUpper_JA};
            for b = 1:size(bound_specs, 1)
                lo = ExportDialogUtils.format_bound(bound_specs{b, 2});
                hi = ExportDialogUtils.format_bound(bound_specs{b, 3});
                lines = lines + nl + sprintf("  %-18s = [%s, %s]", bound_specs{b, 1}, lo, hi);
            end

            err_name = strtrim(string(app.ErrortominimizeDropDown_2.Value));
            err_val = strtrim(string(app.ErrorDisplay_2.Value));
            if strlength(err_val) > 0
                lines = lines + nl + nl + "Fit error";
                lines = lines + nl + "---------";
                lines = lines + nl + sprintf("  %s = %s", err_name, err_val);
            end

            % --- Total elapsed time ---
            [~, ~, ~, ~, elapsed_time] = FitProgressUtils.get_history(app, 'hyst');
            if elapsed_time > 0
                lines = lines + nl + nl + "Total elapsed time";
                lines = lines + nl + "-------------------";
                lines = lines + nl + sprintf("  %g seconds", elapsed_time);
            end

            file_name = ExportDialogUtils.export_filename(app, 'ja_parameters.txt');
            ExportUtils.write_text(fullfile(folder, file_name), lines);
            names = string(file_name);
        end

        function names = export_ja_loop(app, folder)
            [H, M, has_model] = app.get_hysteretic_modeled_region();
            if ~has_model
                error('MagAnalyst:export', 'JA modeled loop is not available.');
            end
            file_name = ExportDialogUtils.export_filename(app, 'ja_modeled_loop.csv');
            ExportUtils.write_columns_csv(fullfile(folder, file_name), ...
                {'H [A/m]', 'M [A/m]'}, {H, M});
            names = string(file_name);
        end

        function base = playground_export_base(info)
            mode = "simulation";
            if isfield(info, 'mode')
                mode = PlaygroundUtils.normalize_mode_label(info.mode);
            end
            slug = lower(regexprep(char(mode), '\s+', '_'));
            base = "playground_" + string(slug);
        end

        function names = export_playground_modeled(app, folder)
            [H, M, has_data] = app.get_playground_data_curve();
            if ~has_data
                error('MagAnalyst:export', 'No Playground input curve is available.');
            end
            [H_label, M_label] = app.get_playground_axis_units();
            [H, M] = app.convert_playground_curve_units(H, M, "H [A/m]", "M [A/m]", H_label, M_label);
            mode_label = PlaygroundUtils.normalize_mode_label(PlaygroundUtils.get_mode(app));
            base = ExportDialogUtils.playground_export_base(struct('mode', mode_label)) + "_measured.csv";
            file_name = ExportDialogUtils.export_filename(app, char(base));
            ExportUtils.write_columns_csv(fullfile(folder, file_name), ...
                {char(H_label), char(M_label)}, {H, M});
            names = string(file_name);
        end

        function names = export_playground_curve(app, folder)
            [H, M, info, ok] = PlaygroundUtils.get_simulation_export(app);
            if ~ok
                error('MagAnalyst:export', 'No playground simulation is available.');
            end
            [H_label, M_label] = app.get_playground_axis_units();
            [H, M] = app.convert_playground_curve_units(H, M, "H [A/m]", "M [A/m]", H_label, M_label);
            base = ExportDialogUtils.playground_export_base(info) + "_simulation.csv";
            file_name = ExportDialogUtils.export_filename(app, char(base));
            ExportUtils.write_columns_csv(fullfile(folder, file_name), ...
                {char(H_label), char(M_label)}, {H, M});
            names = string(file_name);
        end

        function names = export_playground_info(app, folder)
            [~, ~, info, ok] = PlaygroundUtils.get_simulation_export(app);
            if ~ok
                error('MagAnalyst:export', 'No playground simulation is available.');
            end
            lines = "Playground simulation metadata:";
            [p, pok] = PlaygroundUtils.get_playground_params(app);
            if pok
                % Mass-magnetization awareness: Ms/alpha labels mirror the
                % Playground tab's JA panel (see DisplayUnits); a, k, c stay.
                if app.M_is_mass_based
                    Ms_lbl = "sigma_s [Am^2/kg]:";
                    alpha_lbl = "rho*alpha [kg/m^3]:";
                else
                    Ms_lbl = "Ms [A/m]:";
                    alpha_lbl = "alpha:";
                end
                lines = lines + newline + newline + "JA parameters:";
                lines = lines + newline + sprintf("%-20s\t%0.6g", Ms_lbl, p.Ms);
                lines = lines + newline + sprintf("%-20s\t%0.6g", "a [A/m]:", p.a);
                lines = lines + newline + sprintf("%-20s\t%0.6g", alpha_lbl, p.alpha);
                lines = lines + newline + sprintf("%-20s\t%0.6g", "k [A/m]:", p.k);
                lines = lines + newline + sprintf("%-20s\t%0.6g", "c:", p.c);
            end
            lines = lines + newline + newline + "Info:";
            fn = fieldnames(info);
            skip = {'status', 'message'};
            for i = 1:numel(fn)
                key = fn{i};
                if any(strcmp(key, skip))
                    continue;
                end
                val = info.(key);
                if ischar(val) || isstring(val)
                    lines = lines + newline + sprintf("%s: %s", key, string(val));
                elseif islogical(val) || (isnumeric(val) && isscalar(val))
                    lines = lines + newline + sprintf("%s: %g", key, double(val));
                elseif isnumeric(val) && ~isempty(val)
                    lines = lines + newline + sprintf("%s: [%s]", key, strjoin(string(val(:)'), ", "));
                end
            end
            base = ExportDialogUtils.playground_export_base(info) + "_info.txt";
            file_name = ExportDialogUtils.export_filename(app, char(base));
            ExportUtils.write_text(fullfile(folder, file_name), lines);
            names = string(file_name);
        end

        function names = export_axes_image(app, ax, base, folder, fmt)
            file_name = ExportDialogUtils.export_filename(app, char(string(base) + string(fmt)));
            ExportUtils.save_axes_image(ax, fullfile(folder, file_name), 400);
            names = string(file_name);
        end
    end
end
