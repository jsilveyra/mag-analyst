# bobyqa_prima

Bound-constrained derivative-free trust-region minimization (BOBYQA family) for
MATLAB. No MEX/compiler, no paid toolbox — pure MATLAB.

```matlab
[x, f, exitflag, nf] = bobyqa_prima(fun, x0, lb, ub, options)
[x, f, exitflag, nf] = bobyqa_prima_tuned(fun, x0, lb, ub, options)
```

Both minimise `fun(x)` subject to `lb <= x <= ub` starting from `x0`, without
requiring derivatives. `bobyqa_prima_tuned` is the recommended entry point for
new code (and is what MagAnalyst's fitting tabs call, as "PRIMA-BOBYQA, tuned
npt" in the Solver dropdown): it wraps `bobyqa_prima` and picks `npt` (the
number of interpolation points, see below) automatically from the problem
size, and adds an optional live-progress/early-stop hook. Call `bobyqa_prima`
directly only if you want to choose `npt` yourself.

## What this is

An implementation of Powell's BOBYQA algorithm [1]: each iteration builds a
local quadratic model interpolating `fun` at a set of points, updates that
model **incrementally** (not rebuilt from scratch every step) using PRIMA's
[2] pure-MATLAB port of Powell's least-Frobenius-norm update, and takes an
**exact** box-constrained trust-region step (rather than Powell's own
deliberately cheap approximate step) via an active-set/secular-equation
solver (`trsbox.m`).

Developed for MagAnalyst as a replacement for `minimize()` (Nelder-Mead) in
curve-fitting workflows with 2–11 bound-constrained parameters and moderately
expensive objectives (e.g. an ODE solve per evaluation). See
`OPTIMIZER_EVALUATION.md` and `V2_NOTES.md` in `to_organize/solvers_extras/`
(MagAnalyst repo) for:
- the full 6-solver benchmark that selected this method (accuracy leader, and
  efficiency leader for n≤4, vs. classic BOBYQA, Nelder-Mead, NEWUOA, Py-BOBYQA),
- the equivalence proof against a from-scratch direct-KKT-solve BOBYQA (`bqa`),
- a follow-up (`v2`) investigation of Zhang's RESCUE mechanism and BOBYQA's
  true IDZ-free positive-semidefinite update, cross-checked against Powell's
  2009 paper directly (not adopted for the version wired into the app — see
  "Which version is wired in" below),
- the `npt`-tuning benchmark (§9 of `OPTIMIZER_EVALUATION.md`) behind
  `bobyqa_prima_tuned`'s size-based `npt` rule.

**Status: wired into MagAnalyst's fitting tabs.** Both `src/Anhysteretic/fit.m`
(and `fit_physical.m`) and `src/Hysteretic/JAFitter.m` accept a `solver`
argument ("prima" [default] or "nelder_mead"), dispatched by
`src/Common/SolverUtils.m`, which the Anhysteretic and Hysteretic tabs' Solver
dropdown controls. `minimize()` (Nelder-Mead) remains available as the
"Nelder-Mead (minimize lib)" option.

### Which version is wired in

This is the **v1** algorithm (incremental H-update with IDZ sign-split, exact
`trsbox`), not the `v2` variant explored in `to_organize/solvers_extras/`
(Zhang's RESCUE + BOBYQA's IDZ-free update). v2's benchmark outcome was that
RESCUE never fires on any real MagAnalyst fit tested and the IDZ-free update
is numerically identical to v1's when RESCUE is inert — real robustness
insurance, but no measured difference on this project's data — so v1 was kept
as the simpler, already-verified codebase actually wired into the app.

## Files

- `bobyqa_prima.m` — the solver (driver loop); `npt` must be chosen by the caller.
- `bobyqa_prima_tuned.m` — recommended entry point: automatic size-based `npt`
  choice (see "Choosing `npt`" below) plus an `output_fcn` hook compatible
  with MATLAB's `optimset` `OutputFcn` convention, used by the app for live
  fit-progress plotting and the "Stop fit" button.
- `trsbox.m` — exact box-constrained trust-region/geometry subproblem solver.
- `seed_prima_from_points.m` — builds PRIMA's interpolation state (BMAT/ZMAT
  and the quadratic model) from an arbitrary bound-feasible point set via a
  direct KKT solve, verified to 1e-13 against an independent reference. This
  decouples initialization from NEWUOA's hardwired `±rhobeg` geometry.
- `private/` — PRIMA's incremental update machinery (`vlagbeta.m`, `updateh.m`,
  `updateq.m`, `setdrop_tr.m`, `shiftbase.m`, `tryqalt.m`, `trrad.m`), reused
  under PRIMA's BSD-3-Clause license, plus `verisize.m` (a debug-mode size
  check, inert at runtime).

## Choosing `npt`

`npt` is the number of points the local quadratic model interpolates. It must
lie between `n+2` and the full quadratic `(n+1)(n+2)/2`; a larger `npt` builds
a richer (curvature-complete) model but costs more function evaluations to
initialize and maintain per step.

`bobyqa_prima_tuned` sets it automatically:

```
npt = (n+1)(n+2)/2   (full quadratic)   if n <= 6
npt = 2n + 1                             if n >  6
```

**This threshold is an empirical rule of thumb found for MagAnalyst's own
fits, not a general result.** It was derived by benchmarking against
Nelder-Mead on two real curve-fitting objectives:

| n | best `npt` found | why |
|---|---|---|
| 5 (2-component anhysteretic fit) | full-quadratic (21) | reached the best accuracy using *fewer* evaluations than either `2n+1` or Nelder-Mead |
| 11 (4-component anhysteretic fit) | `2n+1` (23) | reached roughly 2× better accuracy than full-quadratic (78) or Nelder-Mead, at an equal, fixed evaluation budget — the full-quadratic model's initialization cost dominated the budget before real progress could happen |

`n = 6` is simply the midpoint between the two tested sizes; the exact
crossover was not located more precisely (no problem between n=5 and n=11 was
benchmarked). If you have an objective near that boundary, benchmark both
settings rather than trusting the default. See `results_raw/npt_tune_anh2_anh4comp.txt`
and §9 of `OPTIMIZER_EVALUATION.md` in `to_organize/solvers_extras/` for the
full data.

The general *shape* of this trade-off — larger `npt` costs more to initialize,
and that cost can dominate the budget at high `n` — is documented in the
literature, though neither source gives a universal `npt(n)` rule:
- Powell (2009) [1], on NEWUOA (the closely related unconstrained solver):
  "if `m` is set to `2n+1`, then often `#F` is only of magnitude `n` or less,
  and it happens occasionally that smaller values of `m` are even more
  efficient" — evaluated for `n` up to 320, generally favoring smaller `npt`.
- Cartis et al. (2019) [3], benchmarking DFBOLS at both `2n+1` and
  `(n+1)(n+2)/2`: for their medium-sized test problems, they omit the
  full-quadratic results altogether "as in most cases the initialization cost
  will use almost all of the available budget." Their own solver's default
  policy is noise-dependent, not size-dependent: `2n+1` (or fewer) for smooth
  objectives, full-quadratic specifically for noisy ones, where the richer
  model's robustness is worth the extra cost.

## License

BSD-3-Clause. See `license.txt` — this library combines original code with
BSD-3-licensed code reused from the PRIMA project (Zaikun Zhang et al.),
which in turn implements the algorithm published by M.J.D. Powell [1].

## References

[1] M.J.D. Powell, "The BOBYQA algorithm for bound constrained optimization
    without derivatives," Report DAMTP 2009/NA06, University of Cambridge,
    2009. (Technical report; no DOI.)

[2] Z. Zhang et al., PRIMA: Reference Implementation for Powell's methods with
    Modernization and Amelioration. https://github.com/libprima/prima (BSD-3).

[3] C. Cartis, J. Fiala, B. Marteau, L. Roberts, "Improving the Flexibility and
    Robustness of Model-Based Derivative-Free Optimization Solvers," ACM Trans.
    Math. Software, 45(3), 2019. DOI: 10.1145/3338517. (Py-BOBYQA — a related,
    GPLv3-licensed alternative compared against but not used in this library.)
