classdef HorizontalErrorCalculator < ErrorCalculator
%HORIZONTALERRORCALCULATOR  Horizontal (H-direction) fit error.
%   HorizontalErrorCalculator(H_data, M_data, H_model, M_model, use_log_h)
%   interpolates the modeled curve's X (log H when use_log_h, H otherwise --
%   see ErrorCalculator) at each data point's M and returns the normalized
%   RMS horizontal offset between data and model:
%     e = sqrt(mean(residual.^2)) / max(|X_data|)
%   See VerticalErrorCalculator for why RMS + peak-value normalization are
%   used (N-invariant and comparable across curves of different scale).

    methods
        function obj = HorizontalErrorCalculator(H_data, M_data, H_model, M_model, use_log_h)
            if nargin < 5 || isempty(use_log_h)
                use_log_h = true;
            end
            obj = obj@ErrorCalculator(H_data, M_data, H_model, M_model, use_log_h);
        end

        function e = get_error(obj)
            [Yhat_u, Xhat_u] = ErrorCalculator.sorted_unique(obj.Yhat, obj.Xhat);
            if numel(Yhat_u) < 2 || numel(obj.Y) < 1
                e = Inf;
                return;
            end

            Xint = interp1(Yhat_u, Xhat_u, obj.Y, 'linear', 'extrap');
            residual = obj.X - Xint;

            x_scale = max(abs(obj.X));
            if x_scale <= 0 || ~isfinite(x_scale)
                x_scale = 1;
            end

            e = sqrt(mean(residual.^2)) / x_scale;
        end
    end
end
