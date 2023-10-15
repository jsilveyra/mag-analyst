classdef MagnetizationResidueCalculator < ResidueCalculator
    methods (Access = public)
        function obj = MagnetizationResidueCalculator(data_curve, modeled_curve)
            obj.X = log(data_curve.H);
            obj.Y = data_curve.M;
            obj.Xhat = log(modeled_curve.H);
            obj.Yhat = modeled_curve.M;
        end
    end
end