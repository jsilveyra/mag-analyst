classdef HorizontalErrorCalculator

    properties
        X
        Y
        Xhat
        Yhat
    end

    methods
        function obj = HorizontalErrorCalculator(data_curve, modeled_curve)
           obj.X = log(data_curve.H);
           obj.Y = data_curve.M;
           obj.Xhat = log(modeled_curve.H);
           obj.Yhat = modeled_curve.M;
        end

        function h_error = get_error(obj)
            Xint = interp1(obj.Yhat, obj.Xhat, obj.Y, 'linear', 'extrap');
            Xint = Xint(2:end);
            Xdat = obj.X(2:end);
            h_error = 0;
            for i = 1:length(Xint)
                e = Xdat(i) - Xint(i);
                h_error = h_error + (e^2);
            end
            h_error = sqrt(h_error)/max(obj.X)/length(Xdat);
        end
    end
end