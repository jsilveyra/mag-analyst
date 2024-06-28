classdef VerticalErrorCalculator < ErrorCalculator

    methods
        function obj = VerticalErrorCalculator(data_curve, modeled_curve)
            obj = obj@ErrorCalculator(data_curve, modeled_curve);
        end

        function e = get_error(obj)
            Yint = interp1(obj.Xhat, obj.Yhat, obj.X, 'linear', 'extrap');
            Yint = Yint(1:end);
            Ydat = obj.Y(1:end);
            e = 0;
            for i = 1:length(Yint)
                aux = Ydat(i) - Yint(i);
                e = e + (aux^2);
            end
            e = (sqrt(e)/max(obj.Y))/length(obj.Y);
        end
    end
end