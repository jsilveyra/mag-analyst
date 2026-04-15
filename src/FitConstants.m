classdef FitConstants

    properties
        LOW_A
        HIGH_A
        HORIZONTAL_ERROR_TYPE
        VERTICAL_ERROR_TYPE
        DIAGONAL_H_SAMPLED_ERROR_TYPE
        DIAGONAL_H_CONTINUOUS_ERROR_TYPE
        DIAGONAL_LOGH_SAMPLED_ERROR_TYPE
        DIAGONAL_LOGH_CONTINUOUS_ERROR_TYPE
        DIAGONAL_ERROR_TYPE
    end

    methods
        function obj = FitConstants()
            obj.LOW_A = 'low';
            obj.HIGH_A = 'high';
            obj.DIAGONAL_H_SAMPLED_ERROR_TYPE = "Diagonal (H, sampled)";
            obj.DIAGONAL_H_CONTINUOUS_ERROR_TYPE = "Diagonal (H, continuous)";
            obj.DIAGONAL_LOGH_SAMPLED_ERROR_TYPE = "Diagonal (logH, sampled)";
            obj.DIAGONAL_LOGH_CONTINUOUS_ERROR_TYPE = "Diagonal (logH, continuous)";
            obj.DIAGONAL_ERROR_TYPE = obj.DIAGONAL_LOGH_CONTINUOUS_ERROR_TYPE;
            obj.VERTICAL_ERROR_TYPE = "Vertical";
            obj.HORIZONTAL_ERROR_TYPE = "Horizontal";
        end
    end
end
