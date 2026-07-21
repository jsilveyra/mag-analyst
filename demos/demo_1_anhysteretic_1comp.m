%% demo_1_anhysteretic_1comp.m
%  Programmatic MagAnalyst demo: ANHYSTERETIC fit with a SINGLE component.
%
%  Pipeline (mirrors the "Anhysteretic fitting" tab, without the GUI):
%     import measured M(H)  ->  auto-retrieve fit seeds  ->  fit the
%     fitting parameters (Hcr, m(Hcr))  ->  derive the physical
%     magnetic parameters (Ms, a, alpha)  ->  build the modeled curve
%     ->  report fit errors  ->  plot.
%
%  The anhysteretic model describes each magnetic "component"
%  by two fitting parameters:
%     Hcr    - the critical field of the component (field at which dM/d(lnH) is maximum)           [A/m]
%     m(Hcr) - the reduced magnetization (m=M/Ms) at Hcr    [-]
%  The modeled curve is fixed at the data's measured tip (Htip, Mtip).
%  A model with n components is fitted with 3*n-1 parameters:
%     [Hcr_1..n , m_1..n , Hx_2..(n+1)]
%  where Hx_i are the additional fixed points of the modeled curve and are conveniently placed at the 
%  inter-component cross-over fields. The GUI automatically seeds the Hx_(i+1) at [Hcr_(i) + Hcr_(i+1)]/2.
%
%  Run from anywhere:  >> demo_1_anhysteretic_1comp
%
%  See also: demo_2_anhysteretic_2comp (two components),
%            demo_3_hysteretic_ja_fit (Jiles-Atherton fit seeded from here).
clc; clear; close all;

%% --- Bootstrap: add the MagAnalyst source tree to the path ---------------
demo_dir = fileparts(mfilename('fullpath'));
if isempty(demo_dir)
    demo_dir = pwd;                 % running via copy-paste in the command window
end
project_root = fileparts(demo_dir);
addpath(genpath(fullfile(project_root, 'src')));

%% --- 1) Import the measured data ----------------------------------------
%  Parser(file_path, H_field_unit, M_field_unit, curve_type, number_points)
%  reads a two-column CSV, converts both axes to SI base units (A/m), and
%  resamples the curve to `number_points` samples.
%
%  Supported unit / curve-type labels live in ParserConstants (use the
%  constants, not raw strings, so a typo fails loudly):
%     x-axis     : H_AMPERE_PER_METER | H_KILO_AMPERE_PER_METER |
%                  H_OERSTED | H_KILO_OERSTED |
%                  BEXT_TESLA | BEXT_GAUSS | BEXT_KILO_GAUSS
%     y-axis     : M_AMPERE_PER_METER | M_KILO_AMPERE_PER_METER |
%                  M_MEGA_AMPERE_PER_METER |
%                  M_ELECTROMAGNETIC_UNIT_PER_CUBE_CENTIMETER |
%                  SIGMA_ELECTROMAGNETIC_UNIT_PER_GRAM |
%                  J_TESLA | B_TESLA | B_GAUSS | B_KILO_GAUSS
%     curve_type : ANHYSTERETIC_CURVE_TYPE | HYSTERESIS_LOOP_TYPE
%
%  Here the sample file stores an MnZn-ferrite major loop as "H [A/m]" vs
%  "B [T]"; picking HYSTERESIS_LOOP_TYPE tells the parser to fold the loop
%  into an anhysteretic (single-valued) M(H) [or sigma(H)] curve for the fit.
pc = ParserConstants();
data_file = fullfile(project_root, 'data', 'sample_data', '2022_AIP', 'MnZn_ferrite.csv');

number_points = 50;                % samples in the resampled anhysteretic curve
parser = Parser(data_file, ...
                pc.H_AMPERE_PER_METER, ...
                pc.B_TESLA, ...
                pc.HYSTERESIS_LOOP_TYPE, ...
                number_points);
[H, M, H_raw, M_raw] = parser.import();   % (raw columns kept for reference)

% DataAnhystereticCurve wraps the measured (H, M) and precomputes dM/dH and
% H*dM/dH, the "halo" used for seeding and for the diagnostic plots.
data_curve = DataAnhystereticCurve(H, M);

%% --- 2) Retrieve fit seeds automatically --------------------------------
%  retrieve_anhysteretic_seeds inspects the H*dM/dH halo of the measured
%  curve and returns physically reasonable starting values. This is exactly
%  what the GUI does when you set the number of components.
%  (You could instead hand-pick seeds, e.g. seed = [5, 0.6].)
number_components = 1;
[Hcr_seed, mcr_seed, Hx_seed] = retrieve_anhysteretic_seeds(data_curve, number_components);

% Parameter vector layout for `fit`: [Hcr(1..n), m(1..n), Hx(1..n-1)].
% For a single component Hx is empty.
seed = [Hcr_seed, mcr_seed, Hx_seed];

%% --- 3) Fit settings -----------------------------------------------------
% select_a: which root of the a(Hcr, m) relation to take, per component.
%   "low"  -> narrow halo branch (default, matches the GUI)
%   "high" -> wide halo branch (see the a-root selection note in the docs)
select_a = "low";

% Bounds, one entry per fitted parameter, same order as `seed`.
%   Hcr : (0, Inf)          m(Hcr) : [0.4496, 1]
% 0.4496 is the physical lower limit of m(Hcr) in this model.
lower_bound = [0,   0.4496];
upper_bound = [Inf, 1];

% select_fit: true = optimize this parameter, false = freeze it at its seed.
select_fit = {true, true};

% error_type: the objective minimized during the fit. Options:
%   "Diagonal (H, sampled)" | "Diagonal (H, continuous)" |
%   "Diagonal (logH, sampled)" | "Diagonal (logH, continuous)" |
%   "Vertical" | "Horizontal"
% The GUI's Anhysteretic tab defaults to "Diagonal (logH, continuous)".
error_type = "Diagonal (logH, continuous)";

% N: number of log-spaced field samples the fitter evaluates the model on.
N = 100;

%% --- 4) Run the fit ------------------------------------------------------
% fit(data_curve, seed, N, select_a, error_type, lb, ub, select_fit)
[Hcr, mcr, Hx] = fit(data_curve, seed, N, select_a, error_type, ...
                     lower_bound, upper_bound, select_fit);

fprintf('\nFitted distribution parameters (1 component):\n');
fprintf('   Hcr    = %.6g A/m\n', Hcr);
fprintf('   m(Hcr) = %.6g\n',    mcr);

%% --- 5) Derive the physical magnetic parameters -------------------------
% MagneticParameters converts the fitted (Hcr, m, Hx) into Ms, a, alpha,
% Hk, chi_in, etc. Ms is scaled so the model matches the measured loop tip.
magnetic_parameters = MagneticParameters(data_curve, Hcr, mcr, Hx, select_a);

fprintf('\nDerived physical parameters:\n');
fprintf('   Ms    = %.6g A/m\n',   magnetic_parameters.Ms);
fprintf('   a     = %.6g A/m\n',   magnetic_parameters.a);
fprintf('   alpha = %.6g\n',       magnetic_parameters.alpha);
fprintf('   Hk    = %.6g A/m\n',   magnetic_parameters.Hk);
fprintf('   chi_in (total) = %.6g\n', magnetic_parameters.chi_in_total);

%% --- 6) Build the modeled curve on a GUI-style log field grid -----------
[HTip, ~] = Utils().find_tip(data_curve.H, data_curve.M);
Hpos = data_curve.H(data_curve.H > 0);
Hhat = [0, logspace(log10(min(Hpos)), log10(HTip), N-1)];
modeled_curve = ModeledAnhystereticCurve(Hhat, magnetic_parameters);

%% --- 7) Report the fit errors -------------------------------------------
% Each error calculator scores the modeled curve against the data with a
% different metric (all normalized RMS, dimensionless -- see
% src/Common/ErrorCalculator.m); lower is better. These are the same six
% choices exposed by the GUI's Anhysteretic Error dropdown.
fprintf('\nFit errors (GUI options, evaluated on the displayed modeled curve):\n');
fprintf('   Selected objective: %s\n', error_type);
fprintf('   Diagonal (H, sampled)       = %.6g\n', DiagonalErrorCalculator(data_curve.H, data_curve.M, modeled_curve.H, modeled_curve.M, false, false).get_error());
fprintf('   Diagonal (H, continuous)    = %.6g\n', DiagonalErrorCalculator(data_curve.H, data_curve.M, modeled_curve.H, modeled_curve.M, false, true).get_error());
fprintf('   Diagonal (logH, sampled)    = %.6g\n', DiagonalErrorCalculator(data_curve.H, data_curve.M, modeled_curve.H, modeled_curve.M, true, false).get_error());
fprintf('   Diagonal (logH, continuous) = %.6g\n', DiagonalErrorCalculator(data_curve.H, data_curve.M, modeled_curve.H, modeled_curve.M, true, true).get_error());
fprintf('   Vertical                    = %.6g\n', VerticalErrorCalculator(data_curve.H, data_curve.M, modeled_curve.H, modeled_curve.M, true).get_error());
fprintf('   Horizontal                  = %.6g\n', HorizontalErrorCalculator(data_curve.H, data_curve.M, modeled_curve.H, modeled_curve.M, true).get_error());

%% --- 8) Plots ------------------------------------------------------------
% Colors: row 1 = total modeled curve, rows 2..n+1 = per-component curves.
colors = [0.85 0.33 0.10;    % total (orange)
          0.00 0.45 0.74];   % component 1 (blue)
plot_components = false;      % single component -> nothing extra to overlay
plot_grid       = true;

plotter = Plotter(data_curve, modeled_curve, Hcr, colors, 8);

figure('Name', 'Demo 1 - Anhysteretic fit (1 component)');
tiledlayout(1, 2);

nexttile;
plotter.plot_M(gca, plot_components, plot_grid, 'M [A/m]');
title('M vs H');

nexttile;
plotter.plot_HdMdH_log(gca, plot_components, plot_grid, 'H dM/dH [A/m]');
title('H\cdotdM/dH vs H (semilog)');

fprintf('\nDone.\n');
