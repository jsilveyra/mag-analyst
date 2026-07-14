%% demo_4_playground_major_loop.m
%  Programmatic MagAnalyst demo: PLAYGROUND forward simulation of a MAJOR
%  hysteresis loop from Jiles-Atherton parameters.
%
%  The Playground performs FORWARD simulations: given a set of JA parameters
%  (e.g. from demo_3's fit, or chosen by hand as below) it integrates the JA
%  ODE to produce M(H). The major-loop mode drives the field between +Htip
%  and -Htip and returns the full simulated history.
%
%  Run from anywhere:  >> demo_4_playground_major_loop
%
%  See also: demo_5 (minor loops), demo_6 (degaussing),
%            demo_7 (major loop with harmonics), demo_3 (fitting JA params).
clc; clear; close all;

%% --- Bootstrap -----------------------------------------------------------
demo_dir = fileparts(mfilename('fullpath'));
if isempty(demo_dir)
    demo_dir = pwd;
end
project_root = fileparts(demo_dir);
addpath(genpath(fullfile(project_root, 'src')));

%% --- Jiles-Atherton parameters ------------------------------------------
%  Illustrative values (soft-magnetic-like). Replace with fitted parameters
%  from demo_3 to simulate a real material.
%     Ms [A/m], a [A/m], alpha [-], k [A/m], c in [0,1]
params = struct('Ms', 8e5, 'a', 1e3, 'alpha', 1e-3, 'k', 1e3, 'c', 0.1);

Htip = 5e3;                                  % peak driving field [A/m]
opts = odeset('RelTol', 1e-7, 'AbsTol', 1e-6);

%% --- Simulation options --------------------------------------------------
% start_mode: initial magnetic state.
%   "Demagnetized"      -> start at (H, M) = (0, 0); the first magnetization
%                          branch (0 -> +Htip) is simulated internally.
%   "Tip point (data)"  -> start already saturated at the tip.
%   "User-defined"      -> start at the given (Hstart, Mstart).
start_mode = "Demagnetized";
Hstart = 0;                                  % used only for "User-defined"
Mstart = 0;

% stop_criterion: when to stop repeating the loop.
%   "Fixed repetitions" -> run exactly `repetitions` cycles.
%   "Until convergence" -> repeat until the loop closes to within rel_tol,
%                          capped at `max_repetitions` cycles.
stop_criterion = "Fixed repetitions";
repetitions     = 2;
rel_tol         = 1e-3;
max_repetitions = 20;

%% --- Run -----------------------------------------------------------------
% solve_ja_major_loop_playground(Hstart, Mstart, Htip, params, start_mode, ...
%                                stop_criterion, repetitions, rel_tol, ...
%                                max_repetitions, opts)
[Hmod, Mmod, info] = solve_ja_major_loop_playground( ...
    Hstart, Mstart, Htip, params, start_mode, ...
    stop_criterion, repetitions, rel_tol, max_repetitions, opts);

fprintf('\nMajor loop simulated: %d cycle(s), converged = %d\n', ...
        info.cycles_simulated, info.converged);

%% --- Plot ----------------------------------------------------------------
figure('Name', 'Demo 4 - Playground major loop');
plot(Hmod, Mmod, 'r-', 'LineWidth', 1.3);
xline(0, 'k-'); yline(0, 'k-');
grid on; box on;
xlabel('H [A/m]'); ylabel('M [A/m]');
title('Jiles-Atherton major loop (forward simulation)');

fprintf('Done.\n');
