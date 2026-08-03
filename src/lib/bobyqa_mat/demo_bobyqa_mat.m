function demo_bobyqa_mat()
%DEMO_BOBYQA_MAT  Worked examples for the bobyqa_mat solver.
%
%   demo_bobyqa_mat() runs four self-contained examples and prints the
%   results. No data files, no toolboxes, no arguments.
%
%     1. Unconstrained-in-practice minimisation (bounds wide enough not to bite)
%     2. A box whose bounds are ACTIVE at the solution
%     3. Live progress tracking and early stopping via options.output_fcn
%     4. The npt trade-off: 2n+1 vs the full quadratic on the same problem
%
%   See also BOBYQA_MAT, BOBYQA_MAT_TUNED, TEST_BOBYQA_MAT.

    addpath(fileparts(mfilename('fullpath')));

    example_1_basic();
    example_2_active_bounds();
    example_3_output_fcn();
    example_4_npt_tradeoff();
end

% ----------------------------------------------------------------------
function example_1_basic()
    header('1. Rosenbrock, bounds wide enough not to be active');

    % Classic Rosenbrock: minimum f = 0 at x = (1, 1).
    rosen = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;

    x0 = [-1.2; 1.0];
    [x, f, exitflag, nf] = bobyqa_mat_tuned(rosen, x0, [-5; -5], [5; 5]);

    fprintf('  x0       = [%8.4f, %8.4f]\n', x0);
    fprintf('  x        = [%8.4f, %8.4f]   (true minimum: [1, 1])\n', x);
    fprintf('  f        = %.3e             (true minimum: 0)\n', f);
    fprintf('  nf       = %d evaluations\n', nf);
    fprintf('  exitflag = %d  (%s)\n\n', exitflag, flag_text(exitflag));
end

% ----------------------------------------------------------------------
function example_2_active_bounds()
    header('2. Same objective, box that EXCLUDES the true minimum');

    % Now the box stops at 0.5, so the constrained minimum sits ON the
    % boundary: x1 = 0.5 (at its upper bound) and x2 = x1^2 = 0.25.
    rosen = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;

    lb = [-2; -2];
    ub = [0.5; 0.5];
    [x, f, exitflag, nf] = bobyqa_mat_tuned(rosen, [0; 0], lb, ub);

    fprintf('  bounds   = [%g, %g] x [%g, %g]\n', lb(1), ub(1), lb(2), ub(2));
    fprintf('  x        = [%8.4f, %8.4f]   (expected: [0.5, 0.25])\n', x);
    fprintf('  f        = %.6f              (expected: 0.25)\n', f);
    fprintf('  nf       = %d evaluations\n', nf);
    fprintf('  exitflag = %d  (%s)\n', exitflag, flag_text(exitflag));
    fprintf('  Note x1 landed exactly on its upper bound - fun is never\n');
    fprintf('  evaluated outside the box, so an objective that is undefined\n');
    fprintf('  outside its feasible region is safe here.\n\n');
end

% ----------------------------------------------------------------------
function example_3_output_fcn()
    header('3. Progress tracking and early stopping (output_fcn)');

    rosen = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;

    % The hook is called after EVERY evaluation of fun, using MATLAB's own
    % optimset OutputFcn convention: stop = output_fcn(x, optimValues, state).
    % Returning true aborts the search at the next evaluation.
    budget  = 40;
    history = [];

    function stop = record(~, optim_values, ~)
        history(end+1) = optim_values.fval; %#ok<AGROW>
        stop = optim_values.iteration >= budget;
    end

    options = struct('output_fcn', @record);
    [x, f, exitflag, nf] = bobyqa_mat_tuned(rosen, [-1.2; 1.0], [-5; -5], [5; 5], options);

    fprintf('  Stopped after %d evaluations (budget %d).\n', nf, budget);
    fprintf('  x        = [%8.4f, %8.4f]\n', x);
    fprintf('  f        = %.6e\n', f);
    fprintf('  exitflag = %d  (%s)\n', exitflag, flag_text(exitflag));

    % optimValues.fval is the value at the point JUST SAMPLED, which is often
    % a geometry-improving point that is expected to be worse. Take a running
    % minimum for a monotone convergence curve.
    best_so_far = cummin(history);
    fprintf('  Raw sampled values are non-monotone (%d of %d were worse than\n', ...
        sum(diff(history) > 0), numel(history) - 1);
    fprintf('  the previous sample) - that is normal, not a bug.\n');
    fprintf('  Running best: %.3e -> %.3e\n', best_so_far(1), best_so_far(end));
    fprintf('  x/f above hold the BEST point seen, not the last one sampled.\n\n');
end

% ----------------------------------------------------------------------
function example_4_npt_tradeoff()
    header('4. The npt trade-off at a fixed evaluation budget');

    % An n-dimensional smooth test objective (extended Rosenbrock).
    n = 8;
    fun = @(x) sum(100*(x(2:end) - x(1:end-1).^2).^2 + (1 - x(1:end-1)).^2);

    x0 = 0.5 * ones(n, 1);
    lb = -2 * ones(n, 1);
    ub =  2 * ones(n, 1);

    n_full = (n+1)*(n+2)/2;
    budget = 300;

    fprintf('  n = %d, budget = %d evaluations\n', n, budget);
    fprintf('  %-28s %12s %10s\n', 'npt', 'f', 'nf');

    for npt = [n+2, 2*n+1, n_full]
        options = struct('npt', npt, 'maxfun', budget);
        [~, f, ~, nf] = bobyqa_mat(fun, x0, lb, ub, options);
        label = sprintf('%d', npt);
        if npt == 2*n+1,   label = sprintf('%d  (2n+1)', npt); end
        if npt == n_full,  label = sprintf('%d  (full quadratic)', npt); end
        if npt == n+2,     label = sprintf('%d  (minimum allowed)', npt); end
        fprintf('  %-28s %12.3e %10d\n', label, f, nf);
    end

    fprintf('\n  A larger npt builds a richer model but spends npt evaluations\n');
    fprintf('  just to initialise it. At n > 6 that initialisation cost starts\n');
    fprintf('  eating the budget, which is why bobyqa_mat_tuned switches from\n');
    fprintf('  the full quadratic to 2n+1 there. Benchmark your own objective\n');
    fprintf('  if it sits near that boundary - the threshold is empirical.\n\n');
end

% ----------------------------------------------------------------------
function header(text)
    fprintf('\n%s\n%s\n', text, repmat('-', 1, numel(text)));
end

function s = flag_text(exitflag)
    switch exitflag
        case  0, s = 'converged: rho reached rhoend';
        case  3, s = 'maxfun budget exhausted';
        case -1, s = 'stopped by output_fcn';
        otherwise, s = 'unknown';
    end
end
