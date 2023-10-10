classdef ErrorCalculator

    properties
        X
        Y
        Xhat
        Yhat
    end

    methods (Abstract)
        e = get_error(obj);
    end
    
    methods (Access = public)
        function obj = ErrorCalculator(data_curve, modeled_curve)
           obj.X = log(data_curve.H);
           obj.Y = data_curve.M;
           obj.Xhat = log(modeled_curve.H);
           obj.Yhat = modeled_curve.M;
        end
    end
end