
![Image](https://github.com/matias-gonz/mag-analyst/blob/main/logo_maganalyst.png)
# *<div dir="rtl"> a Matlab toolbox for magnetization analysis </div>*

## Table of contents
1. [Authors](#authors)
2. [Statement of need](#statement-of-need)
3. [Installation instructions](#installation-instructions)
4. [External libraries](#external-libraries)
5. [Examples](#examples)
6. [Cite as](#cite-as)
7. [Contact us](#contact-us)
8. [License](#license)
9. [Acknowledgement](#acknowledgment)
 
 ## Authors
  - Matías Ignacio González
  - Josefina María Silveyra
  - Juan Manuel Conde Garrido
	
University of Buenos Aires – CONICET, Buenos Aires, Argentina.
   
## Statement of need

The design of devices with soft magnetic cores depends on the simple and accurate description of their magnetization. MagAnalyst is an easy-to-use Matlab toolbox to model the magnetization of soft magnetic materials. It implements the physically based approach recently proposed by Silveyra and Conde Garrido to describe the ideal anhysteretic curve. The equation of state is simple and yet accurate for a variety of materials’ scenarios. MagAnalyst first plots a set of curves to help to identify the number of component magnetizations to model. Then, it retrieves the model parameters without requiring programming or optimization skills. As a result, noisy data of the most challenging scenarios can accurately be described by a single analytic function, with both the magnetization and susceptibility continuous and differentiable. We believe that our toolbox can be a valuable resource to the magnetic materials community.

## Installation instructions

You need to create a copy on a local directory on your machine to use MagAnalyst. Obtain a copy by downloading and unzipping the latest zip file or clone MagAanalyst instead e.g. using: git clone https://github.com/matias-gonz/mag-analyst. You can place the MagAnalyst folder anywhere on your machine.

We recommend using [GitHub Desktop](https://desktop.github.com/), which allows users to easily synchronize with the latest version of MagAnalyst.

After downloading the main folder and placing it in a relevant location, the installation only consists in running the Installation file.
 
MagAnalyst was implemented and tested with the Matlab 2022b version on Windows 10. Authors cannot guarantee that the code can run on previous versions.

## External libraries

MagAnalyst currently uses the following third-party libraries:
* [minimize](https://www.mathworks.com/matlabcentral/fileexchange/24298-minimize) to find the constrained minimum of the objective function starting at the user’s initial estimates.

## Examples

These are the examples provided with the current release:

* Mn-Zn ferrite: A soft ferrite (Mn<sub>0.51</sub>Zn<sub>0.44</sub>Fe<sub>2.05</sub>O<sub>4</sub>) with very low anisotropy. Analyzed in [JMMM article](https://doi.org/10.1016/j.jmmm.2021.168430) and in in [AIP Advances article](https://doi.org/10.1063/9.0000328).
* Finemet - TA: Fe<sub>73.5</sub>Si<sub>13.5</sub>B<sub>9</sub>Nb<sub>3</sub>Cu<sub>1</sub> alloy nanocrystallized under transverse field annealing and measured along the longitudinal direction of the ribbon. Analyzed in [JOM article](https://doi.org/10.1007/s11837-023-05704-x). The example is illustrated by a video available in [YouTube](https://www.youtube.com/channel/xxx).
* JNEX-900: A non-oriented electrical steel. Analyzed in [AIP Advances article](https://doi.org/10.1063/9.0000328). 
* GOSS - 67 MPa: A grain-oriented silicon steel sheet, cut parallel to the rolling direction, longitudinally compressed up to 67 MPa. Analyzed in [JOM article](https://doi.org/10.1007/s11837-023-05704-x). 

## Cite as

If you use MagAnalyst in your work, please cite the publication that introduced the toolbox: 
* XXX

We would also be grateful if you cited the publications of the underlying theory:
* J. M. Silveyra and J. M. Conde Garrido, "A physically based model for soft magnets’ anhysteretic curve," JOM, pp. 1-14, 2023. https://doi.org/10.1007/s11837-023-05704-x
* J. M. Silveyra and J. M. Conde Garrido, "On the modelling of the anhysteretic magnetization of homogeneous soft magnetic materials," Journal of Magnetism and Magnetic Materials, vol. 540, p. 168430, 2021. https://doi.org/10.1016/j.jmmm.2021.168430
* J. M. Silveyra and J. M. Conde Garrido, "On the anhysteretic magnetization of soft magnetic materials," AIP Advances, vol. 12, p. 035019, 2022. https://doi.org/10.1063/9.0000328

## Contact us

If you encounter bugs or problems using MagAnalyst, have any suggestions for improving the software, or are interested in receiving email updates about MagAnalyst, please write us to jsilveyra@fi.uba.ar.

## License

MagAnalyst is provided under the [MIT License](https://github.com/matias-gonz/mag-analyst/blob/main/License.txt).

## Acknowledgment

The University of Buenos Aires (UBA) and CONICET provided financial support for this project.
Any opinions, findings, conclusions, or recommendations expressed in this website are those of the author(s) and do not necessarily reflect the views of UBA or CONICET.
