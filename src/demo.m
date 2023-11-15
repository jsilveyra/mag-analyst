% Parser
parser_constants = ParserConstants();
% To initialize a parser: parser = Parser(file_path, H_unit, M_unit, curve_type)
% curve_type options:
%   ANHYSTERETIC_CURVE_TYPE
%   HYSTERESIS_LOOP_TYPE
% Refer ParserConstants.m to explore all units
parser = Parser('.\data\sampleData\Finemet - TA.csv', parser_constants.H_AMPERE_PER_METER, parser_constants.B_TESLA, parser_constants.HYSTERESIS_LOOP_TYPE);
[H, M, H_raw, M_raw] = parser.import();

data_curve = DataAnhystereticCurve(H, M);

% Set values for seed: seed = [Hcr m(Hcr)]
seed = [5 0.6]; 

% Set values for lower bounds: lower_bounds = [Hcr m(Hcr)]
lower_bound = [4 0.5]; 

% Set values for upper bounds: upper_bounds = [Hcr m(Hcr)]
upper_bound = [6 0.7]; 

% Set values for fitting booleans: select_fit = [Hcr m(Hcr)]
select_fit = {true true}; 

fit_constants = FitContants();
% To use fit function: [Hcr, mcr, Hx] = fit(data_curve, seed, select_a, error_type, lower_bound, upper_bound, select_fit)
% select_a options:
%   fit_constants.LOW_A
%   fit_constants.HIGH_A
% error_type options:
%   fit_constants.HORIZONTAL_ERROR_TYPE
%   fit_constants.VERTICAL_ERROR_TYPE
%   fit_constants.DIAGONAL_ERROR_TYPE
[Hcr, mcr, Hx] = fit(data_curve, seed, fit_constants.LOW_A, fit_constants.DIAGONAL_ERROR_TYPE, lower_bound, upper_bound, select_fit);

magnetic_parameters_constants = MagneticParametersConstants();
% To initialize magnetic_parameters: magnetic_parameters = MagneticParameters(data_curve, Hcr, mcr, Hx, select_a)
% select_a options:
%   magnetic_parameters_constants.LOW_A
%   magnetic_parameters_constants.HIGH_A
magnetic_parameters = MagneticParameters(data_curve, Hcr, mcr, Hx, magnetic_parameters_constants.LOW_A);

[HTip, ~] = Utils().find_tip(data_curve.H, data_curve.M);
N = 100;
Hhat = logspace(log10(data_curve.H(2)),log10(HTip),N);

modeled_curve = ModeledAnhystereticCurve(Hhat, magnetic_parameters);


% Errors
error_calculator = DiagonalErrorCalculator(data_curve, modeled_curve);
diagonal_error = error_calculator.get_error();
disp("Diagonal error:")
disp(diagonal_error)

error_calculator = VerticalErrorCalculator(data_curve, modeled_curve);
vertical_error = error_calculator.get_error();
disp("Vertical error:")
disp(vertical_error)

error_calculator = HorizontalErrorCalculator(data_curve, modeled_curve);
horizontal_error = error_calculator.get_error();
disp("Horizontal error:")
disp(horizontal_error)


% Residues
residue_calculator = MagnetizationResidueCalculator(data_curve, modeled_curve);
magnetization_residue = residue_calculator.get_residue();
% To initialize residue_plotter: residue_plotter = ResiduePlotter(X, Y, Xhat, Yhat, Residue, Log, Label, varargin)
residue_plotter = ResiduePlotter(data_curve.H(2:end-1), data_curve.M(2:end-1), modeled_curve.H, modeled_curve.M, magnetization_residue, true, "M [A/m]");
residue_plotter.plot()


residue_calculator = SusceptibilityResidueCalculator(data_curve, modeled_curve);
susceptibility_residue = residue_calculator.get_residue();

residue_calculator = SemilogDerivativeResidueCalculator(data_curve, modeled_curve);
semilog_derivative_residue = residue_calculator.get_residue();


% Plots examples
% Set colors: colors = [R G B; R G B] 0-1 scale
colors = [ 0.58 0 0.70; 0.70 0 0]; 
plotter = Plotter(data_curve, modeled_curve, Hcr, colors);

figure();
ax = nexttile;
plot_components = false;
plot_grid = true;
plotter.plot_M(ax, plot_components, plot_grid);

figure();
ax = nexttile;
plotter.plot_HdMdH_log(ax, plot_components, plot_grid);





