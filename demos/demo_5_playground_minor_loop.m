%% demo_5_playground_minor_loop.m
%  Programmatic MagAnalyst demo: PLAYGROUND forward simulation of nested
%  MINOR loops from Jiles-Atherton parameters.
%
%  Starting from a demagnetized state, the sample is cycled at a set of
%  increasing tip fields Htip_i. For each tip the field is looped
%  +Htip_i -> -Htip_i -> +Htip_i until a stop criterion is met, then the
%  field is bridged up to the next (larger) tip. The result is a family of
%  nested minor loops.
%
%  Run from anywhere:  >> demo_5_playground_minor_loop
%
%  See also: demo_4 (major loop), demo_6 (degaussing), demo_7 (harmonics).
clc; clear; close all;

%% --- Bootstrap -----------------------------------------------------------
demo_dir = fileparts(mfilename('fullpath'));
if isempty(demo_dir)
    demo_dir = pwd;
end
project_root = fileparts(demo_dir);
addpath(genpath(fullfile(project_root, 'src')));

%% --- Jiles-Atherton parameters ------------------------------------------
% Illustrative values; replace with fitted parameters from demo_3.
params = struct('Ms', 8e5, 'a', 1e3, 'alpha', 1e-3, 'k', 1e3, 'c', 0.1);
opts   = odeset('RelTol', 1e-7, 'AbsTol', 1e-6);

%% --- Simulation options --------------------------------------------------
% Htips: the minor-loop tip fields [A/m]. Order is irrelevant; the solver
% sorts them ascending and starts from the SMALLEST tip (demagnetized), then
% bridges up to each larger tip in turn.
Htip  = 5e3;
Htips = [Htip/3; 2*Htip/3; Htip];

% stop_criterion per tip:
%   "Fixed repetitions" -> exactly `repetitions` loops at each tip.
%   "Until convergence" -> loop until the returning +Htip magnetization
%                          settles within rel_tol, capped at max_repetitions.
stop_criterion  = "Fixed repetitions";
repetitions     = 3;
rel_tol         = 1e-3;
max_repetitions = 20;

%% --- Run -----------------------------------------------------------------
% solve_ja_minor_loop_playground(Htips, params, stop_criterion, ...
%                                repetitions, rel_tol, max_repetitions, opts)
[Hmod, Mmod, info] = solve_ja_minor_loop_playground( ...
    Htips, params, stop_criterion, repetitions, rel_tol, max_repetitions, opts);

fprintf('\nMinor loops simulated for %d tips.\n', numel(info.tip_ends));
fprintf('Total cycles simulated: %d\n', info.cycles_simulated);

%% --- Plot ----------------------------------------------------------------
% `info` carries per-tip bookkeeping. To draw only the LAST closed loop of
% each tip (the GUI's "Last loops only" option), slice
% info.tip_last_loop_starts(i) .. info.tip_ends(i) per tip. Here we simply
% draw the full concatenated history.
figure('Name', 'Demo 5 - Playground minor loops');
plot(Hmod, Mmod, 'b-', 'LineWidth', 1.0);
xline(0, 'k-'); yline(0, 'k-');
grid on; box on;
xlabel('H [A/m]'); ylabel('M [A/m]');
title('Jiles-Atherton nested minor loops (forward simulation)');

fprintf('Done.\n');
