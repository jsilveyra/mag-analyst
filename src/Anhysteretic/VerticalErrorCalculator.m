classdef VerticalErrorCalculator < ErrorCalculator
%VERTICALERRORCALCULATOR  Vertical (M-direction) fit error.
%   VerticalErrorCalculator(data_curve, modeled_curve).get_error()
%   interpolates the modeled curve's M at each data logH value and returns
%   the RMS vertical offset between data and model, normalized by max(Y).

    methods
        function obj = VerticalErrorCalculator(data_curve, modeled_curve)
            obj = obj@ErrorCalculator(data_curve, modeled_curve);
        end

        function e = get_error(obj)
            Yint = interp1(obj.Xhat, obj.Yhat, obj.X, 'linear', 'extrap');
            Yint = Yint(1:end);
            Ydat = obj.Y(1:end);
            e = 0;
            for i = 1:length(Yint)
                aux = Ydat(i) - Yint(i);
                e = e + (aux^2);
            end
            e = (sqrt(e)/max(obj.Y))/length(obj.Y);
        end
    end
end