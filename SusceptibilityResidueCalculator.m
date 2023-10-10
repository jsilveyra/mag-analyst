classdef SusceptibilityResidueCalculator < ResidueCalculator
    methods (Access = public)
        function obj = SusceptibilityResidueCalculator(data_curve, modeled_curve)
            obj.X = log(data_curve.H);
            obj.Y = data_curve.dMdH;
            obj.Xhat = log(modeled_curve.H);
            obj.Yhat = modeled_curve.dMdH;
        end
    end
end