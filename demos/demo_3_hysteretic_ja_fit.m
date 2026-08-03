%% demo_3_hysteretic_ja_fit.m
%  Programmatic MagAnalyst demo: HYSTERETIC (Jiles-Atherton) fit, seeded
%  from a single-component ANHYSTERETIC fit.
%
%  This mirrors the "Hysteretic fitting" tab, using its default settings:
%  Fitting region = "Entire loop", Error to minimize = "Diagonal (H,
%  continuous)", "Constrained by Hc" checked. The workflow is:
%     1. Import the measured hysteresis loop and fit the anhysteretic
%        (distribution) model with ONE component, to get physically
%        meaningful seeds for the JA saturation Ms, shape a and mean-field
%        coupling alpha.
%     2. Extract the measured descending ("left") branch, then reflect it
%        into a full, point-symmetric measured cycle (both branches).
%     3. Seed the remaining JA parameters: the reversibility c, and the
%        pinning parameter k estimated from the coercive point.
%     4. Configure the JA fit (mask, bounds, objective, simulated region).
%     5. Fit the JA parameters to the full measured cycle, with k
%        "Constrained by Hc" (recomputed each iteration, not free).
%     6. OPTIONAL refinement: uncheck "Constrained by Hc" and fit again,
%        now with k a free parameter seeded from the step-5 result.
%     7. Plot the measured vs. modeled loop.
%
%  Jiles-Atherton parameters (SI; H, M in A/m):
%     Ms    - saturation magnetization                 [A/m]
%     a     - domain-wall shape / density parameter    [A/m]
%     alpha - inter-domain mean-field coupling         [-]
%     k     - pinning / hysteresis-loss parameter      [A/m]
%     c     - reversibility coefficient, in [0, 1]     [-]
%
%  Run from anywhere:  >> demo_3_hysteretic_ja_fit
%
%  See also: demo_1_anhysteretic_1comp (the anhysteretic fit reused for
%            seeds) and demo_4..7 (forward JA Playground simulations).
clc; clear; close all;

%% --- Bootstrap -----------------------------------------------------------
demo_dir = fileparts(mfilename('fullpath'));
if isempty(demo_dir)
    demo_dir = pwd;
end
project_root = fileparts(demo_dir);
addpath(genpath(fullfile(project_root, 'src')));

pc = ParserConstants();
data_file = fullfile(project_root, 'data', 'sample_data', '2022_AIP', 'MnZn_ferrite.csv');

% solver: the optimizer used for BOTH fits below ("prima" [default,
% PRIMA-BOBYQA with tuned npt] or "nelder_mead" [minimize()] -- see
% demo_1 for the full explanation, and src/lib/bobyqa_mat/README.md for the
% benchmark behind the default). Mirrors the GUI's "Solver" dropdown, which
% each fitting tab sets independently.
solver = "prima";

% Units of the source file (used both for the anhysteretic import and for
% re-converting the raw loop below). For mass magnetization data, use
% pc.SIGMA_ELECTROMAGNETIC_UNIT_PER_GRAM for the y-axis unit.
H_unit = pc.H_AMPERE_PER_METER;
M_unit = pc.B_TESLA;

%% --- 1) Anhysteretic 1-component fit -> Ms, a, alpha seeds ---------------
% (Identical to demo_1; only the resulting Ms/a/alpha are reused here.)
parser = Parser(data_file, H_unit, M_unit, pc.HYSTERESIS_LOOP_TYPE, 50);  % the GUI's N° of points default
[H, M, H_raw, M_raw] = parser.import();
data_curve = DataAnhystereticCurve(H, M);

[Hcr_seed, mcr_seed, Hx_seed] = retrieve_anhysteretic_seeds(data_curve, 1);
seed_anh    = [Hcr_seed, mcr_seed, Hx_seed];
select_a    = "low";
anh_error_type = "Diagonal (logH, continuous)";  % Anhysteretic tab default
[Hcr, mcr, Hx] = fit(data_curve, seed_anh, 100, select_a, ...
                     anh_error_type, [0 0.4496], [Inf 1], {true true}, [], solver);
mp = MagneticParameters(data_curve, Hcr, mcr, Hx, select_a);

Ms_seed    = mp.Ms;        % [A/m]
a_seed     = mp.a;         % [A/m]
alpha_seed = mp.alpha;     % [-]

fprintf('\nSeeds from the anhysteretic fit:\n');
fprintf('   Ms    = %.6g A/m\n', Ms_seed);
fprintf('   a     = %.6g A/m\n', a_seed);
fprintf('   alpha = %.6g\n',     alpha_seed);

%% --- 2) Build the full measured cycle from the left branch ---------------
% "Entire loop" fitting compares against a full, point-symmetric cycle. We
% call the SAME function the app uses to build it,
% HystereticUtils.build_ja_data_cycle_core, rather than reimplementing it:
% it re-converts the RAW loop columns to A/m (keeping both branches, unlike
% the folded anhysteretic curve above), extracts a uniformly arc-length-
% sampled descending (left) branch of n_left points, and reflects it into a
% symmetric cycle. n_left = 50 is the GUI's N° of points default. It also
% returns the left branch (Hleft/Mleft) on its own.
n_left = 50;
[H_cycle, M_cycle, Hleft, Mleft] = HystereticUtils.build_ja_data_cycle_core( ...
    H_raw, M_raw, H_unit, M_unit, n_left);

% Raw measured loop (both branches, in A/m) for the comparison plot only.
[H_raw_cycle, M_raw_cycle] = UnitConvertor().convert_H_M(H_raw, H_unit, M_raw, M_unit);

% Loop tip (highest-M point) -> the JA branch is simulated from here.
[Htip, Mtip] = Utils().find_tip(Hleft, Mleft);

%% --- 3) Seed the remaining JA parameters (c and k) ----------------------
c_seed = 1/3;                                    % conventional starting value

% k is seeded from the slope of the loop at its coercive point. This helper
% is a plain static method (its first `app` argument is unused, so pass []).
try
    k_seed = HystereticUtils.estimate_k_from_coercive_point( ...
        [], Hleft, Mleft, Ms_seed, a_seed, alpha_seed, c_seed);
catch
    k_seed = a_seed;                             % fallback if the estimate fails
end
if ~isfinite(k_seed) || k_seed <= 0
    k_seed = a_seed;
end

params_seed = struct('Ms', Ms_seed, 'a', a_seed, 'alpha', alpha_seed, ...
                     'k', k_seed, 'c', c_seed);

fprintf('\nInitial JA parameter seeds:\n');
disp(params_seed);

%% --- 4) Configure the JA fit --------------------------------------------
% mask: which parameters are free. Fields:
%   fit_Ms, fita, fitalpha, fitc  - optimize Ms / a / alpha / c
%   fitk                          - optimize k directly
%   k_dependent                   - if true, k is NOT free but recomputed
%                                   from the coercive-point estimate on every
%                                   iteration (mutually exclusive with fitk)
% This mask/bounds pair matches the Hysteretic tab's own defaults exactly:
% "Constrained by Hc" is checked by default, so k is not a free parameter
% here. Step 6 re-runs the fit with that constraint released.
mask = struct('fit_Ms', true, 'fita', true, 'fitalpha', true, ...
              'fitc', true, 'fitk', false, 'k_dependent', true);

% bounds: [lower, upper] per parameter. These match the tab's own default
% bound-field values: Ms >= Mtip, a >= 0, alpha unconstrained (it may be
% negative -- see MagneticParameters), c in [0, 1], k >= 0 (moot here since
% k is not free).
bounds = struct( ...
    'Ms',    [Mtip, Inf], ...
    'a',     [0,    Inf], ...
    'alpha', [-Inf, Inf], ...
    'c',     [0,    1], ...
    'k',     [0,    Inf]);

% error_type minimized against the fitted region. Options handled by the JA
% error core: "Diagonal (H, sampled)" | "Diagonal (H, continuous)" |
% "Vertical" | "Horizontal". "Diagonal (H, continuous)" is the tab's default.
error_type = "Diagonal (H, continuous)";

opts = odeset('RelTol', 1e-7, 'AbsTol', 1e-6);

% fitting_region = "Entire loop" (the tab's default): the model is cycled
% +Htip -> -Htip -> +Htip repeatedly from a demagnetized start, and the last
% cycle is compared against the full measured cycle (H_cycle, M_cycle) built
% in step 2 -- not just the left branch. stop_criterion/repetitions (here,
% 1 repetition -- the tab's own default) control how many cycles are
% simulated before that last one is used for the fit.
model_fn = @(p) solve_ja_hysteretic_region( ...
    Htip, Mtip, p, "Demagnetized", "Entire loop", ...
    "Fixed repetitions", 1, 1e-3, 10, opts);

% estimate_k_fn: consulted every iteration since mask.k_dependent is true
% (k is "Constrained by Hc", not free). error_core_fn: scores model vs.
% data. Both are static helpers whose leading `app` argument is unused
% (pass []).
estimate_k_fn = @(p) HystereticUtils.estimate_k_from_coercive_point( ...
    [], Hleft, Mleft, p.Ms, p.a, p.alpha, p.c);
error_core_fn = @(et, hL, mL, hHat, mHat) ...
    HystereticUtils.compute_ja_left_branch_error_core([], et, hL, mL, hHat, mHat);

%% --- 5) Run the JA fit ---------------------------------------------------
% JAFitter.fit(params_seed, mask, bounds, Hdata, Mdata, Htip, Mtip, ...
%              error_type, estimate_k_fn, model_fn, error_core_fn, ...
%              output_fcn, solver)
% Hdata/Mdata is the full measured cycle (both branches), matching "Entire
% loop" fitting_region.
result = JAFitter.fit(params_seed, mask, bounds, H_cycle, M_cycle, Htip, Mtip, ...
                      error_type, estimate_k_fn, model_fn, error_core_fn, [], solver);

if ~result.ok
    error('JA fit failed: %s', result.error_message);
end

p_opt = result.params_opt;
fprintf('\nFitted JA parameters:\n');
fprintf('   Ms    = %.6g A/m\n', p_opt.Ms);
fprintf('   a     = %.6g A/m\n', p_opt.a);
fprintf('   alpha = %.6g\n',     p_opt.alpha);
fprintf('   k     = %.6g A/m\n', p_opt.k);
fprintf('   c     = %.6g\n',     p_opt.c);
fprintf('   error : seed = %.6g  ->  optimized = %.6g\n', result.Jseed, result.Jopt);

%% --- 6) OPTIONAL: refine with k as a free parameter ---------------------
% This is the GUI's "uncheck 'Constrained by Hc' and fit again" second stage
% -- the Hysteretic tab suggests it in the Messages panel after every
% constrained fit ("Tip: uncheck 'Constrained by Hc' and fit again to
% further refine the JA model parameters.").
%
% In step 5 k was never a free parameter: it was recomputed from the
% measured coercive point on every iteration, so the modeled loop was forced
% to reproduce Hc exactly and the search ran over four parameters only.
% Releasing that constraint gives the optimizer a fifth degree of freedom
% (k), which can lower the overall loop error at the cost of no longer
% matching Hc exactly. Note the two masks are mutually exclusive:
% k_dependent = false and fitk = true.
%
% The refinement is seeded from the step-5 optimum, and JAFitter keeps a
% seed guard, so the error can only improve or stay equal -- never worsen.
refine_free_k = true;          % set false to stop after the constrained fit

p_final = p_opt;
if refine_free_k
    mask_refine = struct('fit_Ms', true, 'fita', true, 'fitalpha', true, ...
                         'fitc', true, 'fitk', true, 'k_dependent', false);

    % Same bounds, objective, model and solver as step 5; only the mask and
    % the seed change. bounds.k = [0, Inf] now actually applies, since k is
    % a searched parameter rather than a derived one.
    result_refine = JAFitter.fit(p_opt, mask_refine, bounds, H_cycle, M_cycle, Htip, Mtip, ...
                                 error_type, estimate_k_fn, model_fn, error_core_fn, [], solver);

    if result_refine.ok
        p_final = result_refine.params_opt;
        fprintf('\nRefined JA parameters (k free, "Constrained by Hc" unchecked):\n');
        fprintf('   Ms    = %.6g A/m\n', p_final.Ms);
        fprintf('   a     = %.6g A/m\n', p_final.a);
        fprintf('   alpha = %.6g\n',     p_final.alpha);
        fprintf('   k     = %.6g A/m\n', p_final.k);
        fprintf('   c     = %.6g\n',     p_final.c);
        fprintf('   error : constrained = %.6g  ->  refined = %.6g\n', ...
                result_refine.Jseed, result_refine.Jopt);
    else
        warning('JA refinement failed (%s); keeping the constrained fit.', ...
                result_refine.error_message);
        refine_free_k = false;
    end
end

%% --- 7) Plot measured vs. modeled ---------------------------------------
% Modeled full cycle (last of the "Entire loop" repetitions) from the
% fitted parameters, using the same model_fn the fit itself minimized.
[Hmodel_cycle, Mmodel_cycle] = model_fn(p_final);

figure('Name', 'Demo 3 - Jiles-Atherton fit');
hold on;
plot(H_raw_cycle, M_raw_cycle, '.', 'Color', [0.6 0.6 0.6], 'MarkerSize', 6, ...
     'DisplayName', 'Measured loop (raw)');
plot(H_cycle, M_cycle, '.', 'Color', [0 0 0], 'MarkerSize', 8, ...
     'DisplayName', 'Measured loop (symmetrized, fitted)');
if refine_free_k
    % Overlay the step-5 constrained fit for comparison.
    [Hmodel_c, Mmodel_c] = model_fn(p_opt);
    plot(Hmodel_c, Mmodel_c, '--', 'Color', [0 0.45 0.74], 'LineWidth', 1.2, ...
         'DisplayName', 'JA fit (k constrained by Hc)');
    model_label = 'JA fit (k refined)';
else
    model_label = 'JA fit (entire loop)';
end
plot(Hmodel_cycle, Mmodel_cycle, 'r-', 'LineWidth', 1.4, 'DisplayName', model_label);
xline(0, 'k-'); yline(0, 'k-');
grid on; box on;
xlabel('H [A/m]'); ylabel('M [A/m]');
title('Measured loop vs. Jiles-Atherton fit');
legend('Location', 'best');
hold off;

fprintf('\nDone.\n');
