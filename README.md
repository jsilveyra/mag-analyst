![Image](https://github.com/jsilveyra/mag-analyst/blob/main/assets/logo_light_maganalyst.png#gh-light-mode-only)
![Image](https://github.com/jsilveyra/mag-analyst/blob/main/assets/logo_dark_maganalyst.png#gh-dark-mode-only)

# *A MATLAB toolbox for magnetization analysis*

## Table of contents

1. [Authors](#authors)
2. [Statement of need](#statement-of-need)
3. [Setup and usage instructions](#setup-and-usage-instructions)
4. [Overview of the GUI](#overview-of-the-gui)
5. [Description of the files and directory structure](#description-of-the-files-and-directory-structure)
6. [External libraries](#external-libraries)
7. [Explanation document](#explanation-document)
8. [Sample data](#sample-data)
9. [Cite as](#cite-as)
10. [Contact us](#contact-us)
11. [License](#license)
12. [Acknowledgment](#acknowledgment)

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

- `demo_1_anhysteretic_1comp.m` — anhysteretic fit with a single component (automatic seed retrieval, fit, physical parameters, plots);
- `demo_2_anhysteretic_2comp.m` — anhysteretic fit with two components;
- `demo_3_hysteretic_ja_fit.m` — Jiles-Atherton hysteretic fit, seeded from a single-component anhysteretic fit;
- `demo_4_playground_major_loop.m` — forward simulation of a major hysteresis loop;
- `demo_5_playground_minor_loop.m` — forward simulation of nested minor loops;
- `demo_6_playground_degaussing.m` — forward simulation of an AC-degaussing protocol;
- `demo_7_playground_harmonics.m` — forward simulation of a major loop driven by a distorted (harmonic) field.

The demo scripts build their data paths with MATLAB's `fullfile` helper (e.g., `fullfile('data','sample_data','2022_AIP','MnZn_ferrite.csv')`), so they load the same files on Windows, macOS, and Linux without manual path tweaks.

MagAnalyst 2.13 was implemented and tested with MATLAB R2025b. It relies on App Designer / `uifigure` features (e.g. `exportgraphics`, `uigridlayout`); the authors cannot guarantee that the code runs on earlier versions.

## Overview of the GUI

The application is organized into tabs:

1. **Input data** — import a measured dataset (anhysteretic curve or symmetric hysteresis loop), choose the fields and units of both axes (including mass magnetization, σ in emu/g = Am²/kg), and preview the raw and processed curves.
2. **Anhysteretic fitting** — fit the physically based multicomponent model (per-component `Hcr`, `m(Hcr)`, `Hx`) and retrieve the magnetic parameters (`Ms`, `a`, `α`) plus derived physical quantities; view the magnetization, susceptibility, and semilog-derivative plots with residuals. A live optimization-progress plot (error vs. iteration) is shown during fits, which can be run until convergence or stopped at any time.
3. **Hysteretic fitting** — fit the Jiles-Atherton parameters (`Ms`, `a`, `α`, `k`, `c`) to a measured hysteresis loop (left branch or entire loop), with the same live progress plot and stop control.
4. **Playground** — forward-simulate the Jiles-Atherton model: **major loop**, **minor loops**, **degaussing**, and **major loop with harmonics** (a distorted driving field).

Results are saved through a single Export action in the Project menu (*Project → Export…*), which opens a dialog listing every exportable artifact — measured/processed data, anhysteretic fit (parameters, curve, residuals, errors), hysteretic fit (parameters, loop, residuals), Playground simulations (curve, metadata), optimization-progress data, and figures — as CSV, TXT, or image (PNG/PDF/SVG) files. Whole sessions can be saved and reopened via *Project → Save / Open*.

## Description of the files and directory structure

```tree
├── MagAnalyst.m          # Launcher: shows a loading splash, then opens the GUI
├── AppVersion.m          # Single source of truth for the version string
├── app.mlapp             # Main App Designer GUI (edit here)
├── app_exported.m        # Exported app code (run by the launcher; kept in sync with app.mlapp)
├── README.md
├── explanation-document.md  # Methodology and model documentation (theory + implementation)
├── license.txt
├── articles/             # Reference papers behind the implemented methods
├── assets/               # Logos and UI images
├── data/
│   └── sample_data/      # Example curves, organized by the article that analyzed them
├── demos/                # Seven standalone command-line examples (no GUI required)
└── src/
    ├── Input/            # Input-data tab: CSV import, unit conversion, curve resampling
    ├── Anhysteretic/     # Anhysteretic-fitting tab: model, fits, seeds, residuals
    ├── Hysteretic/       # Hysteretic-fitting tab: Jiles-Atherton fitter and solvers
    ├── Playground/       # Playground tab: the four forward-simulation modes
    ├── Menus/            # Project menu: Open/Save, New, unified Export dialog
    ├── Common/           # Code shared by two or more tabs (Langevin, JA ODE, error metrics, plotting, units)
    ├── Theme/            # Runtime visual theme (single palette tweak point)
    └── lib/              # External libraries (minimize, interparc, distance2curve)
```

The `src/` tree is organized by GUI tab: each tab has its own folder with a `<Tab>Utils.m` static class holding that tab's logic, and everything used by two or more tabs lives in `src/Common/`.

## External libraries

MagAnalyst currently uses the following third-party libraries (bundled under `src/lib/`):

- [minimize](https://www.mathworks.com/matlabcentral/fileexchange/24298-minimize) to find the constrained minimum of the objective function starting at the user's initial estimates.
- [interparc](https://www.mathworks.com/matlabcentral/fileexchange/34874-interparc) to calculate a set of equally spaced points from an original curve with unevenly spaced points.
- [distance2curve](https://www.mathworks.com/matlabcentral/fileexchange/34869-distance2curve) to compute the minimum Euclidean distance from data points to the modeled curve for the continuous diagonal error metrics.

## Explanation document

The [Explanation document](explanation-document.md) provides the background of MagAnalyst: first a high-level overview of the models and workflows, then the full low-level documentation — theory, parameter-retrieval strategy, error metrics, optimization technique, the Jiles-Atherton fitting and simulation algorithms, and the supported unit conversions — with references.

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

If you don't have access to any of these articles, request them through ResearchGate! We will be happy to share them with you.

## Contact us

If you encounter bugs or problems using MagAnalyst, have any suggestions for improving the software, or are interested in receiving email updates about MagAnalyst, please write to jsilveyra@fi.uba.ar.

## License

MagAnalyst is provided under the [MIT License](https://github.com/jsilveyra/mag-analyst/blob/main/license.txt).

## Acknowledgment

The University of Buenos Aires (UBA) and CONICET provided financial support for this project.
Any opinions, findings, conclusions, or recommendations expressed in this website are those of the author(s) and do not necessarily reflect the views of UBA or CONICET.
