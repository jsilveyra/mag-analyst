classdef VerticalErrorCalculator

    properties
        X
        Y
        Xhat
        Yhat
    end

    methods
        function obj = VerticalErrorCalculator(data_curve, modeled_curve)
           obj.X = log(data_curve.H);
           obj.Y = data_curve.M;
           obj.Xhat = log(modeled_curve.H);
           obj.Yhat = modeled_curve.M;
        end

        function v_error = get_error(obj)
            Yint = interp1(obj.Xhat, obj.Yhat, obj.X, 'linear', 'extrap');
            Yint = Yint(3:end);     %por qué quedaba iniciando en 3?
            Ydat = obj.Y(3:end);    %por qué quedaba iniciando en 3?
            v_error = 0;
            for i = 1:length(Yint)
                e = Ydat(i) - Yint(i);
                v_error = v_error + (e^2);
            end
            v_error = (sqrt(v_error)/max(obj.Y))/length(obj.Y);
        end
    end
end