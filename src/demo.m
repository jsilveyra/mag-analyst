parser = Parser('C:\ubuntu\mag-analyst\data\sampleData\Finemet - TA.csv');
[H, M] = parser.get_data_csv();

[H, M] = UnitConvertor().convert_H_M(H, "H [A/m]", M, "M [A/m]");
[H, M] = CurveConvertor().convert_curve(H, M, "Hysteretic loop");

data_curve = DataAnhystereticCurve(H, M);

[HTip, ~] = Utils().find_tip(data_curve.H, data_curve.M);
N = 100;
Hhat = logspace(log10(data_curve.H(2)),log10(HTip),N);

a = 0.5461;
Ms = 1.2390;
alpha = -5.3750;
alphaMs = alpha * Ms;
 
modeled_curve = ModeledAnhystereticCurve(Hhat, a, alpha, alphaMs, Ms);


% Errores
error_calculator = DiagonalErrorCalculator(data_curve, modeled_curve);
diagonal_error = error_calculator.get_error();

error_calculator = VerticalErrorCalculator(data_curve, modeled_curve);
vertical_error = error_calculator.get_error();

error_calculator = HorizontalErrorCalculator(data_curve, modeled_curve);
horizontal_error = error_calculator.get_error();


% Residuos
residue_calculator = MagnetizationResidueCalculator(data_curve, modeled_curve);
magnetization_residue = residue_calculator.get_residue();

residue_calculator = SusceptibilityResidueCalculator(data_curve, modeled_curve);
susceptibility_residue = residue_calculator.get_residue();

residue_calculator = SemilogDerivativeResidueCalculator(data_curve, modeled_curve);
semilog_derivative_residue = residue_calculator.get_residue();


% Plot
Hcr = 5.8064;
colors = [ 0.58 0 0.70; 0.70 0 0];
plotter = Plotter(data_curve, modeled_curve, Hcr, colors);

figure();
ax = nexttile;
plot_components = false;
plot_grid = true;
plotter.plot_M(ax, plot_components, plot_grid);





