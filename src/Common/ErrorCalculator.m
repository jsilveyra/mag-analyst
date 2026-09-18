classdef ErrorCalculator
%ERRORCALCULATOR  Abstract base class for fit-objective error metrics.
%   ErrorCalculator(H_data, M_data, H_model, M_model, use_log_h) stores
%   comparable (X,Y) pairs from the data and model curves in X/Y (data) and
%   Xhat/Yhat (model). Subclasses (DiagonalErrorCalculator,
%   HorizontalErrorCalculator, VerticalErrorCalculator) implement get_error()
%   to define the scalar error minimized by an optimizer -- fit.m for the
%   anhysteretic fit, and HystereticUtils.compute_ja_left_branch_error_core
%   for the Jiles-Atherton fit, sharing this same hierarchy.
%
%   use_log_h (default true) selects the domain:
%     true  - X = log(H/Hmin) / log(Hmax/Hmin), restricted to H > 0, with
%             Hmin/Hmax the smallest/largest positive H of the DATA (Hmax
%             is the tip). Matches the anhysteretic curve, which is
%             single-valued over H >= 0 (log(0) = -Inf). The data then
%             span exactly [0, 1] along X, the same extent Y/max|Y| gives
%             them along Y, so the Diagonal and Horizontal metrics weight
%             field and magnetization misfit equally and independently of
%             the numerical value of H. Until 2026-09-18 X was the bare
%             log(H) (H in A/m), which the subclasses then scaled by
%             max|log(H)|: that made the field axis extent
%             log(Hmax/Hmin)/max|log H|, i.e. anywhere from ~0.7 to ~0.3 of
%             the magnetization axis on the bundled datasets depending on
%             where H = 1 A/m fell -- an arbitrary, unit-dependent weight.
%             Vertical errors are unaffected by this change (affine in X);
%             Horizontal and Diagonal (logH) errors are rescaled.
%     false - X = H directly, restricted to finite (H, M) pairs. Used for
%             the Jiles-Atherton hysteretic branch, where H spans
%             [-Htip, +Htip] through zero and a log transform does not apply.

    properties
        X
        Y
        Xhat
        Yhat
    end

    methods (Abstract)
        e = get_error(obj);
    end

    methods (Access = public)
        function obj = ErrorCalculator(H_data, M_data, H_model, M_model, use_log_h)
           if nargin < 5 || isempty(use_log_h)
               use_log_h = true;
           end
           H_data = H_data(:);
           M_data = M_data(:);
           H_model = H_model(:);
           M_model = M_model(:);

           if use_log_h
               % consider only values above 0 because log(0) = -Inf
               valid_data = H_data > 0;
               valid_model = H_model > 0;
               % Normalized log axis, see the class help: 0 at the data's
               % smallest positive H, 1 at its tip. The same affine map is
               % applied to the model so both curves share the plane.
               H_min = min(H_data(valid_data));
               H_max = max(H_data(valid_data));
               log_span = log(H_max / H_min);
               if isempty(log_span) || ~isfinite(log_span) || log_span <= 0
                   H_min = 1;
                   log_span = 1;
               end
               obj.X = log(H_data(valid_data) / H_min) / log_span;
               obj.Y = M_data(valid_data);
               obj.Xhat = log(H_model(valid_model) / H_min) / log_span;
               obj.Yhat = M_model(valid_model);
           else
               valid_data = isfinite(H_data) & isfinite(M_data);
               valid_model = isfinite(H_model) & isfinite(M_model);
               obj.X = H_data(valid_data);
               obj.Y = M_data(valid_data);
               obj.Xhat = H_model(valid_model);
               obj.Yhat = M_model(valid_model);
           end
        end
    end

    methods (Static, Access = public)
        function [Xs, Ys] = sorted_unique(X, Y)
            %SORTED_UNIQUE  Sort (X,Y) by ascending X and drop duplicate X.
            %   Needed before interp1 can treat X as a sample grid: a
            %   monotonic-decreasing branch (e.g. a hysteretic sweep from
            %   +Htip to -Htip) or a non-strictly-monotonic model curve
            %   would otherwise produce nonsensical interpolated values.
            [Xs, idx] = sort(X, 'ascend');
            Ys = Y(idx);
            [Xs, idx_u] = unique(Xs, 'stable');
            Ys = Ys(idx_u);
        end
    end
end
