# Reference papers

The papers behind the methods MagAnalyst implements. Only versions we are entitled
to redistribute are included here; for the rest, the citation and DOI are given below
and **a private copy of the published version can be requested from the authors
through [ResearchGate](https://www.researchgate.net/profile/Josefina-Silveyra) or by
e-mail to jsilveyra@fi.uba.ar** — we are always happy to share.

## Included in this folder

| File | Version included | Why it can be shared |
| --- | --- | --- |
| `2022, Silveyra, AIP Advances, On the anhysteretic magnetization of soft magnetic materials.pdf` | Published version (Version of Record) | Open access under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/); © 2022 Author(s) |
| `2024, Silveyra, TMAG, MagAnalyst A MATLAB Toolbox for Anhysteretic Magnetization Analysis.pdf` | Author's accepted version | IEEE permits authors to post the accepted version; the file carries IEEE's own notice |
| `2025, Conde Garrido, TMAG, Blind efficient method for optimizing Jiles-Atherton model parameters.pdf` | Author's accepted version | IEEE permits authors to post the accepted version; the file carries IEEE's own notice |

The two IEEE files are the **author's accepted versions**, not the published ones:
they have been peer-reviewed and accepted but not copyedited or typeset by IEEE, so
pagination and minor wording may differ from the Version of Record. Cite the DOI, not
these files.

## Full reference list

**1. Anhysteretic model — original formulation**
J. M. Silveyra and J. M. Conde Garrido, "On the modelling of the anhysteretic
magnetization of homogeneous soft magnetic materials," *Journal of Magnetism and
Magnetic Materials*, vol. 540, p. 168430, 2021.
Accepted 14 August 2021. DOI: <https://doi.org/10.1016/j.jmmm.2021.168430>
*Published version not redistributable (© Elsevier B.V.) — request a copy.*

**2. Anhysteretic model — negative molecular field constants**
J. M. Silveyra and J. M. Conde Garrido, "On the anhysteretic magnetization of soft
magnetic materials," *AIP Advances*, vol. 12, p. 035019, 2022.
Accepted 5 December 2021. DOI: <https://doi.org/10.1063/9.0000328>
*Open access (CC BY 4.0) — included above.*

**3. Anhysteretic model — physical basis and parameter retrieval**
J. M. Silveyra and J. M. Conde Garrido, "A physically based model for soft magnets'
anhysteretic curve," *JOM*, vol. 75, pp. 1810-1823, 2023.
Accepted 13 January 2023. DOI: <https://doi.org/10.1007/s11837-023-05704-x>
*Published version not redistributable (© The Minerals, Metals & Materials Society) —
request a copy.*

**4. MagAnalyst toolbox**
J. M. Silveyra, M. I. González, T. F. González, and J. M. Conde Garrido, "MagAnalyst:
A MATLAB Toolbox for Anhysteretic Magnetization Analysis," *IEEE Transactions on
Magnetics*, vol. 60, no. 9, pp. 1-6, 2024.
DOI: <https://doi.org/10.1109/TMAG.2024.3408681>
*Author's accepted version included above.*

**5. Blind Jiles-Atherton parameter optimization**
J. M. Conde Garrido, J. Ugarte Valdivielso, J. I. Aizpurua, M. Barrenetxea Iñarra, and
J. M. Silveyra, "Blind Efficient Method for Optimizing Jiles-Atherton Model
Parameters," *IEEE Transactions on Magnetics*, vol. 62, no. 1, pp. 1-11, 2026.
DOI: <https://doi.org/10.1109/TMAG.2025.3632479>
*Author's accepted version included above.*

**6. Mass-magnetization (magnetometry) analysis**
J. M. Silveyra, A. Rosales-Rivera, N. A. Salazar-Henao, D. Salazar, and J. M. Conde
Garrido, "Magnetometry analysis via a multicomponent Langevin-Weiss model with
susceptibility-dependent demagnetization," *Journal of Magnetism and Magnetic
Materials*, vol. 647, p. 174000, 2026.
Accepted 4 March 2026. DOI: <https://doi.org/10.1016/j.jmmm.2026.174000>
*Published version not redistributable (© Elsevier B.V.) — request a copy.*

## Which paper documents which feature

- **Anhysteretic fitting tab** — the multicomponent Langevin-Weiss law of mixtures and
  the `Hcr` / `m(Hcr)` search-space transformation: refs 1, 2, 3.
- **Mass magnetization (σ in emu/g = Am²/kg)** — ref 6.
- **Hysteretic fitting tab** — the blind Jiles-Atherton initialization and the
  coercive-point `k` estimate: ref 5.
- **The toolbox itself** — ref 4 (please cite this one if you use MagAnalyst).

See the [User's Guide](../users-guide.md#references) for the complete reference list,
including the algorithmic and numerical-method citations.
