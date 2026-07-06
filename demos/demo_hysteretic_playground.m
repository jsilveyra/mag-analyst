%% demo_hysteretic_playground.m
%  Command-line demo of the MagAnalyst v2 HYSTERETIC (Jiles-Atherton) features:
%  forward simulation of the four Playground modes and modeling of a single
%  hysteretic region, all without the graphical user interface.
%
%  The anhysteretic-curve fitting workflow is showcased separately in
%  demo.m (one component) and demo_2_components.m (two components).
%
%  Everything here runs from the Jiles-Atherton parameters directly; the
%  GUI's "Hysteretic fitting" tab additionally *fits* these parameters to a
%  measured loop (see JAFitter for the programmatic fitter).
clc; clear; close all;

%% Bootstrap paths (run from anywhere)
demo_dir = fileparts(mfilename('fullpath'));
if isempty(demo_dir)
    demo_dir = pwd;
end
project_root = fileparts(demo_dir);
addpath(genpath(fullfile(project_root, 'src')));

%% Jiles-Atherton parameters
%  params is a struct with fields Ms, a, alpha, k, c (SI units; H, M in A/m).
%    Ms    - saturation magnetization [A/m]
%    a     - domain-wall density / shape parameter [A/m]
%    alpha - inter-domain coupling (mean-field) [-]
%    k     - pinning / hysteresis-loss parameter [A/m]
%    c     - reversibility coefficient in [0, 1]
params = struct('Ms', 8e5, 'a', 1e3, 'alpha', 1e-3, 'k', 1e3, 'c', 0.1);

Htip = 5e3;                                  % peak driving field [A/m]
opts = odeset('RelTol', 1e-7, 'AbsTol', 1e-6);

%% 1) Major hysteresis loop (starting from a demagnetized state)
% solveJA_majorLoop_playground(Hstart, Mstart, Htip, params, startMode, ...
%                              stopCriterion, repetitions, relTol, opts)
%   startMode      : "Demagnetized" | "Tip point (data)" | "User-defined"
%   stopCriterion  : "Fixed repetitions" | "Until convergence"
[Hmaj, Mmaj, infoMaj] = solveJA_majorLoop_playground( ...
    0, 0, Htip, params, "Demagnetized", "Fixed repetitions", 2, 1e-3, opts);

%% 2) Nested minor loops (tips sorted ascending by the solver)
% solveJA_minorLoop_playground(Htips, params, stopCriterion, repetitions, relTol, opts)
Htips = [Htip/3; 2*Htip/3; Htip];
[Hmin, Mmin, infoMin] = solveJA_minorLoop_playground( ...
    Htips, params, "Fixed repetitions", 2, 1e-3, opts);

%% 3) AC degaussing (decaying reversal envelope -> demagnetized state)
% solveJA_degaussing_playground(Hstart, Mstart, amplitudes, params, opts)
amplitudes = Htip * (0.8).^(0:6).';         % geometrically decaying peaks
[Hdeg, Mdeg, infoDeg] = solveJA_degaussing_playground( ...
    Htip, Mmaj(end), amplitudes, params, opts);

%% 4) Major loop with a harmonic (distorted) driving field
% H(theta) = sum_k amplitudes(k) * sin(orders(k)*theta + phases(k))
% solveJA_majorHarmonics_playground(Hstart, Mstart, orders, amplitudes, ...
%                                   phases, params, stopCriterion, ...
%                                   repetitions, relTol, opts, samplesPerPeriod)
orders     = [1; 2; 3];
harmAmps   = [Htip; 0.40*Htip; 0.60*Htip];
phases     = [0; pi/3; pi/4];
[Hharm, Mharm, infoHarm] = solveJA_majorHarmonics_playground( ...
    0, 0, orders, harmAmps, phases, params, "Fixed repetitions", 2, 1e-3, opts, 4000);

%% 5) Single monotonic branch from the core ODE solver (building block)
% solveJA_monotonic(Hstart, Hend, Mstart, params, delta, opts), delta=sign(dH)
[Hup, Mup] = solveJA_monotonic(-Htip, Htip, -Mmaj(end), params, +1, opts);

%% Plot everything
figure('Name', 'MagAnalyst - Jiles-Atherton Playground');
tiledlayout(2, 2);
nexttile; plot(Hmaj,  Mmaj,  'r-');  title('Major loop');            xlabel('H [A/m]'); ylabel('M [A/m]'); grid on;
nexttile; plot(Hmin,  Mmin,  'b-');  title('Nested minor loops');    xlabel('H [A/m]'); ylabel('M [A/m]'); grid on;
nexttile; plot(Hdeg,  Mdeg,  'k-');  title('Degaussing');            xlabel('H [A/m]'); ylabel('M [A/m]'); grid on;
nexttile; plot(Hharm, Mharm, 'm-');  title('Major loop w/ harmonics'); xlabel('H [A/m]'); ylabel('M [A/m]'); grid on;

fprintf('Major loop: %d cycles simulated, converged = %d\n', ...
    infoMaj.cyclesSimulated, infoMaj.converged);

%% Export the simulated curves to CSV (same writer the GUI uses)
% ExportUtils is a standalone helper usable outside the app.
out_dir = fullfile(tempdir, 'maganalyst_demo_out');
if ~exist(out_dir, 'dir'); mkdir(out_dir); end
ExportUtils.write_columns_csv(fullfile(out_dir, 'demo_major_loop.csv'), ...
    {'H [A/m]', 'M [A/m]'}, {Hmaj, Mmaj});
ExportUtils.write_columns_csv(fullfile(out_dir, 'demo_minor_loops.csv'), ...
    {'H [A/m]', 'M [A/m]'}, {Hmin, Mmin});
fprintf('Wrote CSV curves to %s\n', out_dir);
