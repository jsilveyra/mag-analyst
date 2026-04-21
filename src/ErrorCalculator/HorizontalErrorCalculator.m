classdef HorizontalErrorCalculator < ErrorCalculator

    methods
        function obj = HorizontalErrorCalculator(data_curve, modeled_curve)
           obj = obj@ErrorCalculator(data_curve, modeled_curve);
        end

        function e = get_error(obj)
            Xint = interp1(obj.Yhat, obj.Xhat, obj.Y, 'linear', 'extrap');
            x_max = max(obj.X);
            if x_max == 0, x_max = 1; end
            e = sqrt(sum((obj.X - Xint).^2)) / x_max / length(obj.X);
        end
    end
end
