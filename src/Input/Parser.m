classdef Parser
%PARSER  Import and unit-convert measured M(H) data from a CSV file.
%   Parser(file_path, H_unit, M_unit, curve_type, number_points).import()
%   reads a two-column CSV, converts H/M to base SI units (A/m) via
%   UnitConvertor, then reshapes/resamples the curve via CurveConvertor
%   according to curve_type. Returns [H, M, H_raw, M_raw]. Supported units
%   and curve types are enumerated in ParserConstants.

    properties
        FilePath
        H_unit
        M_unit
        curve_type
        number_points
    end

    methods (Access = public)
        function obj = Parser(file_path, H_unit, M_unit, curve_type, number_points)
            obj.FilePath = file_path;
            obj.H_unit = H_unit;
            obj.M_unit = M_unit;
            obj.curve_type = curve_type;
            if nargin < 5 || isempty(number_points)
                number_points = 50;
            end
            obj.number_points = number_points;
        end

        function [H, M, H_raw, M_raw] = import(obj)
            T = readtable(obj.FilePath,"VariableNamingRule","preserve");
            A = table2array(T);
            H_raw = transpose(A(:,1));
            M_raw = transpose(A(:,2));
            [H, M] = UnitConvertor().convert_H_M(H_raw, obj.H_unit, M_raw, obj.M_unit);
            [H, M] = CurveConvertor().convert_curve(H, M, obj.curve_type, obj.number_points);
        end
    end
end
