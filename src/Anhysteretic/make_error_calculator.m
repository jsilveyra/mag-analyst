function error_calculator = make_error_calculator(error_type, data_H, data_M, model_H, model_M)
%MAKE_ERROR_CALCULATOR  Build the fit-objective ErrorCalculator for an error type.
%   error_calculator = make_error_calculator(error_type, data_H, data_M, ...
%       model_H, model_M) maps the Anhysteretic tab's error-metric label
%   (the ErrorDropDown value) to the matching ErrorCalculator subclass,
%   configured with the same logH/sampled flags used throughout the app.
%
%   Single source of truth for a dispatch previously duplicated in fit.m,
%   AnhystereticUtils.update_error_display and fit_physical.m. The three
%   metrics use use_log_h = true (the Anhysteretic curve's own H>0 domain).

    error_type = string(error_type);
    if (error_type == "Diagonal (H, sampled)")
        error_calculator = DiagonalErrorCalculator(data_H, data_M, model_H, model_M, false, false);
    elseif (error_type == "Diagonal (H, continuous)")
        error_calculator = DiagonalErrorCalculator(data_H, data_M, model_H, model_M, false, true);
    elseif (error_type == "Diagonal (logH, sampled)") || (error_type == "Diagonal (sampled)")
        error_calculator = DiagonalErrorCalculator(data_H, data_M, model_H, model_M, true, false);
    elseif (error_type == "Diagonal (logH, continuous)") || (error_type == "Diagonal") || (error_type == "Diagonal (continuous)")
        error_calculator = DiagonalErrorCalculator(data_H, data_M, model_H, model_M, true, true);
    elseif (error_type == "Vertical")
        error_calculator = VerticalErrorCalculator(data_H, data_M, model_H, model_M, true);
    elseif (error_type == "Horizontal")
        error_calculator = HorizontalErrorCalculator(data_H, data_M, model_H, model_M, true);
    else
        error('Unknown error type: %s', error_type);
    end
end
