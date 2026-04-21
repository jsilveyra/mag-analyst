classdef HorizontalErrorCalculator < ErrorCalculator

    methods
        function obj = HorizontalErrorCalculator(data_curve, modeled_curve)
           obj = obj@ErrorCalculator(data_curve, modeled_curve);
        end

        function e = get_error(obj)
            Xint = interp1(obj.Yhat, obj.Xhat, obj.Y, 'linear', 'extrap');
            e = sqrt(sum((obj.X - Xint).^2)) / max(obj.X) / length(obj.X);
        end
    end
end
