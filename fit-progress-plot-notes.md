# The live fit-progress plot: what it shows and why

The Anhysteretic and Hysteretic (JA) tabs each open a live "error vs.
iteration" popup while fitting (`FitProgressUtils`, fed from the optimizer's
`OutputFcn`, `fit_stop_output_fcn` in `app_exported.m`).

## The plot shows the best value found so far, not the raw current value

As of 2026-07-11, `FitProgressUtils.append` tracks the best `(x, fval)` pair
seen across every call from the optimizer's `OutputFcn`, and plots that
running best — a curve that never increases. This matches how convergence
plots are conventionally drawn (MATLAB's own `optimplotfval`/`gaplotbestf`,
and "best-so-far"/incumbent curves generally, across the optimization and ML
literature).

This replaced an earlier version that plotted the raw value from whichever
point the `OutputFcn` was last called with. That raw value could be a
**rejected trial point**, not the algorithm's actual incumbent: both fits go
through `src/lib/minimize/minimize.m`, a third-party wrapper (Oldenhuis)
around MATLAB's unconstrained `fminsearch`. Since the fits have bounds per
parameter, `minimize` enforces them with a penalty method — internally it
minimizes `P_fval = obj_fval + penalty(constraint violations)`
(`funfcnP`, `src/lib/minimize/minimize.m:815-929`) — and its `OutputFcn`
wrapper substitutes back in `UPfval`, the *unpenalized* value of whatever
point was **most recently evaluated**, which isn't necessarily the best point
found (`src/lib/minimize/minimize.m:1271-1281`). That produced visible peaks
that don't match how a fit's progress is normally communicated.

## The final answer always comes from that same tracked best point

Both `AnhystereticUtils.fit_parameters` and `HystereticUtils.fit_ja_parameters`
now retrieve `FitProgressUtils.get_best(app)` after the optimizer call
returns and use *that* — not whatever `minimize()`/`JAFitter.fit` itself
returned as `xopt`/`Jopt` — as the final fitted parameters. This guarantees
that hitting "Stop fit" (or any other reason the search's own final iterate
might not be its best) never leaves you with a worse result than the best
point the search actually found along the way, even if the stop happened to
land exactly on one of the raw-value peaks described above. Verified with a
synthetic peak sequence via `matlab -batch`: stopping right after a
deliberately-worse "peak" point still retrieves the pre-peak best, not the
peak.

## One tight pass by default; a one-time tip suggests running Fit again

`fit.m` and `JAFitter.fit` each call `minimize()` **once**, at the tight
tolerance (`TolX=1e-5, TolFun=1e-5`). This went through two other designs
first, both abandoned the same day (2026-07-11):

1. **Automatic double tight pass, always.** A restart from a pass's own
   *fully tight-converged* result can only match or improve on it, never
   worsen it — `minimize()` always evaluates its own starting point as part
   of its initial simplex, so the second pass's worst case is re-confirming
   the first pass's answer. Real benefit, confirmed on synthetic cases with
   known ground truth — but it costs a full second pass on *every* fit,
   whether or not it helps: roughly 1.3-1.5x the single-pass time.
2. **Automatic loose-then-tight two-stage** (`TolX=TolFun=1e-3` then
   `1e-5`), meant to recover most of that benefit cheaper. This turned out
   to **not** carry the same guarantee: seeding the tight pass from a only
   *loosely*-converged intermediate point is a different starting point
   than either the original seed or a fully-converged result, and
   Nelder-Mead's trajectory through a non-convex landscape is sensitive to
   exactly where it's restarted from. A tolerance sweep (`1e-1` through
   `1e-4`) on two synthetic cases showed no consistent trend — some
   tolerances landed *worse* than not restarting at all (as far as -1266%
   of the single-pass result), with no reliable way to predict which.

Both are gone. Instead: a single tight pass runs by default, and clicking
**Fit** again afterward (with nothing else changed) reproduces the safe,
guaranteed-non-worsening restart from design 1 — exactly, since both fit
entry points seed the next run from the app's current state, which the
previous run just set to its own result:
- Anhysteretic: `AnhystereticUtils.fit_parameters`'s seed is
  `cat(2, app.Hcr, app.mcr, app.Hx)`.
- Hysteretic: `HystereticUtils.fit_ja_parameters`'s seed comes from
  `get_ja_params_from_tab`, i.e. the `Ms_JA`/`a_JA`/`alpha_JA`/`c_JA`/`k_JA`
  field values.

A one-time message nudges toward this: the first time a fit finishes for a
given configuration, the Messages panel shows "Tip: click Fit again without
changing anything to let the optimizer restart from this result — it can
only match or improve on it, never make it worse." `FitProgressUtils`
(`check_and_remember_conditions`/`remember_fit_result`) tracks, per tab,
whether the seed going into this fit exactly matches the *previous* fit's
own result **and** every condition that isn't the seed itself (bounds, which
parameters are free, error metric, and for the Hysteretic tab also fitting
region/starting point/stop criterion) is unchanged — only then is this
recognized as a plain repeat click and the tip suppressed. Editing anything
in that list, or manually changing a parameter value, makes it reappear once
for the new configuration. Verified with `matlab -batch` against a real app
instance: shown on fit 1, suppressed on an unchanged fit 2, shown again after
changing the error-metric dropdown for fit 3.

## Why the plot can still look flat for a while before the fit stops

Separately from the above: even the best-so-far curve can sit visibly flat
for many iterations before the solver actually terminates. Confirmed by
logging a full iteration trace against a real dataset
(`data/sampleData/MnZn_ferrite.csv`, Hysteretic fit): the displayed error
reached its final value (to 6 significant figures) dozens of iterations
before the solver stopped. Two reasons, both inherent to `minimize.m`:

1. **`TolFun`/`TolX` are checked against `P_fval` (the penalized objective),
   not the raw error.** The plotted curve can look flat while the *actual*
   minimized quantity is still making tiny adjustments near an active bound
   (in the traced run, the fitted `c` had landed exactly on its upper bound).
2. **`fminsearch`'s stopping test needs the whole simplex to converge, not
   just the best vertex.** It only terminates once both the function-value
   spread *and* the geometric spread across all simplex vertices fall below
   tolerance. Once the best vertex stops improving, the other vertices still
   have to contract toward it before that joint test passes.

Raising `TolFun`/`TolX` (looser tolerances) would stop the search earlier at
the cost of a less-refined answer; the current values (`TolX=1e-5`,
`TolFun=1e-5`, shared by both fits) were chosen because they've been observed
to work well, not tuned against this specific plateau-length behavior.

## Is any of this normal?

Yes. Penalty-method bound handling around a derivative-free solver, and a
whole-simplex (not just best-point) stopping criterion, are inherent to how
`fminsearch`/`minimize.m` work — not specific to this app's fits. The
plotting and final-answer-retrieval fix above brings this app's *display* and
*result* in line with how the underlying algorithm's actual progress is
normally communicated; it doesn't change what the optimizer itself does.
