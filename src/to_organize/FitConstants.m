classdef FitConstants
%FITCONSTANTS  Enum-like string constants used by the anhysteretic fit UI/code.
%   LOW_A/HIGH_A select which root of the a-parameter equation
%   MagneticParameters uses per component. The ERROR_TYPE properties are the
%   labels (matching the app's dropdown) selecting which ErrorCalculator
%   subclass and H-scale/sampling mode fit.m uses; DIAGONAL_ERROR_TYPE is the
%   default alias for DIAGONAL_LOGH_CONTINUOUS_ERROR_TYPE.

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
