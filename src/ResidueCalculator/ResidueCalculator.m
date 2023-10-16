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
            Yint = Yint(3:end);
            Ydat = obj.Y(3:end);
            residue = zeros(1, length(Ydat));
            for i = 1:length(Yint)
                residue(i) = Ydat(i) - Yint(i);
            end
        end
    end
end