classdef SusceptibilityResidueCalculator < ResidueCalculator
    methods (Access = public)
        function obj = SusceptibilityResidueCalculator(data_curve, modeled_curve)
            obj.X = log(data_curve.H(data_curve.H>0));
            obj.X = [0 obj.X];
            obj.Y = data_curve.dMdH(data_curve.H>0);
            obj.Y = [0 obj.Y];
            obj.Xhat = log(modeled_curve.H(modeled_curve.H>0));
            obj.Xhat(1) = 0;
            obj.Yhat = modeled_curve.dMdH(modeled_curve.H>0);
        end
    end
end