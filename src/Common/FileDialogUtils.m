classdef FileDialogUtils
%FILEDIALOGUTILS Static helpers for cancel-safe, portable file/folder dialogs.
%   Shared by the Input tab's browse button, the Export dialog, and the
%   Project menu (Open / Save / Save As).
%
%   uigetfile/uiputfile/uigetdir open native OS dialogs, which take the
%   keyboard focus away from the app window and do not give it back when
%   they close. Each wrapper below therefore calls restore_focus(app) on
%   every exit path, so the app stays foremost whether the user confirms
%   or cancels.
%
%   When the browse button lives in a secondary window (e.g. the Export
%   dialog's own uifigure) rather than the main window, pass that figure
%   as the last argument (focus_target) so focus returns to *it* instead
%   of the main window, which would otherwise cover the dialog.

    methods (Static)
        function fullpath = safe_getfile(app, filter, startpath, dialog_title, focus_target)
            if nargin < 5
                focus_target = [];
            end
            if nargin < 4 || strlength(string(dialog_title)) == 0
                dialog_title = "Select file";
            end
            if nargin < 3 || strlength(string(startpath)) == 0
                startpath = pwd;
            end

            [file, path] = uigetfile(filter, char(dialog_title), char(startpath));
            FileDialogUtils.restore_focus(app, focus_target);

            if isequal(file,0) || isequal(path,0)
                fullpath = "";
                return;
            end

            fullpath = string(fullfile(path, file));
        end

        function fullpath = safe_putfile(app, filter, startpath, dialog_title, default_name, focus_target)
            if nargin < 6
                focus_target = [];
            end
            if nargin < 5
                default_name = "";
            end
            if nargin < 4 || strlength(string(dialog_title)) == 0
                dialog_title = "Save file";
            end
            if nargin < 3 || strlength(string(startpath)) == 0
                startpath = pwd;
            end

            if strlength(string(default_name)) > 0
                startpath = fullfile(startpath, char(default_name));
            end

            [file, path] = uiputfile(filter, char(dialog_title), char(startpath));
            FileDialogUtils.restore_focus(app, focus_target);

            if isequal(file,0) || isequal(path,0)
                fullpath = "";
                return;
            end

            fullpath = string(fullfile(path, file));
        end

        function folder = safe_getdir(app, startpath, dialog_title, focus_target)
            if nargin < 4
                focus_target = [];
            end
            if nargin < 3 || strlength(string(dialog_title)) == 0
                dialog_title = "Select folder";
            end
            if nargin < 2 || strlength(string(startpath)) == 0
                startpath = pwd;
            end

            p = uigetdir(char(startpath), char(dialog_title));
            FileDialogUtils.restore_focus(app, focus_target);

            if isequal(p,0)
                folder = "";
            else
                folder = string(p);
            end
        end

        function folder = default_data_folder(app)
            base = "";
            if ~isempty(app.AppRoot)
                candidate = fullfile(app.AppRoot, "data");
                if isfolder(candidate)
                    base = candidate;
                end
            end

            if strlength(string(base)) == 0
                base = fullfile(pwd, "data");
            end

            folder = string(base);
        end

        function folder = default_import_folder(app)
            base = FileDialogUtils.default_data_folder(app);
            candidate = fullfile(base, "sample_data");
            if isfolder(candidate)
                folder = string(candidate);
            else
                folder = base;
            end
        end

        function folder = default_project_folder(app)
            % Default target for the Open/Save/Save-as project dialogs:
            % <AppRoot>/data/projects. Returned even if it does not exist yet
            % (mkdir'd on demand by ensure_folder before Save/Save-as offers it).
            base = FileDialogUtils.default_data_folder(app);
            folder = string(fullfile(base, "projects"));
        end

        function folder = default_export_folder(app)
            % Default target for the Export... dialog: <AppRoot>/data/exported_data.
            % Returned even if it does not exist yet (the dialog creates it on
            % export via ensure_folder).
            base = FileDialogUtils.default_data_folder(app);
            folder = string(fullfile(base, "exported_data"));
        end

        function restore_focus(app, focus_target)
            %RESTORE_FOCUS Bring the app back to the front after a native OS
            %   dialog stole the focus. Raises focus_target (a secondary
            %   window such as the Export dialog's uifigure) when one is
            %   given and still alive, otherwise the main app window --
            %   raising the main window from a secondary window's browse
            %   button would bury that window behind it. Silently does
            %   nothing when called without a live app (e.g. from a
            %   command-line script).
            if nargin >= 2 && ~isempty(focus_target) && isvalid(focus_target)
                figure(focus_target);
                return;
            end

            if isobject(app) && isvalid(app) && isprop(app, 'MagAnalystUIFigure') ...
                    && ~isempty(app.MagAnalystUIFigure) && isvalid(app.MagAnalystUIFigure)
                figure(app.MagAnalystUIFigure);
            end
        end

        function ensure_folder(~, folder)
            if strlength(string(folder)) == 0
                return;
            end
            if ~isfolder(folder)
                mkdir(folder);
            end
        end

        function write_dataset_not_found_message(app, path)
            path = string(path);
            if strlength(path) == 0
                app.write_message("No dataset path specified. Please browse for a dataset.");
            else
                app.write_message("Dataset """ + path + """ was not found, please browse for it again.");
            end
        end
    end
end
