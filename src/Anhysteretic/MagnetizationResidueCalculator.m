classdef MagnetizationResidueCalculator < ResidueCalculator
%MAGNETIZATIONRESIDUECALCULATOR  Residual of M vs. log(H).
%   MagnetizationResidueCalculator(data_curve, modeled_curve) sets X/Xhat to
%   log(H) (H>0, with a prepended 0) and Y/Yhat to M, for use by the base
%   class's get_residue().
    methods (Access = public)
        function obj = MagnetizationResidueCalculator(data_curve, modeled_curve)
            % clc
            obj.X = log(data_curve.H(data_curve.H>0));
            obj.X = [0 obj.X];
            obj.Y = data_curve.M(data_curve.H>0);
            obj.Y = [0 obj.Y];

            obj.Xhat = log(modeled_curve.H(modeled_curve.H>0));
			obj.Xhat = [0 obj.Xhat];
            obj.Yhat = modeled_curve.M(modeled_curve.H>0);
			obj.Yhat = [0 obj.Yhat];
        end
    end
end