# NOTICE

This folder mixes original code with code reused from the PRIMA project. Both
are BSD-3-Clause; see `../license.txt` for the full text.

## Reused from PRIMA

`vlagbeta.m`, `updateh.m`, `updateq.m`, `setdrop_tr.m`, `shiftbase.m`,
`tryqalt.m`, `trrad.m`, `calquad.m` — PRIMA's pure-MATLAB implementation of
Powell's incremental least-Frobenius-norm quadratic-model update machinery.

`verisize.m` — a small debug-mode array-size assertion helper called by the
files above; inert in normal operation (all call sites pass `debugflag=false`).

Source: https://github.com/libprima/prima
Copyright (c) 2020--2026, Zaikun ZHANG ( https://www.zhangzk.net )

`bobyqa_mat` is not affiliated with or endorsed by the PRIMA project.

## Original to bobyqa_mat

`trsbox.m` — exact box-constrained trust-region and geometry subproblem solver
(active set + secular equation). This replaces PRIMA's own approximate
`trsapp`/`geostep`; it is not a port of them.

`seed_prima_from_points.m` — builds PRIMA's interpolation state (BMAT/ZMAT and
the quadratic model) from an arbitrary bound-feasible point set via a direct
KKT solve, decoupling initialization from NEWUOA's hardwired `±rhobeg`
geometry.

Both live here rather than at the top level so that the library's public API is
exactly `bobyqa_mat` and `bobyqa_mat_tuned`, and so that `trsbox` cannot shadow
(or be shadowed by) the same-named routine in other BOBYQA distributions on a
user's MATLAB path.
