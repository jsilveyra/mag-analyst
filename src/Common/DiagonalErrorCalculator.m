classdef DiagonalErrorCalculator < ErrorCalculator
%DIAGONALERRORCALCULATOR  Point-to-curve (perpendicular) fit error.
%   DiagonalErrorCalculator(H_data, M_data, H_model, M_model, use_log_h, use_continuous)
%   measures the normalized RMS perpendicular distance from each data point
%   to the modeled curve, in either the (logH, M) or (H, M) plane (see
%   ErrorCalculator). Each axis is normalized by its own data-derived
%   max(|value|) before the distance is computed (a stable, dataset-only
%   quantity comparable across curves of different physical scale/shape,
%   fixed throughout a given fit since it never depends on the model).
%   use_continuous=true uses distance2curve for a true point-to-curve
%   distance; false falls back to a per-point sampled approximation.
%   Reduction is RMS (sqrt(mean(d.^2))): independent of how densely the
%   curve is sampled, unlike a raw sum which shrinks as points are added.
    properties (Access = private)
        use_continuous
    end

    methods
        function obj = DiagonalErrorCalculator(H_data, M_data, H_model, M_model, use_log_h, use_continuous)
           if nargin < 5 || isempty(use_log_h)
               use_log_h = true;
           end
           if nargin < 6 || isempty(use_continuous)
               use_continuous = true;
           end
           obj = obj@ErrorCalculator(H_data, M_data, H_model, M_model, use_log_h);
           obj.use_continuous = use_continuous;
        end

        function e = get_error(obj)
            Xdat = obj.X;
            Ydat = obj.Y;
            Xmod = obj.Xhat;
            Ymod = obj.Yhat;
            [x_scale, y_scale] = obj.get_scales(Xdat, Ydat);

            if obj.use_continuous
                e = obj.get_continuous_error(Xdat, Ydat, Xmod, Ymod, x_scale, y_scale);
            else
                e = obj.get_sampled_error(Xdat, Ydat, Xmod, Ymod, x_scale, y_scale);
            end
        end
    end

    methods (Access = private)
        function [x_scale, y_scale] = get_scales(~, Xdat, Ydat)
            x_scale = max(abs(Xdat));
            y_scale = max(abs(Ydat));
            if x_scale <= 0 || ~isfinite(x_scale)
                x_scale = 1;
            end
            if y_scale <= 0 || ~isfinite(y_scale)
                y_scale = 1;
            end
        end

        function e = get_continuous_error(~, Xdat, Ydat, Xmod, Ymod, x_scale, y_scale)
            % Exact point-to-polyline distance. point_to_polyline_distance
            % (src/Common) computes the same quantity as
            % distance2curve(model, data, 'linear') (src/lib/distance2curve,
            % the reference implementation cited in the manuscript) to
            % rounding, in cache-sized chunks: ~3x faster on the ~1600-point
            % measured cycles fitted since 2026-09-19.
            model = [Xmod(:)/x_scale, Ymod(:)/y_scale];
            data = [Xdat(:)/x_scale, Ydat(:)/y_scale];

            distances = point_to_polyline_distance(data, model);
            distances = distances(~isnan(distances));
            if isempty(distances)
                e = inf;
                return;
            end
            e = sqrt(mean(distances.^2));
        end

        function e = get_sampled_error(~, Xdat, Ydat, Xmod, Ymod, x_scale, y_scale)
            e = DiagonalErrorCalculator.get_sampled_error_static(Xdat, Ydat, Xmod, Ymod, x_scale, y_scale);
        end
    end

    methods (Static, Access = private)
        function e = get_sampled_error_static(Xdat, Ydat, Xmod, Ymod, x_scale, y_scale)
            % Vectorized (2026-09-19; was a per-point loop with two interp1
            % calls each) and made safe for measured, non-resampled data:
            % interp1 needs strictly increasing sample grids, so both the
            % model (in Y) and the data (in X) are sorted and de-duplicated
            % before use. Same arithmetic as before, point for point.
            Xdat = Xdat(:); Ydat = Ydat(:);
            [Ymod_u, Xmod_u] = ErrorCalculator.sorted_unique(Ymod(:), Xmod(:));
            [Xdat_u, Ydat_u] = ErrorCalculator.sorted_unique(Xdat, Ydat);
            x_on_model = interp1(Ymod_u, Xmod_u, Ydat, 'linear', 'extrap');
            y_on_data = interp1(Xdat_u, Ydat_u, x_on_model, 'linear', 'extrap');

            delta_x = abs(x_on_model - Xdat)/x_scale;
            delta_y = abs(y_on_data - Ydat)/y_scale;
            % delta_y*cos(atan(delta_y/delta_x)) = delta_x*delta_y/hypot(delta_x, delta_y)
            % (the altitude of the right triangle with legs delta_x, delta_y)
            r = hypot(delta_x, delta_y);
            delta_o = zeros(size(r));
            nz = r > 0;
            delta_o(nz) = delta_x(nz).*delta_y(nz)./r(nz);
            e = sqrt(mean(delta_o.^2));
        end
    end
end
