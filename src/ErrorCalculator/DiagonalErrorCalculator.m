classdef DiagonalErrorCalculator < ErrorCalculator

    methods
        function obj = DiagonalErrorCalculator(data_curve, modeled_curve)
           obj = obj@ErrorCalculator(data_curve, modeled_curve);
        end

        function e = get_error(obj)
            obj.X = obj.X(1:end);
            obj.Y = obj.Y(1:end);
%             Ydat = obj.Y(1:end-1);    % it was not necessary to remove last element; it is better to add the if && structure. Clean code!!
%             Xdat = obj.X(1:end-1);
            Ydat = obj.Y(1:end);
            Xdat = obj.X(1:end);

            e = 0;
            for i = 1:length(Ydat)
                delta_x = abs(interp1(obj.Yhat, obj.Xhat, Ydat(i), 'linear', 'extrap') - Xdat(i))/max(obj.X);
                delta_y = abs(interp1(obj.X, obj.Y, interp1(obj.Yhat, obj.Xhat, Ydat(i), 'linear', 'extrap'), 'linear', 'extrap') - Ydat(i))/max(obj.Y);
                if (delta_x == 0) && (delta_y == 0)
                    delta_o = 0;
                else
                    delta_o = delta_y*cos(atan(delta_y/delta_x));
                end
                e = e + (delta_o^2);
            end
            e = sqrt(e)/length(obj.Y);
        end
    end
end