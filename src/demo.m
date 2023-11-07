parser = Parser('.\data\sampleData\Finemet - TA.csv', "H [A/m]", "B [T]", "Hysteretic loop");
[H, M, H_raw, M_raw] = parser.import();

data_curve = DataAnhystereticCurve(H, M);

seed = [5 0.6];
lower_bound = [4 0.5];
upper_bound = [6 0.7];
select_fit = {true true};

select_a = 'low';
error_type = "Diagonal";

[Hcr, mcr, Hx] = fit(data_curve, seed, select_a, error_type, lower_bound, upper_bound, select_fit);

magnetic_parameters = MagneticParameters(data_curve, Hcr, mcr, Hx, select_a);

[HTip, ~] = Utils().find_tip(data_curve.H, data_curve.M);
N = 100;
Hhat = logspace(log10(data_curve.H(2)),log10(HTip),N);

modeled_curve = ModeledAnhystereticCurve(Hhat, magnetic_parameters);


% Errores
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


% Residuos
residue_calculator = MagnetizationResidueCalculator(data_curve, modeled_curve);
magnetization_residue = residue_calculator.get_residue();
residue_plotter = ResiduePlotter(data_curve.H(2:end-1), data_curve.M(2:end-1), modeled_curve.H, modeled_curve.M, magnetization_residue, true, "M [A/m]");
residue_plotter.plot()


residue_calculator = SusceptibilityResidueCalculator(data_curve, modeled_curve);
susceptibility_residue = residue_calculator.get_residue();

residue_calculator = SemilogDerivativeResidueCalculator(data_curve, modeled_curve);
semilog_derivative_residue = residue_calculator.get_residue();


% Plot
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





