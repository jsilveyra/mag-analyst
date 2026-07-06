classdef ResidueCalculator
%RESIDUECALCULATOR  Base class for per-point fit residuals.
%   Holds X, Y (data) and Xhat, Yhat (model) sample arrays. get_residue()
%   interpolates the model onto the data's X values and returns Y - Yint,
%   the pointwise residual used by ResiduePlotter. Subclasses
%   (Magnetization/Susceptibility/SemilogDerivative/HystereticLeftBranch)
%   populate X/Y/Xhat/Yhat for a specific curve quantity.
    properties
        X
        Y
        Xhat
        Yhat
    end

    methods (Access = public)
        function residue = get_residue(obj)
            Yint = interp1(obj.Xhat, obj.Yhat, obj.X, 'linear', 'extrap');
            Yint = Yint(1:end);
            Ydat = obj.Y(1:end);
            residue = zeros(1, length(Ydat));
            for i = 1:length(Yint)
                residue(i) = Ydat(i) - Yint(i);
            end
        end
    end
end