# Idea (deferred): density input + composition calculator + volume/mass cross-view

Not implemented. Captured here so the design isn't lost between sessions.

## Context

The mass-magnetization (σ, ρ·α) display feature (see `M_is_mass_based`,
`src/Common/DisplayUnits.m`) lets the app fit and report a curve natively in
mass-magnetization terms (σ_S, ρ·αᵢ, χ_m,init, `NᵢkвT/ρ`) without ever needing
the sample's mass density ρ — `MagneticParameters`/the JA solvers are
unit-agnostic, so feeding them raw (unconverted) σ data already produces the
correct mass-native quantities with zero code changes.

What that pass deliberately left out: **anything requiring ρ**. Specifically,
if the sample's mass density is known (measured, or estimated from chemical
composition for a solid, dense sample), the app could additionally show:

- `Ms = ρ·σ_S` — true volume saturation magnetization
- `χ_init = ρ·χ_m,init` — volume susceptibility (still apparent, not
  demagnetization-corrected, same caveat as always)
- `Js = μ0·ΣMs` — total saturation polarization (Tesla); currently hidden
  entirely in mass-native mode since it has no meaning without ρ
- The dimensionless self-interaction `α = (ρ·α)/ρ` — recoverable from the
  mass-native `ρ·αᵢ` once ρ is known
- `initial_relative_magnetic_permeability`/`murin`, if still surfaced
  anywhere (a past commit's message, "Report chi_in instead of mur_in",
  suggests this may already be retired from the UI — check before building)

None of this needs any change to the fitting/solving code — it is a pure
post-processing/display step on top of quantities the app already computes.

## Proposed design (from the earlier, fuller plan draft)

### Density input
- A `sample_density` app property (kg/m³, optional/nullable) and a
  `DensityEditField` + label on the Input tab, entered independently of
  import (before, after, or never) — density is a supplement to a fit
  already-complete in mass-native terms, not a precondition for anything.
- A "Display units" toggle (native vs. cross-view), enabled only once
  `sample_density` is populated.

### Composition-based density calculator (mirrors `src/Anhysteretic/ColorDialog.mlapp`/`.m`)
- **`src/Common/ElementProperties.m`** — static IUPAC standard atomic
  weights + room-temperature elemental densities (cite the exact reference,
  e.g. CRC Handbook, in the file header, matching `UnitConvertor.m`'s own
  "Constants" comment convention), at the reference's full precision.
  Cover the full range of naturally solid elements, not a curated subset —
  a sample's composition can't be anticipated in advance and the data is
  static/cheap to include fully. Elements with multiple common allotropes
  (Mn, C, Sn, ...) get their most common room-temperature form, noted in a
  comment; let the calculator's table override any cell by hand.
  `theoretical_density(symbols, fractions, fraction_type)`: rule-of-mixtures
  `ρ = 1/Σ(w_i/ρ_i)` from mass fractions; converts atomic % to mass % first
  via atomic masses when needed.
- **`src/Input/DensityCalculatorDialog.mlapp` + `.m`** — a small standalone
  App-Designer dialog (own `uifigure`, `MainApp` back-reference, opened via
  a button, cleaned up on close), with an editable Element/Fraction table,
  a mass-%/atomic-% mode selector, "Calculate", and "Use this density"
  (calls back into the main app to set `sample_density`). Include a fixed
  note on the dialog: rule-of-mixtures assumes ideal volume additivity
  (`ρ = 1/Σw_i/ρ_i`, no contraction/expansion on alloying) — reasonable for
  a solid, non-porous, single-phase sample with atomic packing similar to
  its constituents; weaker for ordered intermetallic/compound structures
  (an ordered unit cell can pack differently than a naive weighted average
  of elemental phases), multi-phase/partially-amorphous samples, or
  anything porous/powder (voids aren't captured at all). A measured XRD
  lattice parameter + known crystal structure would be a better estimate
  when available; this is the documented fallback, matching what the 2026
  JMMM paper itself did (ρ ≈ 7.91 g/cm³ for its Heusler alloy).

### Cross-view conversion — two directions, and they are NOT symmetric

**Important, easy to get backwards**: magnetization-like quantities and the
Weiss coefficient scale in *opposite* directions relative to ρ.

| Quantity | mass-native → volume | volume-native → mass |
|---|---|---|
| `M` / `Ms` / `σ_S` | `×ρ` | `÷ρ` |
| `χ_init` / `χ_m,init` | `×ρ` | `÷ρ` |
| `density_product` (`NᵢkвT/ρ` ↔ `NᵢkвT`) | `×ρ` | `÷ρ` |
| `α` / `ρ·α` (Weiss coefficient) | **`÷ρ`** | **`×ρ`** |

The `α`/`ρ·α` row is the one to double-check carefully in review — it is the
opposite direction from every other row, because it's a coupling
coefficient, not a magnetization-like quantity (`ρ·α_mass = α_true · ρ`,
so recovering `α_true` from the mass-native `ρ·α` means *dividing* by ρ).

Proposed implementation: two `DisplayUnits` methods,
`to_display_magnetizationlike(app, native_value)` (`×ρ`/`÷ρ` per the table)
and `to_display_coupling(app, native_value)` (the opposite `÷ρ`/`×ρ`), kept
as two distinct methods specifically so this sign difference can't be
silently miscoded by reusing one generic helper for both.

`Js` and any permeability terms only ever become computable once `Ms` is
recovered via the cross-view (`Js = μ0·Ms`), so they'd be shown/hidden based
on `is_cross_view_available(app) = ~isempty(app.sample_density)`, mirroring
how they're unconditionally hidden today in mass-native mode.

## Why this was deferred

The user's explicit call: implement the σ-unit + native-mode relabeling pass
first (no ρ, no toggle, no calculator), since the fit is already fully
useable in mass-native terms without any of this. This doc exists so the
density/cross-view idea isn't lost, to be picked up in a future session on
request.
