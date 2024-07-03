classdef MagnetizationResidueCalculator < ResidueCalculator
    methods (Access = public)
        function obj = MagnetizationResidueCalculator(data_curve, modeled_curve)
            clc
            obj.X = log(data_curve.H(data_curve.H>0));
            obj.X = [0 obj.X];
            obj.Y = data_curve.M(data_curve.H>0);
            obj.Y = [0 obj.Y];

            obj.Xhat = log(modeled_curve.H(modeled_curve.H>0));
            obj.Yhat = modeled_curve.M(modeled_curve.H>0);
        end
    end
end