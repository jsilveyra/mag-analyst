![Image](https://github.com/jsilveyra/mag-analyst/blob/main/assets/logo_light_maganalyst.png#gh-light-mode-only)
![Image](https://github.com/jsilveyra/mag-analyst/blob/main/assets/logo_dark_maganalyst.png#gh-dark-mode-only)

# *A MATLAB toolbox for magnetization analysis*

## Table of contents

1. [Authors](#authors)
2. [Statement of need](#statement-of-need)
3. [Setup and usage instructions](#setup-and-usage-instructions)
4. [Overview of the GUI](#overview-of-the-gui)
5. [Description of the files and directory structure](#description-of-the-files-and-directory-structure)
6. [Bundled tools](#bundled-tools)
7. [Third-party libraries](#third-party-libraries)
8. [User's Guide](#users-guide)
9. [Sample data](#sample-data)
10. [Cite as](#cite-as)
11. [Contact us](#contact-us)
12. [License](#license)
13. [Acknowledgment](#acknowledgment)

## Authors

- Matías Ignacio González
- Marina Zoe Petean
- Tomás Francisco González
- Juan Manuel Conde Garrido
- Josefina María Silveyra

University of Buenos Aires – CONICET, Buenos Aires, Argentina.

## Statement of need

The accurate description of magnetization is crucial for designing devices with soft magnetic cores. MagAnalyst is an easy-to-use MATLAB toolbox that models the magnetization of soft magnetic materials.

The toolbox implements, in an easy-to-use graphical user interface, strategies designed by the senior contributors of the project, Conde Garrido and Silveyra, to fit — accurately, quickly, and without requiring prior knowledge of the model-parameter search space or a background in optimization methods:

- the **anhysteretic magnetization**, with a rule of mixtures of Langevin-Weiss components;
- the **hysteretic magnetization**, with the classical rate-independent Jiles-Atherton model.

Moreover, an interactive **Playground** forward-simulates major loops, nested minor loops, AC degaussing, and loops driven by distorted (harmonic) fields with the classical rate-independent Jiles-Atherton model. Setting either k = 0 or c = 1 retrieves the single-component Langevin-Weiss (anhysteretic) model.

These features are also available programmatically, without the GUI, to embed them into custom scripts (see the demo scripts in `demos/`).

A unified **Export** dialog (*Project → Export…*) exports results — measured/processed data, anhysteretic and hysteretic fits, Playground simulations, optimization-progress curves, and figures — as CSV, TXT, and image files, while *Project → Save* stores the full session for later reuse.

The toolbox is shared as open source with the aim of allowing researchers to tailor it to their specific needs, such as variants of the classic Jiles-Atherton model (temperature dependence, rate dependence, etc.) or exploring other optimization methods.

## Setup and usage instructions

Obtain a copy by downloading and unzipping the latest [release](https://github.com/jsilveyra/mag-analyst/releases), or clone MagAnalyst instead, e.g. using: `git clone https://github.com/jsilveyra/mag-analyst`.

We recommend using [GitHub Desktop](https://desktop.github.com/), which allows users to easily synchronize with the latest version of MagAnalyst.

After downloading the main folder and placing it in a suitable location on your local machine, MagAnalyst is ready to use.

MagAnalyst is platform-agnostic and works on Windows, macOS, or Linux. All paths are handled relative to the toolbox root (for example `data/sample_data/`), so you can place the MagAnalyst folder anywhere you like; if you move it after opening a saved project you may need to re-import the curve file.

To start the graphical user interface, run the `MagAnalyst.m` launcher (type `MagAnalyst` in the MATLAB Command Window). It shows a loading splash while the app builds and then opens the GUI. The first launch after starting MATLAB is slower because MATLAB warms up the App Designer graphics framework; later launches in the same session are faster. Alternatively, you can run the `app.mlapp` or `app_exported.m` files directly.

If you prefer to use MagAnalyst from the command line (or to call it from your own scripts), follow the demo scripts in `demos/`, one per workflow:

- `demo_1_anhysteretic_1comp.m` — anhysteretic fit with a single component (automatic seed retrieval, fit, physical parameters, plots; also shows how to pick a `solver`, see below);
- `demo_2_anhysteretic_2comp.m` — anhysteretic fit with two components;
- `demo_3_hysteretic_ja_fit.m` — Jiles-Atherton hysteretic fit, seeded from a single-component anhysteretic fit;
- `demo_4_playground_major_loop.m` — forward simulation of a major hysteresis loop;
- `demo_5_playground_minor_loop.m` — forward simulation of nested minor loops;
- `demo_6_playground_degaussing.m` — forward simulation of an AC-degaussing protocol;
- `demo_7_playground_harmonics.m` — forward simulation of a major loop driven by a distorted (harmonic) field.

The demo scripts build their data paths with MATLAB's `fullfile` helper (e.g., `fullfile('data','sample_data','2022_AIP','MnZn_ferrite.csv')`), so they load the same files on Windows, macOS, and Linux without manual path tweaks.

MagAnalyst 2.0.0 was implemented and tested with MATLAB R2025b. Compatibility with earlier releases differs depending on what you want to do:

- **Using the app** (running `MagAnalyst.m`, `app_exported.m`, or `app.mlapp` as-is): this is the more forgiving case. The GUI is built on `uifigure`/App Designer components and functions such as `exportgraphics` and `uigridlayout`, which have been part of base MATLAB since roughly R2019b–R2020a, so a normal install from that era onward should be able to *run* the app. `app.mlapp`'s own App Designer metadata reports a minimum supported release of R2018a, though that figure only accounts for the UI components placed in Design View, not for individual function calls made in Code View (like `exportgraphics`), so treat R2019b/R2020a as the more realistic practical floor. The demo scripts under `demos/` and the standalone `src/**` functions have no App Designer dependency at all and should run on considerably older releases.
- **Editing `app.mlapp` in App Designer**: this is the real constraint. A `.mlapp` file saved by a given MATLAB release's App Designer generally **cannot be opened for editing in an older release** — App Designer's project format only saves forward, not backward. Since this repository's `app.mlapp` was last saved with R2025b, editing it (as opposed to just running it) requires R2025b or later. `app_exported.m` (the plain-`.m` mirror of the same code, see below) has no such restriction and can be read/edited in any editor or MATLAB release, but it is a generated artifact — changes made only there do not propagate back into `app.mlapp` (see the note on the two files below).

In short: the App Designer *file format* is the strict, version-locked part of MagAnalyst; running the app, and reading or editing the plain `.m` source, is not.

## Overview of the GUI

The application is organized into tabs:

1. **Input data** — import a measured dataset (anhysteretic curve or symmetric hysteresis loop), choose the fields and units of both axes (including mass magnetization, σ in emu/g = Am²/kg), and preview the raw and processed curves.
2. **Anhysteretic fitting** — fit the physically based multicomponent model (per-component `Hcr`, `m(Hcr)`, `Hx`) and retrieve the magnetic parameters (`Ms`, `a`, `α`) plus derived physical quantities; view the magnetization, susceptibility, and semilog-derivative plots with residuals. A live optimization-progress plot (error vs. iteration) is shown during fits, which can be run until convergence or stopped at any time. A **Solver** dropdown selects the optimization algorithm — PRIMA-BOBYQA, tuned npt (default) or Nelder-Mead — see [User's Guide § Optimization technique](users-guide.md#optimization-technique).
3. **Hysteretic fitting** — fit the Jiles-Atherton parameters (`Ms`, `a`, `α`, `k`, `c`) to a measured hysteresis loop (left branch or entire loop), with the same live progress plot, stop control, and Solver dropdown.
4. **Playground** — forward-simulate the Jiles-Atherton model: **major loop**, **minor loops**, **degaussing**, and **major loop with harmonics** (a distorted driving field).

Results are saved through a single Export action in the Project menu (*Project → Export…*), which opens a dialog listing every exportable artifact — measured/processed data, anhysteretic fit (parameters, curve, residuals, errors), hysteretic fit (parameters, loop, residuals), Playground simulations (curve, metadata), optimization-progress data, and figures — as CSV, TXT, or image (PNG/PDF/SVG) files. Whole sessions can be saved and reopened via *Project → Save / Open*.

## Description of the files and directory structure

```tree
├── MagAnalyst.m          # Launcher: shows a loading splash, then opens the GUI
├── AppVersion.m          # Single source of truth for the version string
├── app.mlapp             # Main App Designer GUI (edit here)
├── app_exported.m        # Exported app code (run by the launcher; kept in sync with app.mlapp)
├── README.md
├── users-guide.md         # User's Guide: methodology and model documentation (theory + implementation)
├── license.txt
├── assets/               # Logos and UI images
├── data/
│   └── sample_data/      # Example curves, organized by the article that analyzed them
├── demos/                # Seven standalone command-line examples (no GUI required)
├── tools/
│   └── plot_digitizer/   # MagAnalyst Plot Digitizer: standalone GUI to extract
│                         # curves from published figures (see its own README.md)
└── src/
    ├── Input/            # Input-data tab: CSV import, unit conversion, curve resampling
    ├── Anhysteretic/     # Anhysteretic-fitting tab: model, fits, seeds, residuals
    ├── Hysteretic/       # Hysteretic-fitting tab: Jiles-Atherton fitter and solvers
    ├── Playground/       # Playground tab: the four forward-simulation modes
    ├── Menus/            # Project menu: Open/Save, New, unified Export dialog
    ├── Common/           # Code shared by two or more tabs (Langevin, JA ODE, error metrics, plotting, units)
    ├── Theme/            # Runtime visual theme (single palette tweak point)
    └── lib/              # External libraries (minimize, bobyqa_mat, interparc, distance2curve)
```

The `src/` tree is organized by GUI tab: each tab has its own folder with a `<Tab>Utils.m` static class holding that tab's logic, and everything used by two or more tabs lives in `src/Common/`.

## Bundled tools

Two components of MagAnalyst are also released standalone on the MATLAB File Exchange, so each carries its own README and license file and is documented for an outside reader. Both are bundled here and need no separate installation.

### `bobyqa_mat` — bound-constrained derivative-free optimizer

Location: [`src/lib/bobyqa_mat/`](src/lib/bobyqa_mat/) · own [README](src/lib/bobyqa_mat/README.md) and [license](src/lib/bobyqa_mat/license.txt)

The default option in both fitting tabs' **Solver** dropdown (*PRIMA-BOBYQA, tuned npt*): a pure-MATLAB, bound-constrained implementation of Powell's BOBYQA algorithm (no MEX, no compiler, no toolbox), reusing PRIMA's ([Zhang et al.](https://github.com/libprima/prima), BSD-3) incremental model-update machinery and adding an exact box-constrained trust-region solver. `bobyqa_mat_tuned` picks the number of interpolation points (`npt`) automatically from the parameter count. See its README for the benchmark behind that rule and [User's Guide § Optimization technique](users-guide.md#optimization-technique) for the citations and a summary.

Self-test: `cd src/lib/bobyqa_mat` then `test_bobyqa_mat`. Worked examples: `demo_bobyqa_mat`.

### MagAnalyst Plot Digitizer — extract curves from published figures

Location: [`tools/plot_digitizer/`](tools/plot_digitizer/) · own [README](tools/plot_digitizer/README.md) and [license](tools/plot_digitizer/license.txt)

A standalone MATLAB GUI (version 1.0.0) that recovers numerical `(x, y)` data from a raster image of a plot — a scanned or downloaded figure from the literature — so it can be imported into MagAnalyst's Input-data tab as a CSV. It calibrates the axes from two points per axis (linear or logarithmic), finds curve colors automatically, and traces either continuous lines (Zhang–Suen skeletonization) or discrete data markers (normalized cross-correlation template matching plus Hough circle detection). Whole digitizing sessions can be saved and reopened as `.pdig` project files, and results exported as CSV.

It is **not** loaded by the main app's path setup; launch it on its own:

```matlab
addpath(fullfile('tools','plot_digitizer'));
PlotDigitizer
```

Self-test: `cd tools/plot_digitizer` then `test_plot_digitizer`. Guided example: `demo_plot_digitizer`.

## Third-party libraries

MagAnalyst also bundles the following third-party libraries under `src/lib/`:

- [minimize](https://www.mathworks.com/matlabcentral/fileexchange/24298-minimize) (Nelder-Mead via `fminsearch`) to find the constrained minimum of the objective function starting at the user's initial estimates — the second solver offered by the fitting tabs' Solver dropdown.
- [interparc](https://www.mathworks.com/matlabcentral/fileexchange/34874-interparc) to calculate a set of equally spaced points from an original curve with unevenly spaced points.
- [distance2curve](https://www.mathworks.com/matlabcentral/fileexchange/34869-distance2curve) to compute the minimum Euclidean distance from data points to the modeled curve for the continuous diagonal error metrics.

## User's Guide

The [User's Guide](users-guide.md) provides the background of MagAnalyst: first a high-level overview of the models and workflows, then the full low-level documentation — theory, parameter-retrieval strategy (including the automatic seed-estimation algorithm), error metrics, optimization technique, the Jiles-Atherton fitting and simulation algorithms, and the supported unit conversions — with references.

## Sample data

The `data/sample_data/` folder ships example curves, organized by the article that analyzed them:

- `2022_AIP/` — **Mn-Zn ferrite**: a soft ferrite (Mn<sub>0.51</sub>Zn<sub>0.44</sub>Fe<sub>2.05</sub>O<sub>4</sub>) with very low anisotropy, similar to the curve analyzed in the [JMMM article](https://doi.org/10.1016/j.jmmm.2021.168430) and in the [AIP Advances article](https://doi.org/10.1063/9.0000328); illustrated by YouTube videos fitting [one component](https://youtu.be/r4jyjOQ61yY) and [two components](https://youtu.be/7WqBK7YCKWY). **JNEX-900**: a non-oriented electrical steel analyzed in the [AIP Advances article](https://doi.org/10.1063/9.0000328).
- `2023_JOM/` — **Finemet TA**: a Finemet® alloy (Fe<sub>73.5</sub>Si<sub>13.5</sub>B<sub>9</sub>Nb<sub>3</sub>Cu<sub>1</sub>) nanocrystallized under transverse field annealing and measured along the longitudinal direction of the ribbon. **GOSS 67 MPa**: a grain-oriented silicon steel sheet, cut parallel to the rolling direction, longitudinally compressed up to 67 MPa. Both analyzed in the [JOM article](https://doi.org/10.1007/s11837-023-05704-x).
- `2025_IEEETOM/` — the five hysteresis loops (nanocrystalline alloys with longitudinal and transverse anisotropy, non-oriented silicon steel, soft ferrite, and Terfenol-D) used to validate the blind Jiles-Atherton fitting method in the [IEEE Transactions on Magnetics article](https://doi.org/10.1109/TMAG.2025.3632479).

Each CSV data table stores an anhysteretic curve or a hysteresis loop, where the first and second columns correspond to the horizontal- and vertical-axis fields, respectively (the headers specify the fields and units). Projects saved from the GUI (*Project → Save*) are TXT files that can be reopened with *Project → Open*.

## Cite as

If you use MagAnalyst in your work, please cite:

- J. M. Silveyra, M. I. González, T. F. González, and J. M. Conde Garrido, "MagAnalyst: A MATLAB Toolbox for Anhysteretic Magnetization Analysis," IEEE Transactions on Magnetics, vol. 60, pp. 1-6, 2024. https://doi.org/10.1109/TMAG.2024.3408681

If you use the hysteretic Jiles-Atherton fitting features, please also cite:

- J. M. Conde Garrido, J. Ugarte Valdivielso, J. I. Aizpurua, M. Barrenetxea Iñarra, and J. M. Silveyra, "Blind Efficient Method for Optimizing Jiles-Atherton Model Parameters," IEEE Transactions on Magnetics, vol. 62, pp. 1-11, 2026. https://doi.org/10.1109/TMAG.2025.3632479

You may also cite the following papers on the approach used by MagAnalyst to describe anhysteretic curves:

- J. M. Silveyra and J. M. Conde Garrido, "A physically based model for soft magnets' anhysteretic curve," JOM, vol. 75, pp. 1810-1823, 2023. https://doi.org/10.1007/s11837-023-05704-x
- J. M. Silveyra and J. M. Conde Garrido, "On the anhysteretic magnetization of soft magnetic materials," AIP Advances, vol. 12, p. 035019, 2022. https://doi.org/10.1063/9.0000328
- J. M. Silveyra and J. M. Conde Garrido, "On the modelling of the anhysteretic magnetization of homogeneous soft magnetic materials," Journal of Magnetism and Magnetic Materials, vol. 540, p. 168430, 2021. https://doi.org/10.1016/j.jmmm.2021.168430

If you want to use MagAnalyst to fit mass-magnetization curves, follow and cite the approach described in:

- J. M. Silveyra, A. Rosales Rivera, N. Salazar Henao, D. Salazar, and J. M. Conde Garrido, "Magnetometry analysis via a multicomponent Langevin-Weiss model with susceptibility-dependent demagnetization," Journal of Magnetism and Magnetic Materials, vol. 647, p. 174000, 2026. https://doi.org/10.1016/j.jmmm.2026.174000

Which paper documents which feature: the multicomponent Langevin-Weiss law of mixtures and the `Hcr` / `m(Hcr)` search-space transformation behind the **Anhysteretic fitting** tab are developed in the JMMM 2021, AIP Advances 2022 and JOM 2023 papers; the blind Jiles-Atherton initialization and the coercive-point `k` estimate behind the **Hysteretic fitting** tab in the IEEE TMAG 2026 paper; and mass-magnetization (σ) analysis in the JMMM 2026 paper. The [User's Guide](users-guide.md#references) carries the complete reference list, including the algorithmic and numerical-method citations.

The papers themselves are not redistributed with the toolbox. If you don't have access to any of them, request them through [ResearchGate](https://www.researchgate.net/profile/Josefina-Silveyra) or write to jsilveyra@fi.uba.ar! We will be happy to share them with you.

## Contact us

If you encounter bugs or problems using MagAnalyst, have any suggestions for improving the software, or are interested in receiving email updates about MagAnalyst, please write to jsilveyra@fi.uba.ar.

## License

MagAnalyst is provided under the [MIT License](https://github.com/jsilveyra/mag-analyst/blob/main/license.txt).

## Acknowledgment

The University of Buenos Aires (UBA) and CONICET provided financial support for this project.
Any opinions, findings, conclusions, or recommendations expressed in this website are those of the author(s) and do not necessarily reflect the views of UBA or CONICET.
