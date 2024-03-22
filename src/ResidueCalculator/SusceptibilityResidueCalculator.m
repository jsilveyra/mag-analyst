classdef SusceptibilityResidueCalculator < ResidueCalculator
    methods (Access = public)
        function obj = SusceptibilityResidueCalculator(data_curve, modeled_curve)
            obj.X = log(data_curve.H);
            obj.X(1) = 0;
            obj.Y = data_curve.dMdH;
            obj.Xhat = log(modeled_curve.H);
            obj.Xhat(1) = 0;
            obj.Yhat = modeled_curve.dMdH;
        end
    end
end