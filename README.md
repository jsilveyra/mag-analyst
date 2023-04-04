## MagAnalyst: a Matlab toolbox for magnetization analysis

![alt text](https://github.com/matias-gonz/mag-analyst/master/logo_maganalyst.png)

# Table of contents
- [Authors](#Authors)
- [Statement of Need](#StatementofNeed)
- [Installation instructions](#Installationinstructions)
- [External libraries included](#ExtraInst)
- [Data processing examples](#Dataprocessingexamples)
- [Citing MagAnalyst](#Cite)
- [Contact us](#ContactUs)  
- [Code of conduct](#CodeOfConduct)  
- [License](#License)

Tags:
  - Magnetization
  - Soft magnetic materials
  - Modeling
  - Optimization
  - Matlab
 
 # Authors <a name="Authors"></a>
  - Matías Ignacio González (1)
  - Josefina María Silveyra (1,2)
  - Juan Manuel Conde Garrido (1,2)
	
	University of Buenos Aires – CONICET, Buenos Aires, Argentina.
   
date: 4 April 2023

# Statement of Need <a name="StatementofNeed"></a>

The design of devices with soft magnetic cores depends on the simple and accurate description of their magnetization. MagAnalyst is an easy-to-use Matlab toolbox to model the magnetization of soft magnetic materials. It implements the physically based approach recently proposed by Silveyra and Conde Garrido to describe the ideal anhysteretic curve. The equation of state is simple and yet accurate for a variety of materials’ scenarios. MagAnalyst first plots a set of curves to help to identify the number of component magnetizations to model. Then, it retrieves the model parameters without requiring programming or optimization skills. As a result, noisy data of the most challenging scenarios can accurately be described by a single analytic function, with both the magnetization and susceptibility continuous and differentiable. We believe that our toolbox can be a valuable resource to the magnetic materials community. MagAnalyst is open source and freely distributed to the scientific community under the third version of GNU General Public License (GPL v3) on GitHub platform at https://github.com/matias-gonz/mag-analyst/.

# Installation instructions <a name="Installationinstructions"></a>

You need to create a copy on a local directory on your machine to use MagAnalyst. Obtain a copy by downloading and unzipping the latest zip file or clone MagAanalyst instead e.g. using: git clone https://github.com/matias-gonz/mag-analyst. You can place the MagAnalyst folder anywhere on your machine.

We recommend using GitHub Desktop (https://desktop.github.com/), which allows users to easily synchronize with the latest version of MagAnalyst.

After downloading the main folder and placing it in a relevant location, the installation only consists in running the Installation file. It checks if you have a compatible version of Matlab, if the needed toolboxes are installed. The function will also add the Functions folder of MagAnalyst to your current path.
 
MagAnalyst was implemented and tested with the Matlab 2022b version on Windows 10. Authors can not guarantee that the code could be run on previous versions.

### External libraries included <a name="ExtraInst"></a>
* [minimize](https://www.mathworks.com/matlabcentral/fileexchange/24298-minimize) to find the constrained minimum of the objective function starting at the user’s initial estimates.

# Data processing examples <a name="Dataprocessingexamples"></a>

These are the examples available in the current release:

* Fe73.5Si13.5B9Nb3Cu1 alloy nanocrystallized under transverse field annealing and measured along the longitudinal direction of the ribbon.
The materials' details were described in [JOM article] (https://doi.org/10.1007/s11837-023-05704-x)
The example is illustrated by a video available in [YouTube] (https://www.youtube.com/channel/xxx)

# Citing MagAnalyst <a name="Cite"></a>

If you use MagAnalyst in your work, please cite the publication that introduced the toolbox: 
* XXX

We would also be grateful if you cited the publications of the underlying theory:
* J. M. Silveyra and J. M. Conde Garrido, "A physically based model for soft magnets’ anhysteretic curve," JOM, pp. 1-14, 2023. https://doi.org/10.1007/s11837-023-05704-x
* J. M. Silveyra and J. M. Conde Garrido, "On the modelling of the anhysteretic magnetization of homogeneous soft magnetic materials," Journal of Magnetism and Magnetic Materials, vol. 540, p. 168430, 2021. https://doi.org/10.1016/j.jmmm.2021.168430
* J. M. Silveyra and J. M. Conde Garrido, "On the anhysteretic magnetization of soft magnetic materials," AIP Advances, vol. 12, p. 035019, 2022. https://doi.org/10.1063/9.0000328

# Contact us <a name="ContactUs"></a>

If you encounter bugs or problems using MagAnalyst, have any suggestions for improving the software, are interested in receiving email updates about MagAnalyst, please write us to jsilveyra@fi.uba.ar.

# License <a name="License"></a>

MagAnalyst is provided under GNU General Public License v3.0

Permissions of this strong copyleft license are conditioned on making available complete source code of licensed works and modifications, which include larger works using a licensed work, under the same license. Copyright and license notices must be preserved. Contributors provide an express grant of patent rights.
