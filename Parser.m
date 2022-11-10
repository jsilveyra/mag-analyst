classdef Parser

    properties
        FilePath
    end

    methods (Access = public)
        function obj = Parser(file_path)
            obj.FilePath = file_path;
        end

        function [H, M] = get_data(obj)
            raw_data = fileread(obj.FilePath);
            data = splitlines(raw_data);
            data = data(2:end);

            H = zeros(1, length(data));
            M = zeros(1, length(data));
            for i = 1 : length(data)
                [H(i), M(i)] = obj.parse_line(data(i));
            end
        end
    end
    
    methods (Access = private)

        function [H, M] = parse_line(~, line)
            line = regexprep(line, '\t', ' ');
            line = regexprep(line, ',', '');
            line = regexprep(line,' +',' ');
            line = strtrim(line);
            line = string(line);
            line = split(line, ' ');
            point = arrayfun(@(l) double(l),line);
            H = point(1);
            M = point(2);
        end
    end
end