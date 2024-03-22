classdef SemilogDerivativeResidueCalculator < ResidueCalculator
    methods (Access = public)
        function obj = SemilogDerivativeResidueCalculator(data_curve, modeled_curve)
            obj.X = log(data_curve.H);
            obj.X(1) = 0;
            obj.Y = data_curve.HdMdH;
            obj.Xhat = log(modeled_curve.H);
            obj.Xhat(1) = 0;
            obj.Yhat = modeled_curve.HdMdH;
        end
    end
end