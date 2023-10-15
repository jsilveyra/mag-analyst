classdef Parser

    properties
        FilePath
        H_unit
        M_unit
        curve_type
    end

    methods (Access = public)
        function obj = Parser(file_path, H_unit, M_unit, curve_type)
            obj.FilePath = file_path;
            obj.H_unit = H_unit;
            obj.M_unit = M_unit;
            obj.curve_type = curve_type;
        end

        function [H, M, H_raw, M_raw] = import(obj)
            T = readtable(obj.FilePath,"VariableNamingRule","preserve");
            A = table2array(T);
            H_raw = transpose(A(:,1));
            M_raw = transpose(A(:,2));
            [H, M] = UnitConvertor().convert_H_M(H_raw, obj.H_unit, M_raw, obj.M_unit);
            [H, M] = CurveConvertor().convert_curve(H, M, obj.curve_type);
        end
    end
end