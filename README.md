
![Image](https://github.com/matias-gonz/mag-analyst/blob/main/assets/logo_maganalyst.png)
# *<div dir="rtl"> a Matlab toolbox for magnetization analysis </div>*

## Table of contents
1. [Authors](#authors)
2. [Statement of need](#statement-of-need)
3. [Setup and usage instructions](#setup-and-usage-instructions)
4. [Description of the files and directory structure](#description-of-the-files-and-directory-structure)
5. [External libraries](#external-libraries)
6. [Examples](#examples)
7. [Cite as](#cite-as)
8. [Contact us](#contact-us)
9. [License](#license)
10. [Acknowledgement](#acknowledgment)
 
 ## Authors
  - Matías Ignacio González
  - Tomás Francisco González
  - Josefina María Silveyra
  - Juan Manuel Conde Garrido
	
University of Buenos Aires – CONICET, Buenos Aires, Argentina.
   
## Statement of need

The accurate description of magnetization is crucial for designing devices with soft magnetic cores. MagAnalyst is an easy-to-use MATLAB toolbox that models the magnetization of soft magnetic materials. It implements a physically based approach, proposed by Silveyra and Conde Garrido, to describe the ideal anhysteretic curve. The equation of state is simple yet accurate for various material scenarios. The toolbox first plots a set of curves to help the user determine the number of component magnetizations to model and the seeds for the fitting process. It then retrieves the model parameters without the need for programming or optimization skills. As a result, even noisy data from challenging scenarios can be accurately described by a single analytic function, with continuous and differentiable magnetization and susceptibility. We believe that MagAnalyst will be a valuable resource for the magnetic materials community.

## Setup and usage instructions

You need to create a copy on a local directory on your machine to use MagAnalyst. Obtain a copy by downloading and unzipping the latest [release](https://github.com/matias-gonz/mag-analyst/releases) or clone MagAanalyst instead e.g. using: git clone https://github.com/matias-gonz/mag-analyst. You can place the MagAnalyst folder anywhere on your machine.

We recommend using [GitHub Desktop](https://desktop.github.com/), which allows users to easily synchronize with the latest version of MagAnalyst.

After downloading the main folder and placing it in a suitable location, MagAnalyst is ready to use. Simply run the `app.mlapp` file to start using the application.
 
MagAnalyst was implemented and tested with the Matlab 2022b version on Windows 10. Authors cannot guarantee that the code can run on previous versions.

## Description of the files and directory structure

```tree
├── app.mlapp                     # App controller
├── data                          # IO data
├── assets                        # Logos
└── src
    ├── AnhystereticCurve         # Data and modeled anhyesteretic curve
    ├── ErrorCalculator
    ├── MagneticParameters
    ├── Parser                    # Input parser
    ├── Plotter
    ├── ResidueCalculator
    ├── minimize                  # minimize library files
    ├── colorDialog.mlapp
    └── fit.m
```

## External libraries

MagAnalyst currently uses the following third-party libraries:
* [minimize](https://www.mathworks.com/matlabcentral/fileexchange/24298-minimize) to find the constrained minimum of the objective function starting at the user’s initial estimates.

## Examples

These are the examples provided in the \data\sampleData folder with the current release :

* Mn-Zn ferrite: A soft ferrite (Mn<sub>0.51</sub>Zn<sub>0.44</sub>Fe<sub>2.05</sub>O<sub>4</sub>) with very low anisotropy. Similar to the curve analyzed in [JMMM article](https://doi.org/10.1016/j.jmmm.2021.168430) and in [AIP Advances article](https://doi.org/10.1063/9.0000328). The example is illustrated by a video available in [YouTube](https://www.youtube.com/finisilveyra/xxx).
* Finemet - TA: Finemet (r) alloy (Fe<sub>73.5</sub>Si<sub>13.5</sub>B<sub>9</sub>Nb<sub>3</sub>Cu<sub>1</sub>) nanocrystallized under transverse field annealing and measured along the longitudinal direction of the ribbon. Analyzed in [JOM article](https://doi.org/10.1007/s11837-023-05704-x).
* JNEX-900: A non-oriented electrical steel. Analyzed in [AIP Advances article](https://doi.org/10.1063/9.0000328). 
* GOSS - 67 MPa: A grain-oriented silicon steel sheet, cut parallel to the rolling direction, longitudinally compressed up to 67 MPa. Analyzed in [JOM article](https://doi.org/10.1007/s11837-023-05704-x). 

The files provided include:
* data tables of either anhysteretic curves or hysteresis loops in CSV format, where the first and second column correspond to the horizontal and vertical axes field, respectively (the headers specify the fields and units)
* saved projects in TXT format, where the anhysteretic curves have been fitted with either one or two components

## Cite as

If you use MagAnalyst in your work, please cite the following papers on the approach used by MagAnalyst to describe anhysteretic curves:
* J. M. Silveyra and J. M. Conde Garrido, "A physically based model for soft magnets’ anhysteretic curve," JOM, pp. 1-14, 2023. https://doi.org/10.1007/s11837-023-05704-x
* J. M. Silveyra and J. M. Conde Garrido, "On the anhysteretic magnetization of soft magnetic materials," AIP Advances, vol. 12, p. 035019, 2022. https://doi.org/10.1063/9.0000328
* J. M. Silveyra and J. M. Conde Garrido, "On the modelling of the anhysteretic magnetization of homogeneous soft magnetic materials," Journal of Magnetism and Magnetic Materials, vol. 540, p. 168430, 2021. https://doi.org/10.1016/j.jmmm.2021.168430

## Contact us

If you encounter bugs or problems using MagAnalyst, have any suggestions for improving the software, or are interested in receiving email updates about MagAnalyst, please write us to jsilveyra@fi.uba.ar.

## License

MagAnalyst is provided under the [MIT License](https://github.com/matias-gonz/mag-analyst/blob/main/license.txt).

## Acknowledgment

The University of Buenos Aires (UBA) and CONICET provided financial support for this project.
Any opinions, findings, conclusions, or recommendations expressed in this website are those of the author(s) and do not necessarily reflect the views of UBA or CONICET.
