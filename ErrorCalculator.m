classdef ErrorCalculator
    methods (Access = public)
        function obj = ErrorCalculator()
        end

        function e = get_error(obj, X, Y, Xhat, Yhat, error_type)
            switch error_type
                case "Diagonal"
                    e = obj.diagonal_error(X, Y, Xhat, Yhat);
                case "Vertical"
                    e = obj.vertical_error(X, Y, Xhat, Yhat);
                case "Horizontal"
                    e = obj.horizontal_error(X, Y, Xhat, Yhat);
            end
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

    methods (Access = private)
        function d_error = diagonal_error(~, X, Y, Xhat, Yhat)
            X = X(2:end);
            Y = Y(2:end);
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

        function v_error = vertical_error(~, X, Y, Xhat, Yhat)
            Yint = interp1(Xhat, Yhat, X);
            Yint = Yint(3:end);
            Ydat = Y(3:end);
            v_error = 0;
            for i = 1:length(Yint)
                e = Ydat(i) - Yint(i);
                v_error = v_error + (e^2);
            end
            v_error = (sqrt(v_error)/max(Y))/length(Y);
        end

        function h_error = horizontal_error(~, X, Y, Xhat, Yhat)
            Xint = interp1(Yhat, Xhat, Y);
            Xint = Xint(2:end);
            Xdat = X(2:end);
            h_error = 0;
            for i = 1:length(Xint)
                e = Xdat(i) - Xint(i);
                h_error = h_error + (e^2);
            end
            h_error = sqrt(h_error)/max(X)/length(Xdat);
        end
    end
end