%% demo_2_components.m
clc; clear; close all;

%% Parser
parser_constants = ParserConstants();
% Build cross-platform path
data_file = fullfile('data', 'sampleData', 'Finemet - TA.csv');

% Initialize parser: parser = Parser(file_path, H_unit, M_unit, curve_type)
% curve_type options:
%   ANHYSTERETIC_CURVE_TYPE
%   HYSTERESIS_LOOP_TYPE
parser = Parser(data_file, ...
                parser_constants.H_AMPERE_PER_METER, ...
                parser_constants.B_TESLA, ...
                parser_constants.HYSTERESIS_LOOP_TYPE);
[H, M, H_raw, M_raw] = parser.import();

%% Data curve
data_curve = DataAnhystereticCurve(H, M);

%% Fit parameters
seed = [1.5000 6.0000 0.5000 0.5000 3.7500]; 
lower_bound = [0; 0; 0.4496; 0.4496; 0];
upper_bound = [5; 10; 1; 1; 14]; 
select_fit = {true; true; true; true; true};
select_a = categorical({'low';'low'});
fit_constants = FitConstants();

[Hcr, mcr, Hx] = fit(data_curve, seed, 100, select_a, ...
                      fit_constants.DIAGONAL_ERROR_TYPE, ...
                      lower_bound, upper_bound, select_fit);

%% Magnetic parameters
magnetic_parameters_constants = MagneticParametersConstants();
magnetic_parameters = MagneticParameters(data_curve, Hcr, mcr, Hx, select_a);

%% Modeled curve
[HTip, ~] = Utils().find_tip(data_curve.H, data_curve.M);
N = 100;
Hhat = logspace(log10(data_curve.H(2)), log10(HTip), N);
modeled_curve = ModeledAnhystereticCurve(Hhat, magnetic_parameters);

%% Error calculations
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

%% Residue calculations
residue_calculator = MagnetizationResidueCalculator(data_curve, modeled_curve);
magnetization_residue = residue_calculator.get_residue();

% Ensure the residue has the same length as data_curve.H
magnetization_residue = magnetization_residue(:); % make column vector
H_data = data_curve.H(:); % make column vector

len_diff = length(H_data) - length(magnetization_residue);
if len_diff > 0
    % pad with zeros to match length
    magnetization_residue = [magnetization_residue; zeros(len_diff,1)];
elseif len_diff < 0
    % trim to match length
    magnetization_residue = magnetization_residue(1:length(H_data));
end

% Initialize ResiduePlotter
residue_plotter = ResiduePlotter(H_data, data_curve.M, ...
                                 modeled_curve.H, modeled_curve.M, ...
                                 magnetization_residue, true, "M [A/m]");
residue_plotter.plot()

% Other residues (optional for further analysis)
residue_calculator = SusceptibilityResidueCalculator(data_curve, modeled_curve);
susceptibility_residue = residue_calculator.get_residue();

residue_calculator = SemilogDerivativeResidueCalculator(data_curve, modeled_curve);
semilog_derivative_residue = residue_calculator.get_residue();

%% Plot examples
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
plotter.plot_raw_log(ax, modeled_curve.H, modeled_curve.M, "H", "M", "M vs H semilog plot");