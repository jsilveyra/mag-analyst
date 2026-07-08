classdef FileDialogUtils
%FILEDIALOGUTILS Static helpers for cancel-safe, portable file/folder dialogs.
%   Extracted from app_exported.m; shared by the Input tab's browse button,
%   the Output tab's browse button, and the Menus (Open/Save/Save As).

    methods (Static)
        function fullpath = safe_getfile(~, filter, startpath, dialogTitle)
            if nargin < 4 || strlength(string(dialogTitle)) == 0
                dialogTitle = "Select file";
            end
            if nargin < 3 || strlength(string(startpath)) == 0
                startpath = pwd;
            end

            [file, path] = uigetfile(filter, char(dialogTitle), char(startpath));

            if isequal(file,0) || isequal(path,0)
                fullpath = "";
                return;
            end

            fullpath = string(fullfile(path, file));
        end

        function fullpath = safe_putfile(~, filter, startpath, dialogTitle, defaultName)
            if nargin < 5
                defaultName = "";
            end
            if nargin < 4 || strlength(string(dialogTitle)) == 0
                dialogTitle = "Save file";
            end
            if nargin < 3 || strlength(string(startpath)) == 0
                startpath = pwd;
            end

            if strlength(string(defaultName)) > 0
                startpath = fullfile(startpath, char(defaultName));
            end

            [file, path] = uiputfile(filter, char(dialogTitle), char(startpath));

            if isequal(file,0) || isequal(path,0)
                fullpath = "";
                return;
            end

            fullpath = string(fullfile(path, file));
        end

        function folder = safe_getdir(~, startpath, dialogTitle)
            if nargin < 3 || strlength(string(dialogTitle)) == 0
                dialogTitle = "Select folder";
            end
            if nargin < 2 || strlength(string(startpath)) == 0
                startpath = pwd;
            end

            p = uigetdir(char(startpath), char(dialogTitle));

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

        function ensure_folder(~, folder)
            if strlength(string(folder)) == 0
                return;
            end
            if ~isfolder(folder)
                mkdir(folder);
            end
        end
    end
end
