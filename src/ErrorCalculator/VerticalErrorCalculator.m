classdef VerticalErrorCalculator < ErrorCalculator

    methods
        function obj = VerticalErrorCalculator(data_curve, modeled_curve)
            obj = obj@ErrorCalculator(data_curve, modeled_curve);
        end

        function e = get_error(obj)
            Yint = interp1(obj.Xhat, obj.Yhat, obj.X, 'linear', 'extrap');
            e = sqrt(sum((obj.Y - Yint).^2)) / max(obj.Y) / length(obj.Y);
        end
    end
end
