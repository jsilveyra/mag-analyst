classdef Parser

    properties
        FilePath
    end

    methods (Access = public)
        function obj = Parser(file_path)
            obj.FilePath = file_path;
        end

        function [X, Y] = get_data(obj)
            raw_data = fileread(obj.FilePath);
            data = splitlines(raw_data);
            data = data(2:end);

            X = zeros(1, length(data));
            Y = zeros(1, length(data));
            for i = 1 : length(data)
                [X(i), Y(i)] = obj.parse_line(data(i));
            end
        end

        function [X, Y] = get_data_csv(obj)
            T = readtable(obj.FilePath,"VariableNamingRule","preserve");
            A = table2array(T);
            X = transpose(A(:,1));
            Y = transpose(A(:,2));
        end
    end

    methods (Access = private)

        function [X, Y] = parse_line(~, line)
            line = regexprep(line, '\t', ' ');
            line = regexprep(line, ',', '');
            line = regexprep(line,' +',' ');
            line = strtrim(line);
            line = string(line);
            line = split(line, ' ');
            point = arrayfun(@(l) double(l),line);
            X = point(1);
            Y = point(2);
        end
    end
end