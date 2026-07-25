# NOTICE

The `.m` files in this folder (`vlagbeta.m`, `updateh.m`, `updateq.m`,
`setdrop_tr.m`, `shiftbase.m`, `tryqalt.m`, `trrad.m`) are PRIMA's pure-MATLAB
implementation of Powell's incremental least-Frobenius-norm quadratic-model
update machinery, reused under PRIMA's BSD-3-Clause license.

Source: https://github.com/libprima/prima
Copyright: Zaikun Zhang and PRIMA contributors.

See `../license.txt` for the full license text and attribution for the rest of
this library (`bobyqa_prima.m`, `trsbox.m`, `seed_prima_from_points.m`, all
original work developed for MagAnalyst).

`verisize.m` is a small debug-mode array-size assertion helper called by the
files above; it is inert in normal operation (all call sites pass
`debugflag=false`).
