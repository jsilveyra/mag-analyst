# Why the live fit-progress plot isn't strictly monotonic

The Anhysteretic and Hysteretic (JA) tabs each open a live "error vs. iteration"
popup while fitting (`FitProgressUtils`, fed from the optimizer's `OutputFcn`,
`fit_stop_output_fcn` in `app_exported.m`). The curve it draws generally trends
down but can show local upticks — small peaks that are then usually followed by
a bigger drop. This is expected behavior of the underlying optimizer, not a bug
in the fit.

## What's actually being plotted

Both fits go through `src/lib/minimize/minimize.m`, a third-party wrapper
(Oldenhuis) around MATLAB's unconstrained `fminsearch` (Nelder-Mead simplex).
Since the fits have lower/upper bounds per parameter, `minimize` enforces them
with a **penalty method**: internally it minimizes

```
P_fval = obj_fval + penalty(constraint violations)
```

(`funfcnP`, `src/lib/minimize/minimize.m:815-929`) — `P_fval`, not your raw
fitting error, is the quantity `fminsearch` is actually driving down.

What the live plot receives instead is `UPfval`, the *unpenalized* raw error,
explicitly substituted back in before the `OutputFcn` is called
(`src/lib/minimize/minimize.m:1271-1281`):

```matlab
function stop = OutputFcn_wrapper(x, optimvalues, state)
    ...
    optimvalues.fval = UPfval;   % Unpenalized function value
```

So a step that trades a small *increase* in raw error for moving further
inside the feasible bounds (shrinking the penalty) is a good step for `P_fval`
— it just shows as an uptick on the plot, because the plot never sees the
penalty term.

On top of that, `UPfval` is overwritten on **every** evaluation of `funfcnP`,
including trial points a line search or simplex step evaluates and then
rejects — not just the best point found so far. So the plotted series is
"value at each point the solver happened to try," which is noisier than a
strict running-minimum would be.

## Historical note: the Hysteretic (JA) fit used to have an extra source (fixed 2026-07-11)

Until 2026-07-11, `JAFitter.fit` called `minimize()` **twice** in sequence
whenever `k` wasn't being fit directly (`mask.fitk == false`): a first pass
from the seed, then a second pass restarted from the first pass's result,
same objective, same bounds. Restarting reset the simplex around the previous
result, which commonly cost one exploratory (worse) step before reconverging
— a distinct extra peak right at that boundary, on top of the two sources
above. It also meant the Hysteretic fit's optimizer settings (iteration
budget, and whether it ran once or twice) differed depending on `mask.fitk`,
and differed again from the Anhysteretic fit's settings.

Both fits now call `minimize()` exactly once, with the identical `optimset`
(`MaxIter=2000`, `MaxFunEvals=1e4`, `TolX=1e-5`, `TolFun=1e-5`,
`Display='off'`) regardless of tab or `mask.fitk`/`mask.k_dependent`. The
restart-boundary peak described above no longer occurs. Verified with
`matlab -batch` against both a real sample dataset (Anhysteretic) and a
synthetic Jiles–Atherton curve with known parameters (Hysteretic, all three
of direct-k / fixed-k / coercive-point-k), all recovering good fits from a
detuned seed with no crashes.

## Is this normal?

Yes. Penalty-method bound handling around a derivative-free solver, and
reporting the most-recently-evaluated point rather than a running minimum, are
both inherent to how `minimize.m` works — not specific to this app's fits. It
does not indicate anything wrong with the fit itself.
