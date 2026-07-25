function [x, f, exitflag, nf] = bobyqa_prima_tuned(fun, x0, lb, ub, options)
%BOBYQA_PRIMA_TUNED  bobyqa_prima with npt chosen automatically from problem
%   size, plus an optimset-style progress/early-stop hook.
%
%   [x, f, exitflag, nf] = bobyqa_prima_tuned(fun, x0, lb, ub, options)
%
%   Minimises fun(x) subject to lb <= x <= ub starting from x0, exactly like
%   bobyqa_prima (see bobyqa_prima.m), except:
%
%   1. npt (the number of points bobyqa_prima's quadratic model interpolates)
%      is picked from n = numel(x0) instead of defaulting to one fixed value:
%
%           npt = (n+1)(n+2)/2   (full quadratic)   if n <= 6
%           npt = 2*n + 1                            if n >  6
%
%      This threshold is an empirical rule of thumb, not a general
%      theoretical result. It was found by benchmarking bobyqa_prima against
%      Nelder-Mead (minimize()) on real curve-fitting objectives at n = 5
%      and n = 11: at n = 5, full-quadratic reached the best accuracy using
%      fewer evaluations than either 2n+1 or minimize(); at n = 11, 2n+1
%      reached roughly twice the accuracy of full-quadratic (or minimize())
%      at an equal, fixed evaluation budget, because the full-quadratic
%      model's initialization cost (n(n)/2-order function evaluations before
%      any real trust-region progress) starts to dominate the budget. n = 6
%      is simply the midpoint chosen between the two tested sizes; the exact
%      crossover was not located more precisely. See references [1]-[3] for
%      the general (n-independent) version of this trade-off, and
%      docs/solvers.md in this repository for the full benchmark data.
%
%   2. options.output_fcn, if given, is called after every function
%      evaluation as
%
%           stop = output_fcn(x, optimValues, state)
%
%      matching the calling convention of MATLAB's own optimset OutputFcn
%      (state is always the literal string 'iter'; optimValues.fval is that
%      evaluation's objective value and optimValues.iteration is the
%      evaluation count so far). Returning true aborts the search early. The
%      best point evaluated at any point during the search -- not
%      necessarily bobyqa_prima's own final iterate -- is returned in x/f.
%
%   options (all optional): rhobeg, rhoend, maxfun (forwarded to
%   bobyqa_prima), npt (overrides the automatic choice above), output_fcn.
%
%   Shape handling: like minimize(), this function preserves x0's original
%   orientation (row or column). fun and output_fcn are always called with a
%   point shaped exactly like x0, and x is returned in that same shape --
%   regardless of the fact that bobyqa_prima itself always works internally
%   in column-vector form. (bobyqa_prima.m's own return value is NOT
%   shape-preserving; call it directly only if you also handle that.)
%
%   See also bobyqa_prima.
%
%   References:
%   [1] M.J.D. Powell, "The BOBYQA algorithm for bound constrained
%       optimization without derivatives," Report DAMTP 2009/NA06,
%       University of Cambridge, 2009.
%   [2] C. Cartis, J. Fiala, B. Marteau, L. Roberts, "Improving the
%       Flexibility and Robustness of Model-Based Derivative-Free
%       Optimization Solvers," ACM Trans. Math. Software 45(3), 2019.
%       DOI: 10.1145/3338517.
%   [3] Z. Zhang et al., PRIMA: Reference Implementation for Powell's
%       methods with Modernization and Amelioration.
%       https://github.com/libprima/prima

    if nargin < 5, options = struct(); end
    x0_shape = size(x0);
    x0 = x0(:);
    n = numel(x0);

    core_options = struct();
    if isfield(options, 'rhobeg'), core_options.rhobeg = options.rhobeg; end
    if isfield(options, 'rhoend'), core_options.rhoend = options.rhoend; end
    if isfield(options, 'maxfun'), core_options.maxfun = options.maxfun; end
    if isfield(options, 'npt')
        core_options.npt = options.npt;
    else
        core_options.npt = default_npt(n);
    end

    output_fcn = [];
    if isfield(options, 'output_fcn'), output_fcn = options.output_fcn; end

    best_x = reshape(x0, x0_shape);
    best_f = Inf;
    n_eval = 0;
    stop_id = 'bobyqa_prima_tuned:StopRequested';

    try
        [x, f, exitflag, nf] = bobyqa_prima(@tracked_fun, x0, lb, ub, core_options);
    catch err
        if strcmp(err.identifier, stop_id)
            x = best_x;
            f = best_f;
            nf = n_eval;
            exitflag = -1;
        else
            rethrow(err);
        end
    end
    % bobyqa_prima always returns a column vector regardless of x0's own
    % shape; restore x0's original orientation here so this wrapper is
    % shape-transparent to its caller, like minimize(). (best_x, above, is
    % already in that shape -- reshaping it again is a no-op.)
    x = reshape(x, x0_shape);

    function y = tracked_fun(z)
        % z arrives from bobyqa_prima as a column regardless of x0_shape;
        % reshape back to the caller's own orientation before fun/output_fcn
        % ever see it, so both are shape-transparent too.
        z = reshape(z, x0_shape);
        y = fun(z);
        n_eval = n_eval + 1;
        if y < best_f
            best_f = y;
            best_x = z;
        end
        if ~isempty(output_fcn)
            optim_values = struct('fval', y, 'iteration', n_eval);
            if output_fcn(z, optim_values, 'iter')
                % bobyqa_prima has no native abort hook, so an early stop is
                % signalled by throwing and caught just above -- the best
                % point seen across every evaluation (best_x/best_f, tracked
                % here regardless of which point bobyqa_prima itself would
                % have accepted) is what this function reports to the caller.
                throw(MException(stop_id, 'Optimization stopped by output_fcn.'));
            end
        end
    end
end

function npt = default_npt(n)
    n_full = (n + 1) * (n + 2) / 2;
    if n <= 6
        npt = n_full;
    else
        npt = 2 * n + 1;
    end
end
