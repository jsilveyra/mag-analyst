classdef ErrorCalculator

    properties
        X
        Y
        Xhat
        Yhat
    end

    methods (Abstract)
        e = get_error(obj);
    end
    
    methods (Access = public)

        function obj = ErrorCalculator(data_curve, modeled_curve)
           obj.X = log(data_curve.H);
           obj.Y = data_curve.M;
           obj.Xhat = log(modeled_curve.H);
           obj.Yhat = modeled_curve.M;
        end

        function residue = residue(obj)
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