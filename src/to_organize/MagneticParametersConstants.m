classdef MagneticParametersConstants
%MAGNETICPARAMETERSCONSTANTS  LOW_A/HIGH_A labels for a-root selection.
%   Mirrors FitConstants.LOW_A/HIGH_A; used by MagneticParameters.get_a to
%   pick which root of the a-parameter equation to use per component.

    properties
        LOW_A
        HIGH_A
    end

    methods
        function obj = MagneticParametersConstants()
            obj.LOW_A = 'low';
            obj.HIGH_A = 'high';
        end
    end
end