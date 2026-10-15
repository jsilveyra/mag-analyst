function error_calculator = make_error_calculator(error_type, data_H, data_M, model_H, model_M)
%MAKE_ERROR_CALCULATOR  Build the fit-objective ErrorCalculator for an error type.
%   error_calculator = make_error_calculator(error_type, data_H, data_M, ...
%       model_H, model_M) maps the Anhysteretic tab's error-metric label
%   (the ErrorDropDown value) to the matching ErrorCalculator subclass,
%   configured with the same logH/sampled flags used throughout the app.
%
%   Single source of truth for the dispatch shared by fit.m,
%   AnhystereticUtils.update_error_display, fit_physical.m and the Export
%   dialog. The Diagonal metrics come in both planes: "(logH, ...)" uses
%   use_log_h = true (normalized ln H, the curve's H>0 domain), "(H, ...)"
%   the normalized linear plane H/Htip. Vertical and Horizontal use the
%   linear plane (use_log_h = false) since 2026-09-25; before that they
%   were evaluated in the logH plane only.

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
        error_calculator = VerticalErrorCalculator(data_H, data_M, model_H, model_M, false);
    elseif (error_type == "Horizontal")
        error_calculator = HorizontalErrorCalculator(data_H, data_M, model_H, model_M, false);
    else
        error('Unknown error type: %s', error_type);
    end
end
