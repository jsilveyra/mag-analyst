classdef MagneticParametersConstants

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