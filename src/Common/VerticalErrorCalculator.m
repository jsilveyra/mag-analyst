classdef VerticalErrorCalculator < ErrorCalculator
%VERTICALERRORCALCULATOR  Vertical (M-direction) fit error.
%   VerticalErrorCalculator(H_data, M_data, H_model, M_model, use_log_h)
%   interpolates the modeled curve's M at each data point's X (log H when
%   use_log_h, H otherwise -- see ErrorCalculator) and returns the
%   normalized RMS vertical offset between data and model:
%     e = sqrt(mean(residual.^2)) / max(|M_data|)
%   RMS makes e a per-point average independent of how densely the curve is
%   sampled (unlike a raw sum, which shrinks as more points are added to the
%   SAME curve); normalizing by the data's own peak |M| makes e a
%   dimensionless fraction of full-scale, comparable across curves of
%   different physical magnitude.

    methods
        function obj = VerticalErrorCalculator(H_data, M_data, H_model, M_model, use_log_h)
            if nargin < 5 || isempty(use_log_h)
                use_log_h = true;
            end
            obj = obj@ErrorCalculator(H_data, M_data, H_model, M_model, use_log_h);
        end

        function e = get_error(obj)
            [Xhat_u, Yhat_u] = ErrorCalculator.sorted_unique(obj.Xhat, obj.Yhat);
            if numel(Xhat_u) < 2 || numel(obj.X) < 1
                e = Inf;
                return;
            end

            Yint = interp1(Xhat_u, Yhat_u, obj.X, 'linear', 'extrap');
            residual = obj.Y - Yint;

            y_scale = max(abs(obj.Y));
            if y_scale <= 0 || ~isfinite(y_scale)
                y_scale = 1;
            end

            e = sqrt(mean(residual.^2)) / y_scale;
        end
    end
end
