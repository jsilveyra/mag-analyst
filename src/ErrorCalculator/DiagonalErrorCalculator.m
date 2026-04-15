classdef DiagonalErrorCalculator < ErrorCalculator
    properties (Access = private)
        use_log_h
        use_continuous
    end

    methods
        function obj = DiagonalErrorCalculator(data_curve, modeled_curve, use_log_h, use_continuous)
           obj = obj@ErrorCalculator(data_curve, modeled_curve);
           if nargin < 3
               use_log_h = true;
           end
           if nargin < 4
               use_continuous = true;
           end
           obj.use_log_h = use_log_h;
           obj.use_continuous = use_continuous;
        end

        function e = get_error(obj)
            [Xdat, Ydat, Xmod, Ymod] = obj.get_plane_data();
            [x_scale, y_scale] = obj.get_scales(Xdat, Ydat);

            if obj.use_continuous
                e = obj.get_continuous_error(Xdat, Ydat, Xmod, Ymod, x_scale, y_scale);
            else
                e = obj.get_sampled_error(Xdat, Ydat, Xmod, Ymod, x_scale, y_scale);
            end
        end
    end

    methods (Access = private)
        function [Xdat, Ydat, Xmod, Ymod] = get_plane_data(obj)
            Ydat = obj.Y(:);
            Ymod = obj.Yhat(:);
            if obj.use_log_h
                Xdat = obj.X(:);
                Xmod = obj.Xhat(:);
            else
                Xdat = exp(obj.X(:));
                Xmod = exp(obj.Xhat(:));
            end
        end

        function [x_scale, y_scale] = get_scales(~, Xdat, Ydat)
            x_scale = max(Xdat);
            y_scale = max(Ydat);
            if x_scale == 0
                x_scale = 1;
            end
            if y_scale == 0
                y_scale = 1;
            end
        end

        function e = get_continuous_error(~, Xdat, Ydat, Xmod, Ymod, x_scale, y_scale)
            if exist('distance2curve', 'file') == 0
                warning('distance2curve not found in MATLAB path. Falling back to sampled diagonal error. Install it from https://la.mathworks.com/matlabcentral/fileexchange/34869-distance2curve');
                e = DiagonalErrorCalculator.get_sampled_error_static(Xdat, Ydat, Xmod, Ymod, x_scale, y_scale);
                return;
            end

            model = [Xmod/x_scale, Ymod/y_scale];
            data = [Xdat/x_scale, Ydat/y_scale];

            [~, distances] = distance2curve(model, data, 'linear');
            distances = distances(~isnan(distances));
            if isempty(distances)
                e = inf;
                return;
            end
            e = sqrt(sum(distances.^2))/length(distances);
        end

        function e = get_sampled_error(~, Xdat, Ydat, Xmod, Ymod, x_scale, y_scale)
            e = DiagonalErrorCalculator.get_sampled_error_static(Xdat, Ydat, Xmod, Ymod, x_scale, y_scale);
        end
    end

    methods (Static, Access = private)
        function e = get_sampled_error_static(Xdat, Ydat, Xmod, Ymod, x_scale, y_scale)
            e = 0;
            for i = 1:length(Ydat)
                x_on_model = interp1(Ymod, Xmod, Ydat(i), 'linear', 'extrap');
                y_on_data = interp1(Xdat, Ydat, x_on_model, 'linear', 'extrap');

                delta_x = abs(x_on_model - Xdat(i))/x_scale;
                delta_y = abs(y_on_data - Ydat(i))/y_scale;
                if (delta_x == 0) && (delta_y == 0)
                    delta_o = 0;
                else
                    delta_o = delta_y*cos(atan(delta_y/delta_x));
                end
                e = e + (delta_o^2);
            end
            e = sqrt(e)/length(Ydat);
        end
    end
end
