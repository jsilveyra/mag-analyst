classdef ErrorCalculator
    methods
        function obj = ErrorCalculator()
        end

        function d_error = diagonal_error(~, X, Y, Xhat, Yhat)
            Ydat = Y(2:end-1);
            Xdat = X(2:end-1);
            d_error = 0;
            for i = 1:length(Ydat)
                delta_x = abs(interp1(Yhat, Xhat, Ydat(i)) - Xdat(i))/max(X);
                delta_y = abs(interp1(X, Y, interp1(Yhat, Xhat, Ydat(i))) - Ydat(i))/max(Y);
                delta_o = delta_y*cos(atan(delta_y/delta_x));
                d_error = d_error + (delta_o^2);
            end
            d_error = sqrt(d_error)/length(Y);
        end

        function residue = residue(~, X, Y, Xhat, Yhat)
            Yint = interp1(Xhat, Yhat, X);
            Yint = Yint(3:end);
            Ydat = Y(3:end);
            residue = zeros(1, length(Ydat));
            for i = 1:length(Yint)
                residue(i) = Ydat(i) - Yint(i);
            end
        end
    end
end