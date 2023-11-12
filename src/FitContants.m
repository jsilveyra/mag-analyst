classdef FitContants

    properties
        LOW_A
        HIGH_A
        HORIZONTAL_ERROR_TYPE
        VERTICAL_ERROR_TYPE
        DIAGONAL_ERROR_TYPE
    end

    methods
        function obj = FitContants()
            obj.LOW_A = 'low';
            obj.HIGH_A = 'high';
            obj.DIAGONAL_ERROR_TYPE = "Diagonal";
            obj.VERTICAL_ERROR_TYPE = "Vertical";
            obj.HORIZONTAL_ERROR_TYPE = "Horizontal";
        end
    end
end