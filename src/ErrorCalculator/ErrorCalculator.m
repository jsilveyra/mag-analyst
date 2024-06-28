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
           obj.X = log(data_curve.H(data_curve.H>0)); % consider only values above 0 because log(0)=-inf
           obj.Y = data_curve.M(data_curve.H>0);
           obj.Xhat = log(modeled_curve.H(modeled_curve.H>0));
           obj.Yhat = modeled_curve.M(modeled_curve.H>0);
        end
    end
end