classdef HorizontalErrorCalculator < ErrorCalculator

    methods
        function obj = HorizontalErrorCalculator(data_curve, modeled_curve)
           obj = obj@ErrorCalculator(data_curve, modeled_curve);
        end

        function e = get_error(obj)
            Xint = interp1(obj.Yhat, obj.Xhat, obj.Y, 'linear', 'extrap');
            Xint = Xint(1:end);
            Xdat = obj.X(1:end);
            e = 0;
            for i = 1:length(Xint)
                aux = Xdat(i) - Xint(i);
                e = e + (aux^2);
            end
            e = sqrt(e)/max(obj.X)/length(Xdat);
        end
    end
end