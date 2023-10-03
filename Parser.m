classdef Parser

    properties
        FilePath
    end

    methods (Access = public)
        function obj = Parser(file_path)
            obj.FilePath = file_path;
        end

        function [X, Y] = get_data_csv(obj)
            T = readtable(obj.FilePath,"VariableNamingRule","preserve");
            A = table2array(T);
            X = transpose(A(:,1));
            Y = transpose(A(:,2));
        end
    end
end