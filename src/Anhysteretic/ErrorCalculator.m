classdef ErrorCalculator
%ERRORCALCULATOR  Abstract base class for anhysteretic-fit objective functions.
%   ErrorCalculator(data_curve, modeled_curve) stores log(H)/M pairs (for
%   H>0) from both curves in X/Y (data) and Xhat/Yhat (model). Subclasses
%   (DiagonalErrorCalculator, HorizontalErrorCalculator,
%   VerticalErrorCalculator) implement get_error() to define the scalar
%   error minimized by fit.m.

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