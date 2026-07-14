classdef FormatUtils
%FORMATUTILS  Shared display-formatting and axis-scale helpers.
%   Extracted 2026-07-13 from app_exported.m: small, pure (app-independent)
%   formatting/query helpers used by 2+ tabs, mirroring the *Utils pattern.
%   format_long and format_thousands_only currently have no callers anywhere
%   in the app; kept available rather than deleted since removing them was
%   not asked for.

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

        function ret = format_long(v)
            string_value = char(sprintf("%0.10f",v));
            aux = regexp(string_value,'\.','split');
            aux{1} = fliplr(regexprep(fliplr(aux{1}),'\d{3}(?=\d)', '$0,'));
            ret = [aux{1},'.',aux{2}];
        end

        function ret = format_engineering(v)
            ret = char(sprintf("%0.4e",v));
        end

        function ret = format_thousands_only(v)
            string_value = char(sprintf("%d",round(v)));
            ret = fliplr(regexprep(fliplr(string_value),'\d{3}(?=\d)', '$0,'));
        end

        function results = get_time_string()
            results = string(datetime(datetime, 'Format', 'yy/MM/dd HH:mm:ss'));
        end
    end
end
