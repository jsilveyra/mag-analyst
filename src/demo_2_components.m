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

% Set values for seed: seed = [Hcr1 Hcr2 m(Hcr1) m(Hcr2) Hx1]
seed = [1.5000 6.0000 0.5000 0.5000 3.7500]; 

% Set values for lower bounds: lower_bounds = [Hcr1 Hcr2 m(Hcr1) m(Hcr2) Hx1]
lower_bound = [0; 0; 0.4496; 0.4496; 0];

% Set values for upper bounds: upper_bounds = [Hcr1 Hcr2 m(Hcr1) m(Hcr2) Hx1]
upper_bound = [5; 10; 1; 1; 14]; 

% Set boolean values for fitting: select_fit = [Hcr1 Hcr2 m(Hcr1) m(Hcr2) Hx1]
select_fit = {true; true; true; true; true};

% Set low/high value for ai: select_a = categorical({'a1';'a2'});
select_a = categorical({'low';'low'});

fit_constants = FitConstants();
% To use fit function: [Hcr, mcr, Hx] = fit(data_curve, seed, select_a, error_type, lower_bound, upper_bound, select_fit)
[Hcr, mcr, Hx] = fit(data_curve, seed, select_a, fit_constants.DIAGONAL_ERROR_TYPE, lower_bound, upper_bound, select_fit);

magnetic_parameters_constants = MagneticParametersConstants();
% To initialize magnetic_parameters: magnetic_parameters = MagneticParameters(data_curve, Hcr, mcr, Hx, select_a)
% select_a options:
%   magnetic_parameters_constants.LOW_A
%   magnetic_parameters_constants.HIGH_A
magnetic_parameters = MagneticParameters(data_curve, Hcr, mcr, Hx, select_a);

% Get modeled anhysteretic curve
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
colors = [0.58 0 0.70; 0.70 0 0; 0 0 0.70];
plotter = Plotter(data_curve, modeled_curve, Hcr, colors);

figure();
ax = nexttile;
plot_components = true;
plot_grid = true;
plotter.plot_M(ax, plot_components, plot_grid);

figure();
ax = nexttile;
plotter.plot_HdMdH_log(ax, plot_components, plot_grid);

figure();
ax = nexttile;
plotter.plot_raw_log(ax, modeled_curve.H, modeled_curve.M, "H", "M", "M vs H semilog plot")
