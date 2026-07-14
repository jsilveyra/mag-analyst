%% demo_6_playground_degaussing.m
%  Programmatic MagAnalyst demo: PLAYGROUND forward simulation of AC
%  DEGAUSSING (demagnetization) from Jiles-Atherton parameters.
%
%  Degaussing drives the sample through a sequence of field reversals whose
%  peak amplitude decays toward zero (the classic AC-demagnetization
%  envelope), finishing with a sweep back to H = 0. Starting from a
%  magnetized state, this leaves the sample close to demagnetized.
%
%  Run from anywhere:  >> demo_6_playground_degaussing
%
%  See also: demo_4 (major loop), demo_5 (minor loops), demo_7 (harmonics).
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

%% --- Starting state ------------------------------------------------------
% Begin from a saturated / remanent state so the demagnetization is visible.
% (Here: saturate to +Htip first, then degauss from that remanent point.)
Htip = 5e3;
[~, Msat] = solve_ja_monotonic(0, Htip, 0, params, +1, opts);   % 0 -> +Htip
Hstart = Htip;
Mstart = Msat(end);

%% --- Degaussing envelope -------------------------------------------------
% amplitudes: the sequence of positive peak reversal fields [A/m]. Order is
% irrelevant; the solver sorts them DESCENDING so the swing always decays.
% A geometric decay is typical:
amplitudes = Htip * (0.7).^(0:8).';        % 9 reversals: Htip, 0.7*Htip, ...

%% --- Run -----------------------------------------------------------------
% solve_ja_degaussing_playground(Hstart, Mstart, amplitudes, params, opts)
[Hmod, Mmod, info] = solve_ja_degaussing_playground( ...
    Hstart, Mstart, amplitudes, params, opts);

fprintf('\nDegaussing finished at (H, M) = (%.4g, %.4g) A/m\n', ...
        info.Hfinal, info.Mfinal);
fprintf('Residual |M| / Ms = %.3g\n', abs(info.Mfinal) / params.Ms);

%% --- Plot ----------------------------------------------------------------
figure('Name', 'Demo 6 - Playground degaussing');
plot(Hmod, Mmod, 'k-', 'LineWidth', 1.0);
xline(0, 'k-'); yline(0, 'k-');
grid on; box on;
xlabel('H [A/m]'); ylabel('M [A/m]');
title('Jiles-Atherton AC degaussing (forward simulation)');

fprintf('Done.\n');
