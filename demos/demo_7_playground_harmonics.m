%% demo_7_playground_harmonics.m
%  Programmatic MagAnalyst demo: PLAYGROUND forward simulation of a MAJOR
%  loop driven by a DISTORTED (harmonic) field, from Jiles-Atherton
%  parameters.
%
%  Instead of a pure sinusoid, the applied field is a Fourier series over one
%  period theta in [0, 2*pi):
%
%       H(theta) = sum_j amplitudes(j) * sin(orders(j)*theta + phases(j))
%
%  Because the JA model is rate-independent, only the field's turning points
%  matter: the extra extrema introduced by the harmonics create minor loops
%  nested inside the major loop.
%
%  Run from anywhere:  >> demo_7_playground_harmonics
%
%  See also: demo_4 (undistorted major loop), demo_5 (minor loops),
%            demo_6 (degaussing).
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

%% --- Harmonic driving field ---------------------------------------------
% One row per harmonic term. orders are the integer harmonic numbers, with
% matching amplitudes [A/m] and phases [rad]. Row 1 is the fundamental.
% A strong 2nd harmonic breaks the top/bottom symmetry, giving asymmetric
% nested minor loops.
Htip       = 5e3;
orders     = [1;        2;         3];
amplitudes = [Htip;     0.40*Htip; 0.60*Htip];
phases     = [0;        pi/3;      pi/4];       % [rad]

%% --- Steady-state / stop options ----------------------------------------
% stop_criterion:
%   "Fixed repetitions" -> simulate exactly `repetitions` full periods.
%   "Until convergence" -> repeat periods until the loop closes to within
%                          rel_tol (capped internally at 200 periods).
stop_criterion = "Fixed repetitions";
repetitions    = 2;
rel_tol        = 1e-3;

% Starting point of the very first period. Same semantics as the major loop:
%   "Demagnetized" | "Tip point (data)" | "User-defined".
Hstart = 0;                                     % (used for "User-defined")
Mstart = 0;

% samples_per_period: dense grid used to locate the field's turning points
% within one period. Higher = more accurately captures closely-spaced
% harmonic extrema.
samples_per_period = 4000;

%% --- Run -----------------------------------------------------------------
% solve_ja_major_harmonics_playground(Hstart, Mstart, orders, amplitudes, ...
%     phases, params, stop_criterion, repetitions, rel_tol, opts, ...
%     samples_per_period)
[Hmod, Mmod, info] = solve_ja_major_harmonics_playground( ...
    Hstart, Mstart, orders, amplitudes, phases, params, ...
    stop_criterion, repetitions, rel_tol, opts, samples_per_period);

fprintf('\nHarmonic major loop simulated: %d period(s), converged = %d\n', ...
        info.cycles_simulated, info.converged);
fprintf('Field turning points per period: %d\n', numel(info.vertices));

%% --- Plot ----------------------------------------------------------------
figure('Name', 'Demo 7 - Playground major loop with harmonics');
tiledlayout(1, 2);

% The applied field waveform over one period (for reference).
theta = linspace(0, 2*pi, samples_per_period).';
Hwave = zeros(size(theta));
for j = 1:numel(orders)
    Hwave = Hwave + amplitudes(j) * sin(orders(j)*theta + phases(j));
end
nexttile;
plot(theta, Hwave, 'b-', 'LineWidth', 1.2);
grid on; box on;
xlabel('\theta [rad]'); ylabel('H [A/m]');
xlim([0 2*pi]);
title('Distorted driving field H(\theta)');

nexttile;
plot(Hmod, Mmod, 'r-', 'LineWidth', 1.1);
xline(0, 'k-'); yline(0, 'k-');
grid on; box on;
xlabel('H [A/m]'); ylabel('M [A/m]');
title('M vs H (nested minor loops)');

fprintf('Done.\n');
