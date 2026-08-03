# bobyqa_mat

Bound-constrained derivative-free optimization for MATLAB, in **pure MATLAB** —
no MEX, no compiler, no Optimization Toolbox, no toolbox of any kind.

```matlab
[x, f, exitflag, nf] = bobyqa_mat_tuned(fun, x0, lb, ub, options)   % recommended
[x, f, exitflag, nf] = bobyqa_mat(fun, x0, lb, ub, options)         % explicit npt
```

Both minimize `fun(x)` subject to `lb <= x <= ub`, starting from `x0`, using
only function values — no gradients, no finite differences. `fun` is evaluated
at bound-respecting points only, so an objective that errors or returns
nonsense outside its feasible box is safe.

This is an implementation of Powell's **BOBYQA** algorithm [1]: each iteration
builds a local quadratic model interpolating `fun` at a set of sample points,
updates that model *incrementally* using PRIMA's [2] pure-MATLAB port of
Powell's least-Frobenius-norm update, and takes an **exact** box-constrained
trust-region step via an active-set / secular-equation solver — rather than
Powell's own deliberately cheap approximate step.

Aimed at problems with roughly **2–20 bound-constrained parameters and an
expensive objective** (an ODE solve, a simulation, a lab measurement) where a
finite-difference gradient would be noisy or unaffordable.

## Quick start

```matlab
addpath('bobyqa_mat');

% Rosenbrock, restricted to a box that excludes the true minimum at (1,1).
rosen = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;

[x, f, exitflag, nf] = bobyqa_mat_tuned(rosen, [0; 0], [-2; -2], [0.5; 0.5]);

fprintf('x = [%.6f, %.6f]\n', x);      % x = [0.500000, 0.250000]
fprintf('f = %.6g  (%d evals, exitflag %d)\n', f, nf, exitflag);
```

Run `demo_bobyqa_mat` for four worked examples (unconstrained, active bounds,
a live-progress hook, and an `npt` comparison), and `test_bobyqa_mat` for a
pass/fail check that the install is working.

## Syntax

### `bobyqa_mat_tuned(fun, x0, lb, ub, options)`

The recommended entry point. Identical to `bobyqa_mat` except that it

1. chooses `npt` automatically from the problem size (see *Choosing `npt`*),
2. **preserves `x0`'s orientation** — `fun` and `output_fcn` are always called
   with a point shaped exactly like `x0`, and `x` comes back in that shape,
3. accepts an `output_fcn` progress / early-stop hook (see below).

### `bobyqa_mat(fun, x0, lb, ub, options)`

The solver itself. Works internally in column-vector form and returns `x` as a
column regardless of `x0`'s shape.

### Arguments

| Argument | Meaning |
|---|---|
| `fun` | Handle to a scalar objective. `Inf`/`NaN` returns are tolerated and treated as a failed step, not an error. |
| `x0` | Initial point. Clipped into `[lb, ub]` before the search starts. |
| `lb`, `ub` | Bounds. May be `[]` (`-Inf`/`+Inf`), a scalar (expanded to all variables), or vectors matching `x0`. |
| `options` | Struct; all fields optional. |

### `options` fields

| Field | Default | Meaning |
|---|---|---|
| `rhobeg` | `0.1` | Initial trust-region radius, **relative** — see *Scaling*. |
| `rhoend` | `1e-6` | Final trust-region radius = convergence tolerance, same relative units. |
| `maxfun` | `400*(n+1)` | Maximum number of evaluations of `fun`. |
| `npt` | see below | Number of interpolation points, `n+2 <= npt <= (n+1)(n+2)/2`. Out-of-range values are clipped into that interval. |
| `output_fcn` | none | `bobyqa_mat_tuned` only. Progress / early-stop hook. |

### Return values

| Output | Meaning |
|---|---|
| `x` | Best point found, always within the bounds. **Not** necessarily the algorithm's own final iterate: the best point seen across every evaluation is tracked separately and returned. |
| `f` | `fun(x)`. |
| `exitflag` | `0` converged (`rho` reduced to `rhoend`); `3` `maxfun` budget exhausted; `-1` stopped by `output_fcn` (`bobyqa_mat_tuned` only). |
| `nf` | Number of times `fun` was evaluated. |

## Scaling — read this before setting `rhobeg`/`rhoend`

Variables are rescaled internally by `s = abs(x0)`, elementwise. The solver
therefore works in units of *"fraction of the starting value"*, and
`rhobeg`/`rhoend` are **relative, not absolute**:

- `rhobeg = 0.1` → the first trust-region radius is 10% of each variable's own
  starting magnitude.
- `rhoend = 1e-6` → roughly 6 significant digits requested in each variable.

Parameters spanning wildly different magnitudes (say `1e4` and `1e-2`)
therefore need no manual rescaling — that is the point of this convention.

**The one exception:** a variable whose `x0` is at or near zero (`|x0| < 1e-8`)
falls back to `s = 1`, making `rhobeg`/`rhoend` absolute *for that variable
alone*. If such a variable actually ranges over, say, `1e6`, either start it
away from zero or rescale it yourself — otherwise its first step is a `0.1`
absolute move, a millionth of its real range.

## Progress and early stopping (`output_fcn`)

`bobyqa_mat_tuned` calls `options.output_fcn` after **every** evaluation of
`fun`, using MATLAB's own `optimset` `OutputFcn` convention:

```matlab
stop = output_fcn(x, optimValues, state)
```

- `x` — the point just evaluated, in `x0`'s shape.
- `optimValues.fval` — that evaluation's objective value.
- `optimValues.iteration` — the evaluation count so far.
- `state` — always the literal string `'iter'`.
- Returning `true` aborts the search at the next evaluation; `x`/`f` then hold
  the best point seen across the whole run, and `exitflag` is `-1`.

Note that `optimValues.fval` is the value at the point *just sampled*, not the
best so far — many of those samples are geometry-improving points that are
expected to be worse (see *Why long flat stretches are normal*). Apply
`cummin` to the recorded history if you want a monotone convergence curve.

## Choosing `npt`

`npt` is the number of points the local quadratic model interpolates. It must
lie between `n+2` and the full quadratic `(n+1)(n+2)/2`. A larger `npt` builds a
richer, curvature-complete model but costs more function evaluations to
initialize and to maintain per step.

- `bobyqa_mat` defaults to `min((n+1)(n+2)/2, 2n+1)` — i.e. `2n+1` for `n >= 2`,
  which is Powell's and PRIMA's own recommended default.
- `bobyqa_mat_tuned` instead uses

  ```
  npt = (n+1)(n+2)/2   (full quadratic)   if n <= 6
  npt = 2n + 1                             if n >  6
  ```

**That threshold is an empirical rule of thumb, not a general result.** It came
from benchmarking against Nelder-Mead on two real curve-fitting objectives
(magnetic hysteresis models, one ODE solve per evaluation):

| n | `npt` | final error | evals | wall time |
|---|---|---|---|---|
| 5 | 11 (`2n+1`) | 0.0010460 | 2400 (hit budget) | 513 s |
| 5 | 16 (midpoint) | 0.0010455 | 2400 (hit budget) | 415 s |
| 5 | **21 (full quadratic)** | **0.0010455** | **2231 (converged)** | **396 s** |
| 11 | **23 (`2n+1`)** | **0.000377** | 1500 (fixed budget) | 575 s |
| 11 | 51 (midpoint) | 0.000656 | 1500 (fixed budget) | 618 s |
| 11 | 78 (full quadratic) | 0.000647 | 1500 (fixed budget) | 611 s |

Read this honestly, because the two rows say different-strength things:

- **At n = 11 the effect is large and clear.** `2n+1` reached ~1.7× lower error
  than the full quadratic at an identical budget. At `npt = 78`, seeding the
  model alone eats 78 evaluations before any trust-region progress happens, and
  the richer model stays costlier to maintain — so more of the budget goes into
  overhead rather than improvement.
- **At n = 5 the effect is small, and it is about cost, not accuracy.** All
  three settings land within 0.05% of each other in final error. What separates
  them is that only the full quadratic actually *converged* — the smaller
  models exhausted `maxfun` still short of `rhoend`, spending 7% more
  evaluations and 23% more wall time to end up no better.

`n = 6` is simply the midpoint between the two tested sizes; the exact
crossover was never located. **If your problem sits near that boundary,
benchmark both settings rather than trusting the default** — pass `npt`
explicitly to override.

For calibration against a non-model-based method, Nelder-Mead was also run on
both problems: at n = 5 it was the cheapest option of all (1311 evaluations,
313 s) and matched the best error to 7 significant figures, so nothing here
beats it at that size. At n = 11 it reached 0.000884 — about 2.3× worse than
`npt = 2n+1` at the same budget. The model-based advantage in these tests
showed up at the larger problem, not the smaller one.

The general *shape* of this trade-off — larger `npt` costs more to initialize,
and that cost can dominate the budget at high `n` — is documented in the
literature, though neither source gives a universal `npt(n)` rule:

- Powell (2009) [1], on NEWUOA (the closely related unconstrained solver):
  "if `m` is set to `2n+1`, then often `#F` is only of magnitude `n` or less,
  and it happens occasionally that smaller values of `m` are even more
  efficient" — evaluated for `n` up to 320, generally favoring smaller `npt`.
- Cartis et al. (2019) [3], benchmarking DFBOLS at both `2n+1` and
  `(n+1)(n+2)/2`: for their medium-sized test problems they omit the
  full-quadratic results altogether, "as in most cases the initialization cost
  will use almost all of the available budget." Their own solver's default is
  noise-dependent rather than size-dependent: `2n+1` (or fewer) for smooth
  objectives, full quadratic specifically for noisy ones, where the richer
  model's robustness is worth the extra cost.

## Why long flat stretches are normal

A run can spend hundreds of evaluations with **no improvement** in the best
value seen. That is expected, not a hang:

`rho` (the trust-region radius floor) only shrinks once recent steps have
stopped making progress at the *current* radius, and then it shrinks in stages,
not straight to `rhoend`. Between two `rho` reductions the algorithm spends
evaluations on **geometry-improving steps** whose only job is to repair the
interpolation point set so the next quadratic model is well-conditioned. By
construction those steps need not improve `f`, and usually don't. The larger
`npt` is, the more such points can need fixing per `rho` level.

There is deliberately no "no improvement in the last K evaluations" stopping
rule — convergence is judged purely by `rho` vs `rhoend` and by `maxfun`. Use
`output_fcn`, a smaller `maxfun`, or a looser `rhoend` if you want to cut a run
short.

## Relationship to PRIMA and to Powell's BOBYQA

**Reused from PRIMA** (BSD-3, `private/`): the incremental least-Frobenius-norm
quadratic-model update machinery — `vlagbeta`, `updateh`, `updateq`,
`setdrop_tr`, `shiftbase`, `tryqalt`, `trrad`, `calquad`, `verisize`.

**Original to this library:**

- `private/trsbox.m` — solves **both** the trust-region step and the
  geometry-improving step *exactly*, via an active-set / secular-equation
  method over the box ∩ ball feasible region. PRIMA and Powell use approximate
  steps here (truncated CG for the trust region, a Cauchy point plus line
  search for geometry). Benchmarked to match or exceed their accuracy for
  `n <= 11` at no extra function-evaluation cost.
- `private/seed_prima_from_points.m` — seeds the interpolation state from an
  *arbitrary* bound-feasible point set through a direct KKT solve (verified to
  `1e-13` against an independent reference). This decouples initialization from
  NEWUOA's hardwired `±rhobeg` geometry, so starting points sitting on or near
  a bound are handled correctly.
- `bobyqa_mat.m` (driver loop) and `bobyqa_mat_tuned.m` (`npt` policy, shape
  handling, `output_fcn`).

No source code from Powell's original Fortran distribution is included.

**bobyqa_mat is not affiliated with or endorsed by the PRIMA project.** If you
want the reference implementation of Powell's full solver family
(BOBYQA/NEWUOA/LINCOA/UOBYQA/COBYLA), including compiled backends, go to
[PRIMA](https://github.com/libprima/prima) directly.

## When to use this — and when not to

**Reasonable fit:**

- 2–20 parameters with box bounds.
- Objective is expensive, and smooth enough that a local quadratic means
  something.
- No analytic derivatives available, and finite differences would be noisy or
  too costly.
- You want zero build steps and zero toolbox licenses.

**Look elsewhere if:**

- **You have derivatives.** A gradient-based method will typically get there in
  far fewer evaluations; the published *bbob*-suite comparison via PDFO shows
  BOBYQA/NEWUOA/LINCOA using roughly 5× the function evaluations of
  derivative-based SLSQP/BFGS on smooth problems. That is the ordinary price of
  not using derivatives.
- **`n` is large** (hundreds or more). Costs here scale with dense `n×n` and
  `npt×npt` linear algebra.
- **You need constraints beyond bounds.** Linear or nonlinear constraints are
  not supported — see PRIMA's LINCOA/COBYLA.
- **Your objective is very noisy.** There is no explicit noise handling; see
  Py-BOBYQA / DFO-LS [3], which model noise directly.
- **You need a guaranteed global optimum.** This is a local method. It is,
  though, less myopic than a simplex method: the first model is built by
  sampling a whole neighbourhood of radius `rhobeg` before any direction is
  committed to, so raising `rhobeg` widens the region the search can see past a
  shallow local minimum. That is a useful knob, not a global search — if you
  genuinely have no idea which basin you are in, multi-start it yourself. If
  instead you can *estimate* a starting point from the structure of your
  problem, that is usually worth more than a blind multi-start, and costs
  orders of magnitude fewer evaluations.

Within its niche, the model-based family this belongs to is the theoretically
and empirically favored choice over deterministic direct-search methods
(Nelder-Mead, pattern search): fitting a local quadratic exploits curvature
that direct search discards by only ever comparing raw function values. Conn,
Scheinberg & Vicente [4] frame the two families and note that convergence-rate
theory exists only for the model-based one; Moré & Wild's benchmark [5] found
model-based solvers (BOBYQA, IMFIL) pulling further ahead of direct-search
solvers (NOMAD, PATTERN) as the required tolerance tightens from `1e-4` to
`1e-6` — curvature information pays off more as smoothness becomes exploitable
at high precision.

## Requirements

MATLAB R2016b or newer (developed and tested on R2025b). No toolboxes. Should
work under Octave, though this has not been tested.

## License

BSD-3-Clause. See `license.txt` for full text and attribution — this library
combines original code with BSD-3-licensed code reused from the PRIMA project
(Copyright (c) 2020–2026, Zaikun ZHANG), which in turn implements the algorithm
published by M.J.D. Powell [1].

## References

[1] M.J.D. Powell, "The BOBYQA algorithm for bound constrained optimization
    without derivatives," Report DAMTP 2009/NA06, University of Cambridge,
    2009. (Technical report; no DOI.)

[2] Z. Zhang, PRIMA: Reference Implementation for Powell's Methods with
    Modernization and Amelioration, https://www.libprima.net, 2023 (BSD-3).
    DOI: 10.5281/zenodo.8052654

[3] C. Cartis, J. Fiala, B. Marteau, L. Roberts, "Improving the Flexibility and
    Robustness of Model-Based Derivative-Free Optimization Solvers," ACM Trans.
    Math. Software, 45(3), 2019. DOI: 10.1145/3338517. (Py-BOBYQA — a related,
    GPLv3-licensed alternative.)

[4] A.R. Conn, K. Scheinberg, L.N. Vicente, "Introduction to Derivative-Free
    Optimization," MPS-SIAM Series on Optimization, SIAM, 2009.
    ISBN 978-0-89871-668-9. DOI: 10.1137/1.9780898718768.

[5] J.J. Moré, S.M. Wild, "Benchmarking Derivative-Free Optimization
    Algorithms," SIAM J. Optim., 20(1), pp. 172–191, 2009.
    DOI: 10.1137/080724083.
