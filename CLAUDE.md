# MagAnalyst — codebase onboarding

Orientation notes for working in this repo. Depth marker on each section:
**[deep]** = read and understood in detail, **[map]** = known from file names /
signatures / headers, not fully traced.

**To deepen sections as code is explored:** When analyzing a part of the codebase
marked **[map]**, replace it with **[deep]** and add a detailed explanation so
it doesn't need re-exploration in future sessions. Keep sections accurate — if
architecture changes, update the doc.

---

## 1. What the app is [map]

MagAnalyst is a **MATLAB App Designer GUI** (`app.mlapp`) for analyzing magnetic
hysteresis data. It fits magnetic models to measured `M(H)` curves and lets the
user simulate loops. Two parameter worlds coexist:

- **Anhysteretic / distribution parameters**: per-component `Hcr`, `mcr`, `Hx`
  (a model with `n` components uses `3*n - 1` fitted parameters). Used in the
  fitting tabs.
- **Jiles–Atherton (JA) parameters**: `Ms`, `a`, `alpha`, `k`, `c`. Used by the
  hysteretic simulation in the Playground.

Version string shown at startup: read from `AppVersion.m` (see §9) — currently `MagAnalyst 2.0`.

---

## 2. THE critical workflow rule: `app.mlapp` vs `app_exported.m` [deep]

- The real app lives in **`app.mlapp`** (edited in App Designer).
- **`app_exported.m`** (~4900 lines) is the exported mirror of that `.mlapp`.
- Editing `app_exported.m` does **not** update the `.mlapp`. The user hand-ports
  every change back into App Designer.

**Therefore: any change touching `app_exported.m` must be flagged explicitly**
(which method/property/callback, and exactly what changed) so it can be
reproduced in App Designer. Changes to standalone `src/**` `.m` files do **not**
need porting — only `app_exported.m` does.

### 2a. Preferred workflow (as of 2026-07-06): App Designer stays the single
source of truth — hand-port via a verified local HTML guide [deep]

The user explicitly wants to keep making `app.mlapp` edits herself in App
Designer (so she can keep editing it in the future without Claude), **not**
have Claude patch `document.xml` directly as the default path. Reason: direct
patching lost work twice on 2026-07-05 — App Designer holds its own
in-memory copy of the app while a session is open, and silently overwrites
whatever is on disk (including a Claude patch, or even its *own* earlier
save) the moment the user hits Save or Run in that session. There is no way
to detect "is App Designer currently holding this file open" from outside,
so treating direct patching as the default is unsafe.

**Default procedure:**
1. Make the change conceptually, then **diff** a fresh extract of the
   *current* `app.mlapp` (never a stale/previous-session copy — see 2b step 2)
   against the intended new code to get an exact, minimal set of edits.
2. Build an HTML step-by-step port guide: each edit gets an anchor (a short
   verbatim snippet to locate the spot) plus exact Before/After code blocks
   (or a full new-method block placed after a named existing method).
   **Verify every code block is an exact substring of the real file** before
   sending it (script the check — a hand-retyped block is exactly how subtle
   whitespace mismatches slip in). Flag any change that alters a method
   *signature* (e.g. `~` → `app`) with its own callout — those are the easiest
   to paste past without noticing, and without the parameter the new code
   won't compile.
3. **Every port guide must include a step telling her to manually update the
   Sharing Details Version field in Design View, naming the exact target
   version** (`MAJOR.MINOR` — see §9) — the guide is a Design View action
   (not reachable from Code View / `AppVersion.m`), so it never happens
   unless the guide says so explicitly.
4. **Save the guide to a local file** — `tools/port-guides/<slug>.html` in the
   repo — and give her the path to open directly in a browser. **Do not**
   publish it as a cloud Artifact; she confirmed she wants these local, not
   uploaded. See [[maganalyst-port-guide-delivery]]. **Never `git add`/commit
   port-guide files autonomously** — they are working notes for a single
   porting session, not project history; leave them untracked (this mirrors
   how earlier port guides in `tools/port-guides/` already sat untracked
   before this note existed). Only commit one if she explicitly asks to.
5. She applies the edits in App Designer's Code View herself (plus the
   Design View version-field update from step 3) and saves.
6. Once she confirms it's saved, **regenerate `app_exported.m`** from her
   saved file (see step 5 of the fallback procedure below — same mechanics)
   and verify by constructing the app in `matlab -batch` (see
   [[maganalyst-mlapp-appdesigner-sync]]) — `MagAnalyst.m` launches
   `app_exported()`, not the `.mlapp`, so this step is still required every
   time regardless of which workflow produced the `.mlapp` change.

Standalone `src/**` files (e.g. `ExportUtils.m`, `PlaygroundUtils.m`) never need
any of this — edit them directly; they're plain files on the MATLAB path.

### 2b. Direct mlapp patching (fallback only) [deep]

Only use this when App Designer is **confirmed closed** (ask first if
unsure), or the user explicitly asks for a direct patch instead of a port
guide. Editing `app.mlapp` while an App Designer session has it open risks
exactly the silent-overwrite failure mode described in 2a.

`app.mlapp` is an OPC (zip) package. **All of the app's MATLAB source lives in
`matlab/document.xml` inside a single `<![CDATA[ … ]]>` block, as plain MATLAB**
(class name `app`, not `app_exported`). Inside the CDATA there is **no XML entity
escaping** — `&&`, `<`, `>` are literal — so the code can be edited as ordinary
text.

**Runtime note:** `MagAnalyst.m` launches `app_exported()`, so `app_exported.m` is
the file that actually *runs*. It MUST be regenerated from the mlapp after every
patch (step 5), or the launcher will run stale code.

**Procedure:**
1. **Back up** the current mlapp: `cp app.mlapp app.mlapp.bak-<timestamp>`.
2. **Extract the CURRENT mlapp fresh** into the scratchpad every session:
   `unzip -o -q app.mlapp -d <scratch>/mlapp`. ⚠️ **Never reuse a stale extract from a
   previous session** — the user may have edited the mlapp in App Designer meanwhile,
   and re-zipping from an old copy silently reverts their work (this exact bug lost a
   round of the user's label edits once, and lost a whole theme+feature patch a second
   time the same day — see [[maganalyst-mlapp-appdesigner-sync]]).
3. **Edit** `<scratch>/mlapp/matlab/document.xml` with the normal Read/Edit tools,
   anchoring on the plain MATLAB code. Do **not** disturb line 1's `…<![CDATA[classdef
   app < …` prefix or the final `end]]></w:t>…</w:document>` suffix.
4. **Repackage into a copy, validate, then swap:**
   `cp app.mlapp <scratch>/patched.mlapp`; then from inside the extract dir
   `( cd <scratch>/mlapp && zip -X <scratch>/patched.mlapp matlab/document.xml )`
   (this replaces just that entry, preserving `[Content_Types].xml` order). Validate
   with `unzip -t` and `unzip -p <scratch>/patched.mlapp matlab/document.xml | diff -
   <scratch>/mlapp/matlab/document.xml` (expect no diff), then `cp <scratch>/patched.mlapp app.mlapp`.
5. **Regenerate `app_exported.m`** from the edited CDATA: take the text between
   `<![CDATA[` and `]]>`, and apply exactly two renames — `classdef app <` →
   `classdef app_exported <`, and the constructor line `\n        function app = app\n`
   → `\n        function app = app_exported\n`. Write it to `app_exported.m` (LF newlines,
   UTF-8). (A short Python heredoc does this cleanly; assert `classdef app <` is gone.)
6. **Verify** by constructing the app in `matlab -batch` (`a = app_exported; pause(1.5);
   ...; delete(a)`), not just zip/CDATA integrity checks — a dangling reference to a
   deleted component (valid MATLAB syntax, throws only at runtime) will pass every
   structural check and still crash on launch. Also grep the new markers in both
   `app.mlapp` (`unzip -p … | grep`) and `app_exported.m`. Tell the user to open
   `app.mlapp` in App Designer to confirm it reopens (backup enables rollback).

**Content format for either workflow** — give **paste-ready, exact add/delete
lines with an anchor**, split by where they go in App Designer:

- **Code View** edits (everything editable there: the `properties` block, private
  helper `methods`, and callback bodies). For each edit give: an *anchor* (a short
  verbatim snippet of existing code to locate the spot), then the exact lines to
  **add** or **delete** relative to that anchor. New whole methods/callbacks: give
  the full function text and say which existing method to place it after.
- **Design View** actions (NOT editable in Code View because `createComponents` is
  auto-generated/read-only there): component property values (e.g. `Value`,
  `Limits`, `RoundFractionalValues`) and callback wiring (`ValueChangedFcn`,
  `CellEditCallback`) must be set via the Component Browser → Inspector / Callbacks
  tab. List each as "component → property/callback = value". Selecting a callback
  in Design View auto-generates the matching `createCallbackFcn` line in
  `createComponents`; reuse one shared callback across components via the dropdown.
  (Exception: callbacks assigned programmatically in code — e.g. a table's
  `CellEditCallback` set inside a `configure_*` helper — are Code View, not Design
  View.)

**This is mandatory for every `app_exported.m` change, no exceptions** — even a
one-line edit, even something that looks purely mechanical (e.g. a
`createComponents` wiring line). Never summarize an `app_exported.m` change as
prose ("also wired the Stop button") without the accompanying paste-ready
add/delete lines for *both* Code View and Design View, because App Designer
changes are hand-ported and prose alone isn't reproducible. If a past session's
instructions weren't fully applied, a fresh diff against the file exported from
the user's current `app.mlapp` is the way to find exactly what's still
missing — don't assume it was done.

`app_exported.m` layout (roughly):
- Public/private **properties** blocks near the top (~line 300+).
- `methods (Access = private)` — helper methods and business logic.
- `methods (Access = private)` for **callbacks** (`...ValueChanged`,
  `...Pushed`, `...CellEdit`, `startupFcn`).
- `methods (Access = private)` — `createComponents(app)` builds the entire UI
  (tabs, panels, tables, dropdowns). This is the mechanical App Designer output;
  the substantive logic is in the earlier method blocks.

---

## 3. UI tab structure [map]

`TabGroup` tabs (see `createComponents`):
1. **Input data** — import/parse a dataset, choose units, preview raw/processed.
2. **Anhysteretic fitting** — fit the distribution model (Hcr/mcr/Hx).
3. **Hysteretic fitting** — fit hysteretic (JA-related) behavior.
4. **Playground** — forward simulation. Three mode panels: **Major loop**,
   **Minor loop**, **Degaussing** (switched by `HcaseDropDown` via
   `sync_playground_mode_ui`).
5. **Output data** — export.
- A **Messages** sub-panel shows status text (`write_message`).
- **Visual theme**: applied at runtime by `apply_theme(app)` (called at the end
  of `startupFcn`); every knob (colors/fonts/line widths) lives in the
  `theme_palette` method — tweak there, never per-component. Axes styling is
  also set as figure-level `DefaultAxes*` defaults because
  `cla(ax,'reset')`/`semilogx` rebuild axes from defaults. See memory
  `maganalyst-ui-theme`.

---

## 4. `src/` module map [deep]

**Reorganized 2026-07-06** from physics-concept folders (`MagneticParameters/`,
`Parser/`, `AnhystereticCurve/`, `ErrorCalculator/`, `ResidueCalculator/`,
`Plotter/`) into **tab-based** folders, since those folders each mixed files
used by different tabs. The physical location changed; nothing about how the
files are called changed. Path is loaded via
`addpath(genpath(app.AppRoot + "/src"))` in `startupFcn` (a recursive add, not
a hardcoded list), so any subfolder layout under `src/` works as long as no two
files share a basename (checked at the 2026-07-06 reorg: none do).

- **`src/Input/`** — Input-data tab only.
  - `Parser.m` — constructor `Parser(file_path, H_unit, M_unit, curve_type,
    number_points)`, method `.import()` returns `[H, M, H_raw, M_raw]`. Calls
    `UnitConvertor` and `CurveConvertor` (both now in `Common/`).
  - `CurveConvertor.m` — curve resampling, calls `interparc` (`src/lib/`).
- **`src/Anhysteretic/`** — Anhysteretic-fitting tab only (plus its Output-data
  export of fit-quality metrics).
  - `DataAnhystereticCurve.m` (measured curve container, built from Input
    tab's `Parser` output), `ModeledAnhystereticCurve.m` (modeled curve; calls
    `Common/Utils.get_m` and `Common/Langevin`).
  - `MagneticParameters.m` — converts fitted `Hcr/mcr/Hx` → physical
    `a/alphaMs/Ms/alpha` (calls `Common/Langevin`). Not used by
    Hysteretic/Playground, which use a separate JA `params` struct.
  - `ErrorCalculator.m` (base) + `DiagonalErrorCalculator.m` /
    `HorizontalErrorCalculator.m` / `VerticalErrorCalculator.m` — objective
    functions for fitting (`logH` vs linear, sampled vs continuous). Also used
    by the Output-data tab's parameter export, not by Hysteretic (which has
    its own inline error core).
  - `MagnetizationResidueCalculator.m`, `SusceptibilityResidueCalculator.m`,
    `SemilogDerivativeResidueCalculator.m` — residue definitions (base class
    `Common/ResidueCalculator.m` is shared with Hysteretic's
    `HystereticLeftBranchResidueCalculator.m`).
  - `fit.m` — top-level fit driver: builds `Hhat = logspace(...)` sample grid,
    constructs a `MagneticParameters` → `ModeledAnhystereticCurve`, picks an
    error calculator by `error_type`, minimizes over `[Hcr, mcr, Hx]`.
  - `retrieve_anhysteretic_seeds.m` — seed estimation for the fit (distinct
    from the Hysteretic tab's `retrieve_ja_seeds` **app method** — similar
    name, unrelated feature).
  - `ColorDialog.m` / `ColorDialog.mlapp` — small App-Designer popup (its own
    `.mlapp`, separate from `app.mlapp`) opened by the tab's "Set Colors"
    button; recolors the Anhysteretic M/dM-dH/H·dM-dH plots only (not an
    app-wide theme — see `src/Theme/`).
- **`src/Hysteretic/`** — Hysteretic-fitting tab only.
  - `solve_ja_from_tip.m`, `solve_ja_hysteretic_region.m`,
    `build_ja_major_loop_branch_conditions.m`, `JAFitter.m`, `JAFitUtils.m` — JA
    **fitting** support (distinct from the Playground forward sim; reaches
    `Common/solve_ja_monotonic.m` transitively).
  - `HystereticLeftBranchResidueCalculator.m` — residual **plot** only (the
    fit objective itself, `compute_ja_left_branch_error_core` in
    `app_exported.m`, does its own inline math and doesn't use this class).
- **`src/Playground/`** — Playground tab only (all four sub-modes).
  - `solve_ja_major_loop_playground.m`, `solve_ja_minor_loop_playground.m`,
    `solve_ja_degaussing_playground.m`, `solve_ja_major_harmonics_playground.m` —
    forward simulations (see §5). Each has its own inline branch/segment
    logic and calls `Common/solve_ja_monotonic.m` directly (does **not** go
    through `Hysteretic/build_ja_major_loop_branch_conditions.m`).
  - `PlaygroundUtils.m` — static class holding most Playground UI/state logic
    (see §5). Cross-folder hub: calls `Common/Utils.find_tip`, `Common/
    UnitConvertor`, and the `solve_ja_*_playground` siblings above.
- **`src/Menus/`** — reserved for Project Open/Save/Save-as (and future
  Export dialog) logic. **Currently empty** — that logic still lives inline
  in `app_old_exported.m` (`OpenMenuSelected`, `SaveMenuSelected`,
  `SaveasMenuSelected`, `save`, `default_data_folder`,
  `safe_getfile`/`safe_putfile`/`safe_getdir`); not yet extracted. See
  `src/Menus/README.md`.
- **`src/Theme/`** — reserved for the visual-theme system
  (`theme_palette`/`apply_theme`). **Currently empty** — `app_old.mlapp`
  predates this system; it exists only in `new/app_exported.m` today. See
  `src/Theme/README.md`.
- **`src/Common/`** — used by 2+ tabs; do not assume a change here is
  scoped to one tab.
  - `ja_ode.m` (JA ODE RHS, see §6), `anhysteretic.m` (JA's anhysteretic
    term, called only from `ja_ode.m`), `solve_ja_monotonic.m` (core ODE
    integrator — shared by Hysteretic-fitting **and** Playground).
  - `Langevin.m` / `LangevinPrivate.m` — Langevin function `L(x)` and
    derivative. The most widely shared file in the tree: used by the
    Anhysteretic pipeline (`ModeledAnhystereticCurve`, `MagneticParameters`,
    `Utils`, `retrieve_anhysteretic_seeds`) **and** the JA pipeline
    (`anhysteretic.m`, and directly by `estimate_k_from_coercive_point` in
    `app_exported.m`).
  - `Utils.m` (`get_m`, `find_tip`) — shared by **all four** fitting/sim
    tabs (Input, Anhysteretic, Hysteretic, Playground).
  - `ParserConstants.m` — curve-type/unit-label strings; shared by Input tab
    (`is_last_import_anhysteretic`) and Hysteretic tab (`retrieve_ja_seeds`).
  - `UnitConvertor.m` — shared by Input (via `Parser`), Hysteretic
    (`build_ja_data_cycle`, `get_hysteretic_left_branch_data`), and
    Playground (`convert_playground_curve_units`, `get_data_remanence`, and
    via `PlaygroundUtils`).
  - `Plotter.m` — shared by Input tab (raw-curve preview) and Anhysteretic
    tab (fit plots).
  - `ResiduePlotter.m` — shared by Anhysteretic and Hysteretic residual plots.
  - `ResidueCalculator.m` — base class subclassed by both Anhysteretic's
    three residue calculators and Hysteretic's
    `HystereticLeftBranchResidueCalculator.m`.
- **`src/lib/`** — external libraries (unchanged by the reorg):
  `distance2curve/`, `interparc/`, `minimize/` (`fminlbfgs`, `minimize`,
  `setoptimoptions`).
- **`src/to_organize/`** — files with **zero live callers in
  `app_old_exported.m`** as of the 2026-07-06 audit, kept but not deleted
  (user's call — accommodate their real use when it comes up, rather than
  guessing now):
  - `Bounds.m`, `build_ja_minor_loop_branch_conditions.m` — zero callers
    *anywhere* in `src/`, not even demos. `JAFitter.m`/`JAFitUtils.m` take a
    plain `bounds` struct, never a `Bounds` object; `solve_ja_minor_loop_playground.m`
    has its own independent inline branch logic and never
    calls `build_ja_minor_loop_branch_conditions.m`.
  - `MagneticParametersConstants.m`, `FitConstants.m` — the app hardcodes the
    same literal strings directly (e.g. `'low'`/`'high'`,
    `"Diagonal (H, continuous)"`) instead of referencing these; only
    `demos/demo.m`/`demo_2_components.m` use them today.
  - `ExportUtils.m` — its docstring describes an `open_export_dialog`/
    `do_export` pair that doesn't exist in `app_old_exported.m`'s current
    178 methods; looks like forward-looking prep for the unified Export
    dialog in the `new/` tree, not current behavior. Only
    `demos/demo_hysteretic_playground.m` uses it today. **Likely destination
    once wired up: `src/Menus/`.**
  - `import_src.m` — legacy manual `addpath` list (already stale relative to
    `src/lib/`'s current nesting); superseded by `startupFcn`'s
    `addpath(genpath(...))`. Zero callers in the live app.
  - **Rule for future sessions:** if you find a genuine caller for one of
    these (or discover another file with zero callers), move it out of
    `to_organize/` into its real tab folder (or `Common/`) and delete this
    bullet; don't leave stale files parked here once their use is known.
- **`demos/`** (repo root, **not** under `src/`) — `demo.m`,
  `demo_2_components.m`, `demo_hysteretic_playground.m`: standalone
  command-line usage examples, never called by the app (0 hits in
  `app_old_exported.m`). Each bootstraps with
  `addpath(genpath(fullfile(project_root, 'src')))` rather than the dead
  `import_src.m`. Not tab-owned — exercises the Anhysteretic fit pipeline or
  the JA/Playground solvers directly against `src/`.

---

## 5. Playground subsystem [deep]

Entry points in `app_exported.m`: `CalculatePlotButton_3Pushed` →
`run_playground_minor_loop` (minor) and the major-loop equivalent. `plot_playground`
renders the axes.

### Shared plumbing
- **`PlaygroundUtils.m`** (static class) holds most logic:
  - `get_playground_params` — reads `Ms, a, alpha, k, c` from the JsField_* edit
    fields; validates (`Ms,a,k>0`, `0≤c≤1`).
  - `get_minor_inputs` / app's `get_minor_loop_inputs` — read the `Htip_i` table.
  - `get_data_tip` — tip `(Htip, Mtip)` of the measured Playground curve via
    `Utils.find_tip`.
  - `set_simulation` / `get_simulation_curve` / `clear_simulation` — cache the
    last simulation in appdata (`playground_simulation_cache`) keyed by mode.
  - `is_last_cycle_plot_option`, `normalize_mode_label`, unit helpers.
- Simulation result is cached, then `plot_playground` calls
  `get_simulation_curve` and draws it as a single red line (`plot(ax, H, M, 'r-')`).

### Minor-loop simulation — `solve_ja_minor_loop_playground.m`
Protocol (all driven by the ODE via `solve_ja_monotonic`):
1. Tips sorted **ascending** — **smallest `Htip_i` first**.
   (NOTE: an earlier revision briefly reversed this to largest-first; the correct
   order is **smallest-first**.)
2. Start demagnetized `(H=0, M=0)`.
3. For the first (smallest) tip: monotonic `0 → +Htip` (`delta=+1`).
4. At each tip, run repeated loops `+Htip → −Htip → +Htip` until the stop
   criterion (`Fixed repetitions` count, or `Until convergence` on the returning
   `+Htip` magnetization within `relTol`).
5. **Bridge up** to the next (larger) tip: `+Htip_i → +Htip_{i+1}` with
   `delta=+1` (increasing field), then loop there. Repeat.
6. Returns `Hmod, Mmod` (concatenated) plus an `info` struct with per-tip index
   bookkeeping: `branch_starts`, `tip_starts`, `tip_ends`, `tip_last_loop_starts`,
   `cycles_simulated`, `converged`.

Index bookkeeping convention: segments are concatenated dropping each segment's
first (duplicated boundary) point; `branch_starts`/`tip_last_loop_starts` point at the
shared boundary index. `tip_last_loop_starts(i)..tip_ends(i)` = the last full loop of
tip `i`.

### Plot options (`PlotDropDown_2`: `Last loops only` | `Full history`)
Handled in `PlaygroundUtils.get_simulation_curve`:
- **Full history** — returns the entire concatenated path (one continuous line).
- **Last loops only** — extracts `tip_last_loop_starts(i)..tip_ends(i)` for each tip
  and stitches them with a **`NaN` separator between tips**, so each tip's last
  loop plots as a **separate, disconnected curve** (no join between tip `i`'s last
  point and tip `i+1`'s first point).

### Minor-loop `Htip_i` table defaults [deep]
- `get_minor_loop_default_values(app)`: if measured data is loaded, defaults are
  `[Htip; Htip*2/3; Htip*1/3; NaN]` where `Htip` = data tip (`get_data_tip`);
  otherwise fallback `[1;2;3;NaN]`. (Display order is cosmetic — solver sorts.)
- `minor_loop_table_user_edited` (private logical property) tracks manual edits.
  `maybe_refresh_minor_loop_defaults` re-fills defaults on switch-to-Minor-Loops
  (`HcaseDropDownValueChanged`) and after `import_data`, **only while the table is
  unedited**. Editing any cell (`UITableCellEdit`) sets the flag and stops
  auto-fill so user values are never clobbered. `configure_minor_loop_table`
  resets the flag.

### Field/label greying (enable sync) [deep]
`PlaygroundUtils.sync_major_ui` / `sync_minor_ui` grey out controls that can't be
edited in the current sub-mode, **field and label together** via
`PlaygroundUtils.set_field_enable(field, label, state)` (which calls the
isprop-guarded `set_enable`, safe on old-release uilabels). Major loop: start-point
group (`Hstart`/`Mstart`/`Hamplitude` + labels) keyed off `StartingpointDropDown`,
and `Repetitions` vs `Rel. tolerance` (+ labels) keyed off `StopcriterionDropDown`.
Minor loop: only `Repetitions_2` vs `ReltoleranceEditField_2` (+ labels) keyed off
`StopcriterionDropDown_4` — which **must be wired** to
`StopcriterionDropDown_4ValueChanged` (Design View) for live re-greying, and
`sync_minor_ui` is called from `startupFcn`, `HcaseDropDownValueChanged`, and
`run_playground_minor_loop`. Both `Rel. tolerance` labels carry a "(max 100 loops)"
text + tooltip (set in `startupFcn`) because "Until convergence" still caps at
`max(100, Repetitions)` cycles (per tip for minor loops).

### Degaussing simulation — `solve_ja_degaussing_playground.m` [deep]
Forward AC-demagnetization sim. Entry: `CalculatePlotButton_3Pushed` dispatches to
`run_playground_degaussing` when `PlaygroundUtils.is_degaussing_mode(app)`.
`solve_ja_degaussing_playground(Hstart, Mstart, amplitudes, params, opts)`:
1. `amplitudes` are positive peak reversal fields, sorted **descending** (largest
   swing first) → a decaying envelope regardless of input order.
2. First reversal sign = `-sign(Mstart)` (drive M toward/past zero); alternates
   each step. Targets: `s·(-1)^(i-1)·amplitudes(i)`, then a **final sweep to 0**.
3. Each leg integrated with `solve_ja_monotonic` (delta = `sign(Htarget-Hcur)`;
   zero-length legs skipped). Segments concatenated dropping duplicated boundary
   point (same convention as minor loop).
4. `info`: `mode="Degaussing"`, `amplitudes`, `branch_starts`, `Hfinal`, `Mfinal`;
   `cycles_simulated=0` and empty `tip_last_loop_starts`/`tip_ends` so `get_simulation_curve`
   plots the **full path** (degaussing has no "last loop" plot option).

UI (Degaussing panel, `GridLayout5`), all wired via `sync_degaussing_ui`:
- **Starting point** (`StartingpointDropDown_3`): `Remanence (data)` → `(0, Mr)`,
  Mr from `get_data_remanence` (upper/descending branch of the measured loop via
  `extract_left_branch_uniform_arc` + `interp1` at H=0; needs a **hysteretic**
  import, else warning); `Tip point (data)` → `(Htip, Mtip)` from `get_data_tip`
  (warning if no data); `User-defined` → `Hstart/Mstart` fields. Mstart/Hstart
  fields+labels greyed (`Enable='off'` via `set_enable_safe`) unless User-defined.
- **H amplitude** (`HamplitudeDropDown`): `Automatic` → build envelope from
  `N° of steps` (default 5), `Initial amplitude` (default `Htip`), `Final amplitude`
  (default `Htip/5`) via `get_degaussing_amplitudes_auto` (geometric `logspace`
  decay when both >0, else linear); `User-defined` → growing `UITable_3` (`Htip_i`)
  read descending by `get_degaussing_table_inputs`. The inactive control group
  (auto fields+labels **or** the table) is greyed/disabled.
- `degaussing_user_edited` (private logical) gates default refresh
  (`maybe_refresh_degaussing_defaults`, called on switch-to-Degaussing and after
  `import_data`); set by `DegaussingValueChanged` / `DegaussingTableCellEdit`,
  reset by `configure_degaussing_table`. `set_enable_safe` skips components lacking
  an `Enable` property (older-release uilabel safety).

### Major loop with harmonics — `solve_ja_major_harmonics_playground.m` [deep]
Forward sim of a major loop driven by a **distorted (harmonic) field**
`H(θ) = Σ_j A_j·sin(k_j·θ + φ_j)` over one period `θ∈[0,2π)`. Entry:
`CalculatePlotButton_3Pushed` dispatches to `run_playground_major_harmonics` when
`PlaygroundUtils.is_harmonics_mode(app)`. Because JA is **rate-independent**, only
the field's turning points matter:
1. `localPeriodVertices` samples one period on a dense grid (`samplesPerPeriod`,
   default 4000) and finds the local extrema via cyclic neighbour tests → the
   per-period vertex field values `pv` (in θ order). Harmonics add extra extrema →
   **minor loops nested inside the major loop**.
2. Bridge from `(Hstart,Mstart)` to `pv(1)`, then for each period walk the targets
   `pv(2..end), pv(1)` (returns to `pv(1)`), each leg via `solve_ja_monotonic`
   (`delta=sign(Δ)`, zero-length legs skipped). Same drop-duplicate-boundary
   concatenation as the other modes.
3. Steady state: `Fixed repetitions` = number of periods; `Until convergence`
   compares period-end M at `pv(1)` within `relTol` (cap 200 periods).
4. `info`: `mode="Major Loop Harmonics"`, `cycles_simulated`, `branch_starts`
   (per-period boundary indices), `tip_last_loop_starts=[branch_starts(end)]`,
   `tip_ends=[numel(Hmod)]`, `vertices=pv`. The `tip_last_loop_starts/tip_ends` pair
   makes `get_simulation_curve` slice the **last full period** for the `Last period
   only` plot option (a single closed loop, no NaN separators).

UI (`MajorloopwithharmonicsPanel`, `GridLayout7`): starting point
(`StartingpointDropDown_5`: Demagnetized / Tip point (data) / User-defined — same
semantics as the major loop; `Mstart_3`/`Hstart_3` greyed unless User-defined),
stop criterion (`StopcriterionDropDown_6`) + `PeriodsEditField` /
`ReltoleranceEditField_4` (the `_4` suffix because `_1`/`_2`/`_3` are taken; both
field and label grey out together in `sync_harmonics_ui`). There is **no plot-option
dropdown** for this panel (`PlotDropDown_3`, which offered `Last period only` |
`Full history`, was removed from Design View 2026-07-10 — see caveat below); this
mode always shows the full simulated history. It has a growing harmonics table `UITable2` with
columns **Order / Amplitude [A/m] / Phase [deg]** (row 1 = fundamental; blank phase
→ 0°; phases converted deg→rad in `get_harmonics_inputs`). Defaults
(`get_harmonics_default_table_values`): `[1,Htip,0; 2,0.40·Htip,60; 3,0.60·Htip,45;
5,0.35·Htip,30; NaN]` (fundamental at the data tip, else `A1=1`) — chosen to show
several **asymmetric** nested minor loops: the 2nd (even) harmonic breaks the
half-wave top/bottom symmetry (odd-only harmonics stay point-symmetric at *any*
phase), and the strong staggered-phase 2nd/3rd/5th give 10 field reversals/period.
`harmonics_user_edited` (private logical) gates `maybe_refresh_harmonics_defaults`;
set by `HarmonicsTableCellEdit`, reset by `configure_harmonics_table`. All non-table,
non-plot controls share `HarmonicsValueChanged` (sync + clear cache + replot);
`sync_harmonics_ui` handles enable states. **Mode-label caveat**: `"Major loop with harmonics"` contains the
substring `"major loop"`, so `normalize_mode_label`, `sync_playground_mode_ui` and
the dispatch chains **must test `"harmonic"` first**.

**Component-naming caveat (learned the hard way — see git history for the
incident):** `StartingpointDropDown_4`, `StopcriterionDropDown_5` and
`ReltoleranceEditField_3` are **already taken** by the pre-existing Hysteretic
fitting tab (`GridLayout2`) — the Harmonics panel's siblings are
`StartingpointDropDown_5`/`StopcriterionDropDown_6`/`ReltoleranceEditField_4`
instead, and `UITable2`/`MajorloopwithharmonicsPanel` are App-Designer's own
auto-generated names (not manually renamed). **Before proposing
any new `app_exported.m` component name, grep the whole file for that exact
candidate string first** — do not assume the next-looking numeric suffix is free;
another feature may already hold it, and a collision produces a duplicate property
declaration that fails to even construct the class (a hard crash on every app
launch, not a subtle bug). `PlotDropDown_2` on the Minor loop panel is deliberately
left unwired: wiring it to clear-and-replot would blank the curve on every
plot-option toggle since the slice is derived from the cached simulation, not
recomputed. The Harmonics panel's equivalent, `PlotDropDown_3`, was **deleted
from Design View 2026-07-10** (same reasoning didn't stop it from being removed
outright rather than kept unwired) — `PlaygroundUtils.get_plot_option` now
hardcodes `"Full history"` for harmonics mode instead of reading a component
that no longer exists. **Gotcha hit by this deletion:** deleting a component from
Design View does not clean up stray `app.<ComponentName>.Value` reads elsewhere
in `src/**` — grep the whole `src/` tree for a deleted component's name before
considering a Design View deletion complete, since those reads throw only at
runtime (not at construction), same failure mode as a dangling reference.

---

## 6. Jiles–Atherton ODE model [deep]

`ja_ode(H, M, p, delta)` with `p = {Ms, a, alpha, k, c}`, `delta = sign(dH) ∈ {+1,-1}`:

```
Heff        = H + alpha*M
[Manh, dManh_dHeff] = anhysteretic(Heff, p)      % Manh = Ms*L(Heff/a)
deltaM      = 0.5*(1 + sign(Manh - M)*delta)      % directional switch
num         = k*delta*c*dManh_dHeff + (Manh - M)*deltaM
den         = k*delta - alpha*num
dM/dH       = num/den
```

`solve_ja_monotonic(Hstart, Hend, Mstart, params, delta, opts)` integrates this with
`ode23tb` over `[Hstart, Hend]`; default opts `odeset('RelTol',1e-7,'AbsTol',1e-6)`.
Returns `Hsol, Msol` as column vectors (adaptive step). If `Hstart==Hend` it returns
the single point.

---

## 7. Units [map]

`UnitConvertor.m` is a pure scaling dictionary (`UnitConversions`) plus
`convert_H_M`. Base unit is `A/m`. `B`-type M-units subtract `H`
(`M = μ0-scaled − H`) / add it back on the way out. Because it's pure arithmetic,
`NaN` values pass through unchanged (relied on by the "Last loops only" separators).
The app also has `convert_playground_curve_units` for the Playground axes dropdowns.

---

## 8. Gotchas / conventions

- **Never edit only `app_exported.m` and consider it done** — see §2.
- Two separate minor-loop input readers exist (`PlaygroundUtils.get_minor_inputs`
  and app's `get_minor_loop_inputs`); both sort ascending, but the **solver's own
  sort governs** simulation order.
- Playground simulations are **forward simulations** using JA params; the fitting
  tabs solve the inverse problem with the distribution params — don't conflate.
- MATLAB GUI can't be run headless here, so Playground changes are typically
  code-verified (logic + index bookkeeping), not run-verified.
- Persistent cross-session facts live in the Claude memory index
  (`.../memory/MEMORY.md`): a-root selection rule, MATLAB R2024a environment /
  mlapp patching notes, the distribution-model project, and the
  "flag app_exported.m changes" rule.
- **Keep Code View thin (as of 2026-07-08).** Every tab now has its own
  `<Tab>Utils.m` (`AnhystereticUtils`, `HystereticUtils`, `PlaygroundUtils`,
  `InputUtils`, `MenuUtils`), plus `Common/FileDialogUtils.m` for anything
  shared by 2+ tabs. New business logic for a tab goes in that file as a
  static method + a one-line delegator in `app_exported.m` — never written
  directly into `app.mlapp`'s Code View. Only callbacks, `createComponents`,
  and these thin delegators belong on the app class itself. Exception:
  `createCallbackFcn` is a `protected` method of `matlab.apps.AppBase`, so
  any line that calls it (wiring a `CellEditCallback` etc.) must stay on the
  app class — a Utils static method cannot call it even with `app` passed in.
- **New numeric fields default to high precision.** Any new editable,
  non-integer field must be a `NumericEditField` (not `EditField`) with an
  explicit `ValueDisplayFormat` (`'%.6g'` generally, `'%.5e'` for
  small/scientific values like `alpha`) — never a text field storing a
  formatted string, which silently truncates precision on every re-display.
  For `uitable` cells, mirror the Anhysteretic `TableFittedParameters`
  pattern: a full-precision numeric array is the source of truth, the table
  shows a `format_sigfigs`-style 6-sig-fig rendering, and selecting a cell
  reveals full precision for editing.

---

## 9. Versioning policy [deep]

The version string used to live in three places that could silently drift
apart: the `startupFcn` message in `app_exported.m` ("1.0.3-beta"), the splash
screen in `MagAnalyst.m` ("2.0.0"), and the App Designer "Sharing details"
Version field (still "1.0"). As of 2026-07-09 the first two are wired to a
single source of truth, **`AppVersion.m`** (plain function at the repo root,
next to `MagAnalyst.m` and `app.mlapp`, returning a string like `"2.0"`) —
`MagAnalyst.m`'s splash and `app_exported.m`'s `startupFcn` both call it.

**Format is `MAJOR.MINOR` only — no PATCH component.** App Designer's Sharing
Details Version field requires this two-part format, so `AppVersion.m` must
match it exactly (e.g. `"2.0"`, `"2.1"`, not `"2.0.0"` or `"2.0.1"`).

**The Sharing-details Version field can't be wired to this file.** It's package
metadata (`metadata/coreProperties.xml` inside the `.mlapp` zip, `<cp:version>`)
set via App Designer's Share button → *Sharing Details…* dialog, not part of
Code View — the same silent-overwrite-on-save risk described in §2a applies to
it, so don't patch that XML directly by default; ask the user to update it
by hand in the dialog whenever `AppVersion.m` changes. **Every port guide must
include an explicit step telling the user to set the Sharing Details Version
field to the new value in Design View** (see §2a) — don't rely on a separate
verbal reminder, since the guide is the artifact she actually works from.

**Bump `AppVersion.m` (and the Sharing Details field to match) every time a
change is committed that a user would notice** — with only two components,
both bug fixes and small additions bump MINOR; only breaking changes bump
MAJOR:
- **MINOR** (`x.Y+1`): anything user-visible that doesn't break existing
  projects/workflows — bug fixes, UI text corrections, new Playground modes,
  new export options, new tabs.
- **MAJOR** (`X+1.0`): breaking changes — saved-project (`.mat`) format
  changes that break old project files, removed features, or a large
  architectural rework (e.g. the `src/` tab-based reorg, or bundling several
  feature additions + bug fixes into one release, both plausible reasons the
  2026-07-xx `1.0.3-beta → 2.0.0` jump was made).

Don't bump the version for changes with no user-visible effect (comments,
internal refactors that don't change behavior, this doc).

---

## 10. Git commit conventions [deep]

**Commit messages carry only the user's name — no `Co-Authored-By: Claude`
trailer.** This overrides the harness's default commit-message behavior for
this repo. Author/committer identity still comes from the normal git config
(`user.name`/`user.email`); this rule is only about not appending the
Claude co-author trailer line.

**This has been missed twice already** (the `4a2920c` and `87d642c` commits
both carry the trailer despite this section already existing) — the harness
defaults to appending it and this instruction is easy to forget when
assembling the commit-message heredoc under §"Committing changes with git" at
the top of the system prompt. **Before running `git commit`, re-check the
exact message text about to be passed and confirm it has no `Co-Authored-By`
line at all** — don't rely on remembering this rule in the abstract; verify
the literal string you're about to commit.
