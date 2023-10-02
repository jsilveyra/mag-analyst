classdef DiagonalErrorCalculator

    properties
        X
        Y
        Xhat
        Yhat
    end

    methods
        function obj = DiagonalErrorCalculator(data_curve, modeled_curve)
           obj.X = log(data_curve.H);
           obj.Y = data_curve.M;
           obj.Xhat = log(modeled_curve.H);
           obj.Yhat = modeled_curve.M;
        end

        function d_error = get_error(obj)
            Ydat = obj.Y(2:end-1);
            Xdat = obj.X(2:end-1);
            d_error = 0;
            for i = 1:length(Ydat)
                delta_x = abs(interp1(obj.Yhat, obj.Xhat, Ydat(i), 'linear', 'extrap') - Xdat(i))/max(obj.X);
                delta_y = abs(interp1(obj.X, obj.Y, interp1(obj.Yhat, obj.Xhat, Ydat(i), 'linear', 'extrap'), 'linear', 'extrap') - Ydat(i))/max(obj.Y);
                delta_o = delta_y*cos(atan(delta_y/delta_x));
                d_error = d_error + (delta_o^2);
            end
            d_error = sqrt(d_error)/length(obj.Y);
        end
    end
end