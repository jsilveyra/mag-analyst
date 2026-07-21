classdef FormatUtils
%FORMATUTILS  Shared display-formatting and axis-scale helpers.
%   Small, pure (app-independent) formatting/query helpers used by two or
%   more tabs, following the same static-class pattern as the tab *Utils
%   classes.

    methods (Static)
        function has_x = axis_scale_has_x(selection)
            selection = string(selection);
            has_x = selection == "semilog-x" || selection == "log-log";
        end

        function has_y = axis_scale_has_y(selection)
            selection = string(selection);
            has_y = selection == "semilog-y" || selection == "log-log";
        end

        function ret = format_short(v)
            string_value = char(sprintf("%0.4f",v));
            aux = regexp(string_value,'\.','split');
            aux{1} = fliplr(regexprep(fliplr(aux{1}),'\d{3}(?=\d)', '$0,'));
            ret = [aux{1},'.',aux{2}];
        end

        function ret = format_engineering(v)
            ret = char(sprintf("%0.4e",v));
        end

        function results = get_time_string()
            results = string(datetime(datetime, 'Format', 'yy/MM/dd HH:mm:ss'));
        end
    end
end
