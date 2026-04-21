classdef VerticalErrorCalculator < ErrorCalculator

    methods
        function obj = VerticalErrorCalculator(data_curve, modeled_curve)
            obj = obj@ErrorCalculator(data_curve, modeled_curve);
        end

        function e = get_error(obj)
            Yint = interp1(obj.Xhat, obj.Yhat, obj.X, 'linear', 'extrap');
            y_max = max(obj.Y);
            if y_max == 0, y_max = 1; end
            e = sqrt(sum((obj.Y - Yint).^2)) / y_max / length(obj.Y);
        end
    end
end
