function pass = test_bobyqa_mat()
%TEST_BOBYQA_MAT  Self-check that bobyqa_mat is installed and working.
%
%   test_bobyqa_mat() runs a set of assertions and prints PASS/FAIL per test.
%   pass = test_bobyqa_mat() also returns true if every test passed.
%
%   No toolboxes, no data files, no arguments. Runs in a couple of seconds.
%
%   See also BOBYQA_MAT, BOBYQA_MAT_TUNED, DEMO_BOBYQA_MAT.

    addpath(fileparts(mfilename('fullpath')));

    tests = { ...
        'quadratic reaches the exact minimum',      @t_quadratic;         ...
        'rosenbrock converges',                     @t_rosenbrock;        ...
        'active bounds are respected',              @t_active_bounds;     ...
        'fun is never called outside the box',      @t_feasible_only;     ...
        'empty and scalar bounds are accepted',     @t_bound_forms;       ...
        'x0 outside the box is clipped in',         @t_x0_clipped;        ...
        'row-vector x0 round-trips (tuned)',        @t_shape_row;         ...
        'maxfun is honoured, exitflag = 3',         @t_maxfun;            ...
        'output_fcn stops early, exitflag = -1',    @t_output_fcn;        ...
        'output_fcn returns the best point seen',   @t_output_fcn_best;   ...
        'npt is clipped into its legal range',      @t_npt_clipping;      ...
        'badly scaled variables are handled',       @t_scaling;           ...
        'non-finite objective values survive',      @t_nonfinite;         ...
        };

    n_tests = size(tests, 1);
    results = false(n_tests, 1);

    fprintf('\ntest_bobyqa_mat\n%s\n', repmat('=', 1, 60));
    for i = 1:n_tests
        name = tests{i, 1};
        try
            tests{i, 2}();
            results(i) = true;
            fprintf('  PASS  %s\n', name);
        catch err
            fprintf('  FAIL  %s\n          %s\n', name, err.message);
        end
    end

    fprintf('%s\n%d/%d passed.\n\n', repmat('=', 1, 60), sum(results), n_tests);
    if nargout > 0
        pass = all(results);
    elseif ~all(results)
        error('test_bobyqa_mat:Failed', '%d test(s) failed.', sum(~results));
    end
end

% ======================================================================
function t_quadratic()
    % A separable quadratic is exactly representable by the interpolation
    % model, so the solver should nail it.
    target = [1.5; -0.5; 3.0];
    fun = @(x) sum((x - target).^2);

    [x, f] = bobyqa_mat_tuned(fun, [0; 0; 0], -10*ones(3,1), 10*ones(3,1));

    assert_close(x, target, 1e-5, 'x');
    assert(f < 1e-9, sprintf('f = %g, expected < 1e-9', f));
end

function t_rosenbrock()
    fun = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
    [x, f, exitflag] = bobyqa_mat_tuned(fun, [-1.2; 1.0], [-5; -5], [5; 5]);

    assert_close(x, [1; 1], 1e-3, 'x');
    assert(f < 1e-6, sprintf('f = %g, expected < 1e-6', f));
    assert(exitflag == 0, sprintf('exitflag = %d, expected 0', exitflag));
end

function t_active_bounds()
    % Constrained minimum sits on the boundary: x = (0.5, 0.25), f = 0.25.
    fun = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
    [x, f] = bobyqa_mat_tuned(fun, [0; 0], [-2; -2], [0.5; 0.5]);

    assert_close(x, [0.5; 0.25], 1e-3, 'x');
    assert(abs(f - 0.25) < 1e-4, sprintf('f = %g, expected 0.25', f));
end

function t_feasible_only()
    % Every point handed to fun must satisfy the bounds, so an objective that
    % is undefined outside them is safe.
    lb = [-1; -1];
    ub = [ 2;  0.5];
    violations = 0;

    function y = guarded(x)
        if any(x < lb - 1e-12) || any(x > ub + 1e-12)
            violations = violations + 1;
        end
        y = 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
    end

    bobyqa_mat_tuned(@guarded, [0; 0], lb, ub);
    assert(violations == 0, sprintf('%d evaluations fell outside the box', violations));
end

function t_bound_forms()
    fun = @(x) sum((x - [0.3; 0.7]).^2);

    % [] means unbounded.
    [x1, f1] = bobyqa_mat_tuned(fun, [0; 0], [], []);
    assert_close(x1, [0.3; 0.7], 1e-4, 'x (empty bounds)');
    assert(isfinite(f1), 'f is not finite with empty bounds');

    % Scalar bounds expand to every variable.
    [x2, ~] = bobyqa_mat_tuned(fun, [0; 0], -1, 1);
    assert_close(x2, [0.3; 0.7], 1e-4, 'x (scalar bounds)');

    % Mixed: one side empty.
    [x3, ~] = bobyqa_mat_tuned(fun, [0; 0], [], [1; 1]);
    assert_close(x3, [0.3; 0.7], 1e-4, 'x (one-sided bounds)');
end

function t_x0_clipped()
    % x0 outside the box must be pulled in, not passed to fun as given.
    lb = [0; 0];
    ub = [1; 1];
    fun = @(x) sum((x - [0.5; 0.5]).^2);

    [x, ~] = bobyqa_mat_tuned(fun, [5; -5], lb, ub);
    assert(all(x >= lb - 1e-12 & x <= ub + 1e-12), 'returned x is outside the box');
    assert_close(x, [0.5; 0.5], 1e-4, 'x');
end

function t_shape_row()
    % bobyqa_mat_tuned is shape-transparent: a row x0 gives a row x, and fun
    % always sees a row. (bobyqa_mat itself always returns a column.)
    target = [1.5, -0.5];
    saw_column = false;

    function y = shape_checked(x)
        if size(x, 1) ~= 1, saw_column = true; end
        y = sum((x - target).^2);
    end

    [x, ~] = bobyqa_mat_tuned(@shape_checked, [0, 0], [-5, -5], [5, 5]);

    assert(isrow(x), 'x is not a row vector though x0 was');
    assert(~saw_column, 'fun received a column though x0 was a row');
    assert_close(x(:), target(:), 1e-4, 'x');

    % The unwrapped solver documents the opposite: always a column.
    xc = bobyqa_mat(@(z) sum((z(:).' - target).^2), [0, 0], [-5, -5], [5, 5]);
    assert(iscolumn(xc), 'bobyqa_mat should always return a column vector');
end

function t_maxfun()
    fun = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
    budget = 25;
    [~, ~, exitflag, nf] = bobyqa_mat(fun, [-1.2; 1.0], [-5; -5], [5; 5], ...
        struct('maxfun', budget));

    assert(nf <= budget, sprintf('nf = %d exceeded maxfun = %d', nf, budget));
    assert(exitflag == 3, sprintf('exitflag = %d, expected 3 (maxfun)', exitflag));
end

function t_output_fcn()
    fun = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
    cap = 20;
    n_calls = 0;

    function stop = hook(x, optim_values, state)
        n_calls = n_calls + 1;
        assert(strcmp(state, 'iter'), 'state should always be ''iter''');
        assert(numel(x) == 2, 'hook received a wrongly sized point');
        assert(isscalar(optim_values.fval), 'optimValues.fval should be scalar');
        assert(optim_values.iteration == n_calls, ...
            'optimValues.iteration should count evaluations');
        stop = optim_values.iteration >= cap;
    end

    [~, ~, exitflag, nf] = bobyqa_mat_tuned(fun, [-1.2; 1.0], [-5; -5], [5; 5], ...
        struct('output_fcn', @hook));

    assert(exitflag == -1, sprintf('exitflag = %d, expected -1 (stopped)', exitflag));
    assert(nf == cap, sprintf('nf = %d, expected %d', nf, cap));
end

function t_output_fcn_best()
    % On an early stop, x/f must be the BEST point seen across the whole run,
    % not whichever point happened to be sampled last.
    fun = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
    best_f = Inf;
    last_f = NaN;

    function stop = hook(~, optim_values, ~)
        last_f = optim_values.fval;
        best_f = min(best_f, last_f);
        stop = optim_values.iteration >= 30;
    end

    [x, f] = bobyqa_mat_tuned(fun, [-1.2; 1.0], [-5; -5], [5; 5], ...
        struct('output_fcn', @hook));

    assert(abs(f - best_f) <= 1e-12 * max(1, abs(best_f)), ...
        sprintf('returned f = %g but best seen was %g', f, best_f));
    assert(abs(fun(x) - f) <= 1e-12 * max(1, abs(f)), 'f does not match fun(x)');
end

function t_npt_clipping()
    % Out-of-range npt must be clipped, not error out.
    fun = @(x) sum((x - [0.3; 0.7; -0.2]).^2);
    x0 = zeros(3, 1);

    for npt = [1, 4, 10, 999]   % legal range for n=3 is 5..10
        [x, f] = bobyqa_mat(fun, x0, -2*ones(3,1), 2*ones(3,1), struct('npt', npt));
        assert(all(isfinite(x)) && isfinite(f), ...
            sprintf('npt = %d produced a non-finite result', npt));
        assert_close(x, [0.3; 0.7; -0.2], 1e-4, sprintf('x (npt = %d)', npt));
    end
end

function t_scaling()
    % Variables differing by 6 orders of magnitude, with no manual rescaling:
    % the internal per-variable scaling should absorb this.
    target = [2.5e4; 3.0e-2];
    fun = @(x) ((x(1) - target(1))/target(1))^2 + ((x(2) - target(2))/target(2))^2;

    x0 = [1.0e4; 1.0e-2];
    [x, f] = bobyqa_mat_tuned(fun, x0, [1e3; 1e-3], [1e5; 1e-1]);

    assert(abs(x(1) - target(1))/target(1) < 1e-3, ...
        sprintf('x(1) = %g, expected %g', x(1), target(1)));
    assert(abs(x(2) - target(2))/target(2) < 1e-3, ...
        sprintf('x(2) = %g, expected %g', x(2), target(2)));
    assert(f < 1e-6, sprintf('f = %g, expected < 1e-6', f));
end

function t_nonfinite()
    % An objective returning Inf in part of the box must not crash the solver,
    % and must not be reported as the best point.
    target = [0.5; 0.5];
    function y = spiky(x)
        if x(1) > 0.8
            y = Inf;
        else
            y = sum((x - target).^2);
        end
    end

    [x, f] = bobyqa_mat_tuned(@spiky, [0.1; 0.1], [0; 0], [1; 1]);

    assert(isfinite(f), 'returned a non-finite f');
    assert_close(x, target, 1e-3, 'x');
end

% ======================================================================
function assert_close(actual, expected, tol, label)
    actual = actual(:); expected = expected(:);
    assert(numel(actual) == numel(expected), ...
        sprintf('%s: size mismatch (%d vs %d)', label, numel(actual), numel(expected)));
    err = max(abs(actual - expected));
    assert(err <= tol, sprintf('%s: max error %g exceeds tolerance %g', label, err, tol));
end
