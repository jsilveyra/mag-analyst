classdef ResidueCalculator
    properties
        X
        Y
        Xhat
        Yhat
    end

    methods (Access = public)
        function residue = get_residue(obj)
            Yint = interp1(obj.Xhat, obj.Yhat, obj.X, 'linear', 'extrap');
            residue = obj.Y - Yint;
        end
    end
end
