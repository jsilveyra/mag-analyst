classdef ExportUtils
%EXPORTUTILS Low-level, app-agnostic export writers for MagAnalyst.
%
%   Static helpers that centralize the actual file-IO used by the unified
%   Export dialog (see app_exported.m: open_export_dialog / do_export). They
%   take plain arrays / tables / axes handles only — no access to private app
%   state — so they live in a standalone src/ file and never need to be
%   hand-ported into App Designer.
%
%   Conventions kept identical to the legacy Output-data-tab callbacks:
%     - CSV curves are written with a ';' delimiter via writetable.
%     - Plot images are rasterised with exportgraphics at 400 dpi (png) or
%       written as vector graphics (pdf/svg).

    methods (Static)
        function write_columns_csv(path, var_names, columns)
            %WRITE_COLUMNS_CSV Write equal-length numeric columns to a ';' CSV.
            %   var_names : cellstr of column headers (may contain spaces/units).
            %   columns  : cell array of numeric vectors, all the same length.
            data = zeros(numel(columns{1}), numel(columns));
            for j = 1:numel(columns)
                col = columns{j};
                data(:, j) = col(:);
            end
            t = array2table(data);
            t.Properties.VariableNames = var_names;   % arbitrary headers preserved
            writetable(t, path, 'Delimiter', ';');
        end

        function write_table_csv(t, path)
            %WRITE_TABLE_CSV Write a pre-built table to a ';' CSV.
            %   Used when the caller needs custom table shaping (e.g. the
            %   per-component split of the modeled anhysteretic curve).
            writetable(t, path, 'Delimiter', ';');
        end

        function write_text(path, content)
            %WRITE_TEXT Write a string/char (or string array, one line each).
            file = fopen(path, 'w', 'n', 'UTF-8');   % UTF-8 so symbols survive
            if file == -1
                error('ExportUtils:write_text', 'Could not open %s for writing.', path);
            end
            cleanup = onCleanup(@() fclose(file));
            if isstring(content) && numel(content) > 1
                content = strjoin(content, newline);
            end
            fprintf(file, "%s", string(content));
        end

        function save_axes_image(ax, path, resolution)
            %SAVE_AXES_IMAGE Export an axes to png/pdf/svg.
            if nargin < 3 || isempty(resolution)
                resolution = 400;
            end
            [~, ~, ext] = fileparts(path);
            ext = lower(string(ext));
            if ismember(ext, [".pdf", ".svg", ".eps"])
                exportgraphics(ax, path, 'ContentType', 'vector');
            else
                exportgraphics(ax, path, 'Resolution', resolution);
            end
        end

        function name = safe_base_name(name, fallback)
            %SAFE_BASE_NAME Sanitise a user/base file name (no extension).
            name = strtrim(string(name));
            if strlength(name) == 0
                name = string(fallback);
            end
            name = regexprep(name, '[<>:"/\\|?*]', '_');   % strip path-illegal chars
        end
    end
end
