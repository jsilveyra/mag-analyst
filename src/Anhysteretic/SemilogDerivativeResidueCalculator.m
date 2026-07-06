classdef SemilogDerivativeResidueCalculator < ResidueCalculator
%SEMILOGDERIVATIVERESIDUECALCULATOR  Residual of H*dM/dH vs. log(H).
%   SemilogDerivativeResidueCalculator(data_curve, modeled_curve) sets
%   X/Xhat to log(H) (H>0, with a prepended 0) and Y/Yhat to HdMdH, for use
%   by the base class's get_residue().
    methods (Access = public)
        function obj = SemilogDerivativeResidueCalculator(data_curve, modeled_curve)
            obj.X = log(data_curve.H(data_curve.H>0));
            obj.X = [0 obj.X];
            obj.Y = data_curve.HdMdH(data_curve.H>0);
            obj.Y = [0 obj.Y];
            obj.Xhat = log(modeled_curve.H(modeled_curve.H>0));
            obj.Xhat = [0 obj.Xhat];
            obj.Yhat = modeled_curve.HdMdH(modeled_curve.H>0);
			obj.Yhat = [0 obj.Yhat];
        end
    end
end