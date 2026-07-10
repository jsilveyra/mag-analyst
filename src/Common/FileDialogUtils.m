classdef FileDialogUtils
%FILEDIALOGUTILS Static helpers for cancel-safe, portable file/folder dialogs.
%   Extracted from app_exported.m; shared by the Input tab's browse button,
%   the Output tab's browse button, and the Menus (Open/Save/Save As).

    methods (Static)
        function fullpath = safe_getfile(~, filter, startpath, dialog_title)
            if nargin < 4 || strlength(string(dialog_title)) == 0
                dialog_title = "Select file";
            end
            if nargin < 3 || strlength(string(startpath)) == 0
                startpath = pwd;
            end

            [file, path] = uigetfile(filter, char(dialog_title), char(startpath));

            if isequal(file,0) || isequal(path,0)
                fullpath = "";
                return;
            end

            fullpath = string(fullfile(path, file));
        end

        function fullpath = safe_putfile(~, filter, startpath, dialog_title, default_name)
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

            if isequal(file,0) || isequal(path,0)
                fullpath = "";
                return;
            end

            fullpath = string(fullfile(path, file));
        end

        function folder = safe_getdir(~, startpath, dialog_title)
            if nargin < 3 || strlength(string(dialog_title)) == 0
                dialog_title = "Select folder";
            end
            if nargin < 2 || strlength(string(startpath)) == 0
                startpath = pwd;
            end

            p = uigetdir(char(startpath), char(dialog_title));

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
            candidate = fullfile(base, "sampleData");
            if isfolder(candidate)
                folder = string(candidate);
            else
                folder = base;
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
