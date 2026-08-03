%% demo_2_anhysteretic_2comp.m
%  Programmatic MagAnalyst demo: ANHYSTERETIC fit with TWO components.
%
%  Same pipeline as demo_1, but the distribution model now has two
%  components, so the fit has 3*n-1 = 5 parameters:
%     [Hcr_1, Hcr_2 , m_1, m_2 , Hx_1]
%  Hx_1 is the cross-over field between components 1 and 2 (at this field the modeled curve is constrained to the data value).
%  Each component gets its own root choice via select_a.
%
%  Pipeline (mirrors the "Anhysteretic fitting" tab, without the GUI):
%     1. Import the measured M(H) curve.
%     2. Auto-retrieve the fit seeds from the measured H*dM/dH "halo".
%     3. Choose the fit settings (a-roots, bounds, objective, solver).
%     4. Fit the distribution parameters (Hcr_i, m_i(Hcr_i), Hx_1).
%     5. Derive the physical magnetic parameters (Ms_i, a_i, alpha_i).
%     6. OPTIONAL refinement: re-fit the PHYSICAL parameters directly,
%        seeded from step 5 (the GUI's "reduce dof" UNCHECKED second stage).
%     7. Build the modeled curve on a GUI-style log field grid.
%     8. Report the fit errors.
%     9. Plot.
%
%  Multi-component fits are useful when the H*dM/dH "halo" of the measured
%  curve shows more than one peak (e.g. two magnetic phases / grain
%  populations contributing on different field scales).
%
%  Run from anywhere:  >> demo_2_anhysteretic_2comp
%
%  See also: demo_1_anhysteretic_1comp (single component).
clc; clear; close all;

%% --- Bootstrap -----------------------------------------------------------
demo_dir = fileparts(mfilename('fullpath'));
if isempty(demo_dir)
    demo_dir = pwd;
end
project_root = fileparts(demo_dir);
addpath(genpath(fullfile(project_root, 'src')));

%% --- 1) Import the measured data ----------------------------------------
% See demo_1 for the full x-axis, y-axis and curve-type constant list,
% including the mass-magnetization y-axis option:
%     pc.SIGMA_ELECTROMAGNETIC_UNIT_PER_GRAM
pc = ParserConstants();
data_file = fullfile(project_root, 'data', 'sample_data', '2022_AIP', 'MnZn_ferrite.csv');

number_points = 50;                % the GUI's N° of points default
parser = Parser(data_file, ...
                pc.H_AMPERE_PER_METER, ...
                pc.B_TESLA, ...
                pc.HYSTERESIS_LOOP_TYPE, ...
                number_points);
[H, M] = parser.import();
data_curve = DataAnhystereticCurve(H, M);

%% --- 2) Retrieve fit seeds automatically --------------------------------
% retrieve_anhysteretic_seeds finds up to `number_components` halo peaks and
% returns seeds for each, plus the cross-over field(s) Hx.
number_components = 2;
[Hcr_seed, mcr_seed, Hx_seed] = retrieve_anhysteretic_seeds(data_curve, number_components);

% Parameter vector layout: [Hcr(1..n), m(1..n), Hx(1..n-1)].
seed = [Hcr_seed, mcr_seed, Hx_seed];   % 5 values for n = 2

%% --- 3) Fit settings -----------------------------------------------------
% One select_a entry per component ("low" or "high").
select_a = ["low", "low"];

% Bounds in the same [Hcr(1..n), m(1..n), Hx(1..n-1)] order.
%   Hcr : (0, Inf)     m : [0.4496, 1]     Hx : (0, 1e6)
lower_bound = [0,   0,   0.4496, 0.4496, 0];
upper_bound = [Inf, Inf, 1,      1,      1e6];

% Freeze/optimize flags, one per parameter (all optimized here).
select_fit = {true, true, true, true, true};

% Objective to minimize (see demo_1 for the full option list).
% The GUI's Anhysteretic tab defaults to "Diagonal (logH, continuous)".
% For quicker exploratory runs, "Diagonal (logH, sampled)" uses the same
% log-H geometry with the faster sampled-distance approximation.
error_type = "Diagonal (logH, continuous)";

% Model-evaluation grid size.
N = 100;

% solver: the optimizer used to minimize the fit error ("prima" [default,
% PRIMA-BOBYQA with tuned npt] or "nelder_mead" [minimize()] -- see
% demo_1 for the full explanation, and src/lib/bobyqa_mat/README.md for the
% benchmark behind the default). Mirrors the GUI's "Solver" dropdown.
solver = "prima";

%% --- 4) Run the fit ------------------------------------------------------
[Hcr, mcr, Hx] = fit(data_curve, seed, N, select_a, error_type, ...
                     lower_bound, upper_bound, select_fit, [], solver);

fprintf('\nFitted distribution parameters (2 components):\n');
for i = 1:number_components
    fprintf('   Component %d: Hcr = %.6g A/m , m(Hcr) = %.6g\n', i, Hcr(i), mcr(i));
end
fprintf('   Cross-over Hx_1 = %.6g A/m\n', Hx);

%% --- 5) Derive the physical magnetic parameters (per component) ---------
magnetic_parameters = MagneticParameters(data_curve, Hcr, mcr, Hx, select_a);

fprintf('\nDerived physical parameters (per component):\n');
for i = 1:number_components
    fprintf('   Component %d: Ms = %.6g A/m , a = %.6g A/m , alpha = %.6g\n', ...
            i, magnetic_parameters.Ms(i), magnetic_parameters.a(i), magnetic_parameters.alpha(i));
end
fprintf('   Total chi_in = %.6g\n', magnetic_parameters.chi_in_total);

%% --- 6) OPTIONAL: refine the fit over the physical parameters -----------
% The GUI's "reduce dof" UNCHECKED second stage (see demo_1 for the full
% explanation). Steps 4-5 fit the 5 distribution parameters, which pins the
% modeled curve to the measured tip AND to the data at Hx_1 -- two
% constraints that solve for Ms_1 and Ms_2 instead of fitting them.
% fit_physical drops both constraint points and optimizes the 3*n = 6
% physical parameters [Ms_1, Ms_2, alpha_1, alpha_2, a_1, a_2] directly,
% seeded from the values just derived.
%
% This second stage matters more with several components than with one:
% each component's Ms is now free to trade against the others, which is
% exactly the freedom the tip/Hx constraints take away.
%
% Runtime note: the refinement is a full optimizer run over 3*n parameters,
% and with n = 2 it takes several minutes. Essentially all of that cost is
% rebuilding the modeled curve at every objective evaluation (~250 ms for
% 2 components at N = 100, scaling linearly with N); the error metric itself
% is only ~1% of an evaluation, so "sampled" vs "continuous" makes no
% practical speed difference. Lowering N above is the effective lever for a
% quicker exploratory run.
refine_physical = true;        % set false to stop after the reduced-dof fit

if refine_physical
    % fit_physical's parameter layout: [Ms(1..n), alpha(1..n), a(1..n)].
    seed_physical = [magnetic_parameters.Ms, magnetic_parameters.alpha, magnetic_parameters.a];

    BIG = 1e12;                            % finite stand-in for "unbounded"
    n_physical = 3 * number_components;
    physical_lb = -BIG * ones(n_physical, 1);   % Ms_i may be negative in a
    physical_ub =  BIG * ones(n_physical, 1);   % multicomponent model
    physical_select_fit = num2cell(true(n_physical, 1));   % all free

    [Ms_ref, alpha_ref, a_ref] = fit_physical(data_curve, seed_physical, N, error_type, ...
                                              physical_lb, physical_ub, physical_select_fit, ...
                                              [], solver);

    % Physical construction mode: hand MagneticParameters the fitted Ms /
    % alpha / a directly instead of deriving them from (Hcr, mcr, Hx).
    physical = struct('Ms', Ms_ref, 'alpha', alpha_ref, 'a', a_ref);
    magnetic_parameters = MagneticParameters(data_curve, [], [], [], [], physical);

    fprintf('\nRefined physical parameters ("reduce dof" unchecked):\n');
    for i = 1:number_components
        fprintf('   Component %d: Ms = %.6g A/m , a = %.6g A/m , alpha = %.6g\n', ...
                i, magnetic_parameters.Ms(i), magnetic_parameters.a(i), magnetic_parameters.alpha(i));
    end
    fprintf('   Total chi_in = %.6g\n', magnetic_parameters.chi_in_total);

    % Hcr / m(Hcr) / Hx are NOT re-derived from the refined parameters, so
    % from here on they are stale -- exactly as in the GUI, which greys out
    % the mathematical-parameters table in this mode.
end

%% --- 7) Build the modeled curve on a GUI-style log field grid -----------
[HTip, ~] = Utils().find_tip(data_curve.H, data_curve.M);
Hpos = data_curve.H(data_curve.H > 0);
Hhat = [0, logspace(log10(min(Hpos)), log10(HTip), N-1)];
modeled_curve = ModeledAnhystereticCurve(Hhat, magnetic_parameters);

%% --- 8) Report the fit errors -------------------------------------------
fprintf('\nFit errors (GUI options, evaluated on the displayed modeled curve):\n');
fprintf('   Selected objective: %s\n', error_type);
fprintf('   Diagonal (H, sampled)       = %.6g\n', DiagonalErrorCalculator(data_curve.H, data_curve.M, modeled_curve.H, modeled_curve.M, false, false).get_error());
fprintf('   Diagonal (H, continuous)    = %.6g\n', DiagonalErrorCalculator(data_curve.H, data_curve.M, modeled_curve.H, modeled_curve.M, false, true).get_error());
fprintf('   Diagonal (logH, sampled)    = %.6g\n', DiagonalErrorCalculator(data_curve.H, data_curve.M, modeled_curve.H, modeled_curve.M, true, false).get_error());
fprintf('   Diagonal (logH, continuous) = %.6g\n', DiagonalErrorCalculator(data_curve.H, data_curve.M, modeled_curve.H, modeled_curve.M, true, true).get_error());
fprintf('   Vertical                    = %.6g\n', VerticalErrorCalculator(data_curve.H, data_curve.M, modeled_curve.H, modeled_curve.M, true).get_error());
fprintf('   Horizontal                  = %.6g\n', HorizontalErrorCalculator(data_curve.H, data_curve.M, modeled_curve.H, modeled_curve.M, true).get_error());

%% --- 9) Plots ------------------------------------------------------------
% Colors: row 1 = total, rows 2..3 = the two components.
colors = [0.85 0.33 0.10;    % total (orange)
          0.00 0.45 0.74;    % component 1 (blue)
          0.47 0.67 0.19];   % component 2 (green)
plot_components = true;       % overlay each component's contribution
plot_grid       = true;

% Hcr marker lines: only meaningful while the distribution parameters are
% the ones behind the modeled curve (pass [] after a physical refinement).
if refine_physical
    hcr_markers = [];
else
    hcr_markers = Hcr;
end

plotter = Plotter(data_curve, modeled_curve, hcr_markers, colors, 8);

figure('Name', 'Demo 2 - Anhysteretic fit (2 components)');
tiledlayout(1, 2);

nexttile;
plotter.plot_M(gca, plot_components, plot_grid, 'M [A/m]');
title('M vs H (with components)');

nexttile;
plotter.plot_HdMdH_log(gca, plot_components, plot_grid, 'H dM/dH [A/m]');
title('H\cdotdM/dH vs H (semilog)');

fprintf('\nDone.\n');
