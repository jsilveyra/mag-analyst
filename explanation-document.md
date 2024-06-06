## Contents of the explanation document

1. [Theory for the anhysteretic magnetization model](#theory-for-the-anhysteretic-magnetization-model)
2. [Analysis plots](#analysis-plots)
3. [Strategy for retrieving the model parameters](#strategy-for-retrieving-the-model-parameters)
4. [Calculation of other physical quantities](#calculation-of-other-physical-quantities) 
5. [Computation of the modeled anhysteretic curve](#computation-of-the-modeled-anhysteretic-curve)
6. [Optimization technique](#optimization-technique)
7. [Graphical user interface](#graphical-user-interface)
8. [References](#references)

## Theory for the anhysteretic magnetization model

We use the following law of mixtures to explain the anhysteretic magnetization of soft magnetic materials [[1]](#1): the magnetization field ($M$, which corresponds to the moments per unit volume) is the sum of the magnetization of its components ($M_{i}$), each at the same applied magnetic field ($H$) and temperature ($T$)

$$ M(H,T) = \sum_{i = 1}^{n}{M_{i}(H,T)}.$$

The component magnetizations are described in terms of the mean-field theory introduced by Weiss [[2]](#2)

$$
\begin{gather}
M_{i} = M_{Si}m_{i} \\
m_{i} = \mathcal{L}\left( h_{i} \right) = \coth\left( h_{i} \right) - h_{i}^{- 1}, \\
h_{i} = \frac{H + \alpha_{i}M_{Si}m_{i}}{a_{i}}. \\
\end{gather}
$$

In the equations above, $m_{i}$ and $h_{i}$ denote the reduced magnetization and the reduced magnetic field for the component $i$, respectively. $\mathcal{L}$ is the so-called Langevin function [[3]](#3), which assumes that the magnetic entities are regular pseudo-domains with
fixed and equal effective magnetic moment and size (each magnetic entity consists of a collection of sub-entities with magnetic moments that rotate coherently, resulting in a fixed effective magnetic moment). Each component has three fitting parameters: the saturation magnetization
($M_{Si}$), the molecular field constant ($\alpha_{i}$), and the parameter related to material's temperature and pseudo-domain density ($a_{i}$). The Silveyra-Conde Garrido formulation allows for both positive and negative values of $M_{Si}$ and $\alpha_{i}$. The sign of the saturation magnetization indicates whether the component magnetization aids or opposes the applied magnetic field (positive or negative, respectively) [[1]](#1). The molecular field constant is
linked to crystal electric forces and to demagnetizing effects, rather than solely to exchange forces [[4]](#4). The proposal of negative molecular field constants by Silveyra and Conde Garrido is gaining acceptance among the scientific community [[5]](#5)[[6]](#6).

## Analysis plots

To aid in identifying the number of component magnetizations to model, it is recommended to use the following set of curves: $M$ vs. $H$, $\frac{\partial M}{\partial H}$ vs. $H$, and $\frac{\partial M}{\partial\ln H}$ vs. $H$ [[1]](#1)[[4]](#4). The last curve is particularly helpful in the fitting process and represents the slope of the semi-logarithmic plot of $M$ vs. $H$ (actually, directly proportional to such slope if we use a common logarithmic scale for $H$ in the horizontal axis and compute the derivative of $M$ with respect to the natural logarithm of $H$). MagAnalyst plots these curves for positive $H$ and provides the option to visualize them in either a linear or logarithmic scale for the applied field. The advantage of using semi-logarithmic plots is that they allow for easier observation of details at both low and high applied fields.

## Strategy for retrieving the model parameters

Silveyra and Conde Garrido proposed transforming the search space to retrieve the model parameters for an anhysteretic curve data. Instead of directly fitting $M_{Si}$, $\alpha_{i}$, and $a_{i}$, which can be challenging due to *a priori* unknown bounds and local minima in the optimization problem, they recommend searching for the optimal values of the critical fields ($H_{cr\ i}$) and the corresponding reduced magnetizations ($m_{i}(H_{cr\ i}) $). $H_{cr\ i}$ represents the applied field at which the semi-log derivative of the $i$-component magnetization reaches its peak value. Reasonable bounds and an initial approximation for $H_{cr\ i}$ can be determined by examining the semi-log $M$ derivative plot. MagAnalyst facilitates this step by indicating the input critical fields in the three plots. The reduced magnetizations $m_{i}(H_{cr\ i})$ should fall within the range of $0.4495 < m_{i}(H_{cr\ i}) < 1$ [[4]](#4). A value of $0.5$ is often a suitable starting point for the fitting process [[1]](#1). Higher or lower values will result in narrower or wider peaks in the semi-log $M$ derivative plot, respectively.

Once $H_{cr\ i}$ and $m_{i}(H_{cr\ i})$ are known for each magnetization component, the following equations allow for the calculation of the model parameters.

The parameter related to the pseudo-domain density is given by [[1]](#1)[[4]](#4)

$$\begin{align}
a_{i} = H_{cr\ i}P\left( m_{i}\left( H_{cr\ i} \right) \right)\left( Q\left( m_{i}\left( H_{cr\ i} \right) \right) \pm \sqrt{Q^{2}\left( m_{i}\left( H_{cr\ i} \right) \right) - 1} \right),
\end{align}$$

$$\begin{align}
P(m) = \frac{\mathcal{L}^{'}\left( \mathcal{L}^{- 1}(m) \right)}{m - \mathcal{L}^{- 1}(m)\mathcal{L}^{'}\left( \mathcal{L}^{- 1}(m) \right)},
\end{align}$$

$$\begin{align}
Q(m) = \left( \frac{m}{\mathcal{L}^{'}\left( \mathcal{L}^{- 1}(m) \right)} \right)^{2}\frac{\left( - \mathcal{L}^{''}\left( \mathcal{L}^{- 1}(m) \right) \right)}{2\left( m - \mathcal{L}^{- 1}(m)\mathcal{L}^{'}\left( \mathcal{L}^{- 1}(m) \right) \right)} - 1.
\end{align}$$


Notice the equation for $a_{i}$ has two possible values, being the lowest one generally more common [[4]](#4).

MagAnalyst utilizes Kröger's approximant to evaluate the Langevin inverse ($\mathcal{L}^{- 1}$), as it provides a balance between simplicity and accuracy. This approximant has a maximum relative error below $0.3%$ [[7]](#7). The first and second derivatives of the Langevin function with respect to the reduced magnetic field are, respectively,

$$\begin{align}
\mathcal{L}^{'}(h) = - {csch}^{2}(h) + \frac{1}{h^{2}},
\end{align}$$

$$\begin{align}
\mathcal{L}^{''}(h) = 2\coth(h){csch}^{2}(h) - \frac{2}{h^{3}}.
\end{align}$$

To avoid catastrophic cancellation, MagAnalyst computes the Taylor expansion about the origin instead of directly evaluating the aforementioned functions when $|h| \leq 0.001$

$$\begin{align}
\mathcal{L}^{'}(h) \cong \frac{1}{3} - \frac{h^{2}}{15} + \frac{2}{189}h^{4},
\end{align}$$

$$\begin{align}
\mathcal{L}^{''}(h) \cong - \frac{2}{15}h + \frac{8}{189}h^{3} - \frac{2}{225}h^{5}.
\end{align}$$

For a model with $n$ components, the saturation magnetizations can be determined by ensuring that the fitted curve passes through the tip of the data curve and through $n - 1$ other points, which can be either optimized or fixed. The corresponding applied fields are denoted as $H_{TIP}$ and $H_{X_{i - 1}}$, respectively. Typically, $H_{X_{i - 1}}$ is between $H_{cr\ i}$ and $H_{cr\ i - 1}$ [[1]](#1). These constraints result in a system of $n$ equations and $n$ unknowns

$$\begin{align}
M_{TIP} &= M_{S1}m_{1}\left( H_{TIP} \right) + \ldots + M_{Sn}m_{n}\left( H_{TIP} \right), \\
M_{X_{1}} &= M_{S1}m_{1}\left( H_{X_{1}} \right) + \ldots + M_{Sn}m_{n}\left( H_{X_{1}} \right), \\
&\ldots \\
M_{X_{n - 1}} &= M_{S1}m_{1}\left( H_{X_{n - 1}} \right) + \ldots + M_{Sn}m_{n}\left( H_{X_{n - 1}} \right),
\end{align}$$

which MagAnalyst solves for $M_{Si}$ using the Matlab built-in `linsolve` function. The algorithm employs LU factorization with partial pivoting to solve the linear system [[8]](#8). In the case of $n$ equal components (i.e., with equal both $H_{cr\ i}$ and $m_{i}(H_{cr\ i})$, the saturation magnetization (which is equal for all $n$ components) is given by

$$\begin{align}
M_{Si} = \frac{M_{TIP}}{n m_{i}\left( H_{TIP} \right)}.
\end{align}$$

The reduced magnetizations $m_{1}\left( H_{TIP} \right)$, ..., $m_{n}\left( H_{X_{n - 1}} \right)$ are obtained by solving

$$\begin{align}
\mathcal{L}\left( \frac{H + \alpha_{i}M_{Si}m_{i}(H)}{a_{i}} \right) - m_{i}(H) = 0,
\end{align}$$

for $m_{i}$ at the respective applied fields. The $a_{i}$ parameters required in the above equation are calculated by using their dependence on $H_{cr\ i}$ and $m_{i}(H_{cr\ i})$, and the products $\alpha_{i}M_{Si}$ are given by

$$\begin{align}
\alpha_{i}M_{Si} = \frac{\mathcal{L}^{- 1}\left( m_{i}\left( H_{cr\ i} \right) \right)a_{i} - H_{cr\ i}}{m_{i}\left( H_{cr\ i} \right)}.
\end{align}$$

The solution to obtain the reduced magnetization is determined by finding the point where $\mathcal{L}\left( \frac{H + \alpha_{i}M_{Si}m_{i}(H)}{a_{i}} \right) - m_{i}(H)$ changes sign and falls within the range $0 < m_{i}(H) < 1$. MagAnalyst employs the Matlab built-in `fzero` function to find this solution. The algorithm, developed by Dekker, implements a combination of bisection, secant, and inverse quadratic interpolation methods [[9]](#9). Similar to the derivatives of the Langevin function, when dealing with the Langevin function and $|h| \leq 0.001$, MagAnalyst computes the Taylor expansion about the origin

$$\begin{align}
\mathcal{L}(h) \cong \frac{h}{3} - \frac{1}{45}h^{3} + \frac{2}{945}h^{5}.
\end{align}$$

Finally, the molecular field constant is given by

$$\begin{align}
\alpha_{i} = \alpha_{i}M_{Si}/M_{Si}.
\end{align}$$

## Calculation of other physical quantities

After retrieving the model parameters, $M_{Si}$, $\alpha_{i}$, and $a_{i}$, MagAnalyst calculates several quantities with significant physical implications.

Firstly, it determines the material's saturation polarization, which is crucial for technological applications. This is calculated as

$$\begin{align}
J_{S} = \mu_{0}\sum_{i = 1}^{n}M_{Si},
\end{align}$$

where $\mu_{0}$ is the vacuum magnetic permeability.

Secondly, MagAnalyst computes the dimensionless product $\alpha_{i}\left| M_{Si} \right|/(3a_{i})$, which is utilized in the dimensionless plot of the Langevin-Weiss function (see Fig. 1 in [[4]](#4)).

Thirdly, MagAnalyst calculates the energy density

$$\begin{align}
N_{i}k_{B}T = \mu_{0}\left| M_{Si} \right|a_{i},
\end{align}$$

where $N_{i}$ represents the number of magnetic entities (pseudodomains) of the $i$-component per unit volume, and $k_{B}$ denotes the Boltzmann constant [[4]](#4) (this equation arises from the definition $a_{i} = \frac{k_{B}T}{\mu_{0}\left| m_{d\ i} \right|}$, where $\left| m_{d\ i} \right| = \left| M_{Si} \right|/N_{i}$ is the effective magnetic moment of each magnetic entity).

MagAnalyst also determines the anisotropy mean field as

$$\begin{align}
H_{ki} = 3a_{i} - \alpha_{i}M_{Si}.
\end{align}$$

This relation is derived from assuming a constant magnetic susceptibility up to saturation at $H_{ki}$, i.e., $\chi_{i} = \frac{M_{Si}}{H_{ki}}$, what leads that the magnetic susceptibility is equal to the initial magnetic susceptibility [[10]](#10)

$$\begin{align}
\chi_{in\ i} = \frac{M_{Si}}{\left( 3a_{i} - \alpha_{i}M_{Si} \right)}.
\end{align}$$

When the magnetic susceptibility remains practically constant up to saturation, the anisotropy mean field can be correlated to the induced anisotropy energy constant $K_{ui}$ as

$$\begin{align}
K_{ui} = \frac{1}{2}\mu_{0}M_{Si}H_{ki}.
\end{align}$$

Lastly, MagAnalyst reports the initial relative magnetic permeability of each component

$$\begin{align}
\mu_{r\ in\ i} = 1 + \chi_{in\ i},
\end{align}$$

and of the material

$$\begin{align}
\mu_{r\ in} = 1 + \sum_{i = 1}^{n}\chi_{in\ i},
\end{align}$$

since it is also relevant for technological applications.

## Computation of the modeled anhysteretic curve

Once all the model parameters have been retrieved, the anhysteretic magnetization can be described using the equation of state. For a single-component system, it can be expressed as

$$\begin{align}
M(H) = M_{S}\mathcal{L}\left( \frac{H + \alpha M}{a} \right),
\end{align}$$

and for a multicomponent system, it can be expressed as

$$\begin{align}
M(H) = \sum_{i}^{}{M_{Si}\mathcal{L}\left( \frac{H + \alpha_{i}M_{i}}{a_{i}} \right)}.
\end{align}$$

However, directly calculating $M$ through these equations is not possible since it appears in the argument of the Langevin function. Therefore, we choose to compute the modeled magnetization $M(H)$ in the following manner. MagAnalyst first calculates the corresponding reduced magnetizations for an array of $H$ values ranging from 0 to $H_{TIP}$. Then, it determines $M$ using

$$\begin{align}
M(H) = \sum_{i}^{}{M_{Si}m_{i}(H)}.
\end{align}$$

The modeled susceptibility, $\frac{\partial M}{\partial H}$, is computed as [[1]](#1)

$$\begin{align}
\frac{\partial M}{\partial H}(H) = \sum_{i}^{}{M_{Si}\frac{\mathcal{L}^{'}\left( \mathcal{L}^{- 1}\left( m_{i}(H) \right) \right)/a_{i}}{1 - \alpha_{i}M_{Si}\mathcal{L}^{'}\left( \mathcal{L}^{- 1}\left( m_{i}(H) \right) \right)/a_{i}}},
\end{align}$$

and the modeled semi-log $M$ derivative, $\frac{\partial M}{\partial\ln H}$, is calculated as [[1]](#1)

$$\begin{align}
\frac{\partial M}{\partial\ln H}(H) = H\frac{\partial M}{\partial H}(H).
\end{align}$$

## Optimization technique

By default, MagAnalyst fits the anhysteretic curve by minimizing the mean orthogonal distance error between the data and modeled curve, also known as the diagonal distance error. This is done in a normalized $(X,Y) = \left( \log H,M \right)$ plane [[4]](#4) computing

$$\begin{align}
Diagonal\ error = \frac{1}{N}\sqrt{\sum_{i = 0}^{N}{\mathrm{\Delta}o}_{i}^{2}},
\end{align}$$

$$\begin{align}
\mathrm{\Delta}o_{i} = \mathrm{\Delta}y_{i}\cos\left( {atan}\left( \frac{\mathrm{\Delta}y_{i}}{\mathrm{\Delta}x_{i}} \right) \right),
\end{align}$$

$$\begin{align}
\left\{ \begin{align}
\mathrm{\Delta}x_{i} = \frac{1}{X_{N}}\left| \widehat{X}\left( Y_{i} \right) - X_{i} \right|, \\
\mathrm{\Delta}y_{i} = \frac{1}{Y_{N}}\left| Y\left( \widehat{X}\left( Y_{i} \right) \right) - Y_{i} \right|.
\end{align} \right.\ .
\end{align}$$

The unhatted values represent the data curve, while the hatted values represent the modeled curve. The $N$-th value corresponds to the curve tip, with the arrays sorted in ascending order. This objective function has been found to yield better fittings compared to conventional techniques that minimize the normalized root-mean-squared error of either $M$ at constant $H$ or $H$ at constant $M$ [[1]](#1)[[4]](#4); vertical and horizontal errors, respectively

$$\begin{align}
Vertical\ error = \frac{1}{N}\frac{1}{Y_{N}}\sqrt{\sum_{i = 0}^{N}\left( Y_{i} - \widehat{Y}\left( X_{i} \right) \right)^{2}},
\end{align}$$

$$\begin{align}
Horizontal\ error = \frac{1}{N}\frac{1}{X_{N}}\sqrt{\sum_{i = 0}^{N}\left( X_{i} - \widehat{X}\left( Y_{i} \right) \right)^{2}}.
\end{align}$$

However, the user has the option to optimize either of the traditional objective functions if desired (they are faster to compute). The toolbox utilizes the Matlab built-in `interp1` function [[11]](#11) to evaluate the data and modeled curves at fields that are not present in the set of values but are needed to calculate any of the errors. For interpolation and extrapolation, the default linear method is implemented.

Currently, MagAnalyst utilizes the Matlab function `minimize`, developed by Oldenhuis [[12]](#12), to find the constrained minimum of the objective function starting at the user's initial estimates. This function uses `fminsearch` [[13]](#13) as its engine, which is a Matlab built-in function that employs the Nelder-Mead simplex method, an heuristic search method. `minimize` shares the same syntaxis of `fmincon` [[14]](#14), which offers deterministic algorithms such like the interior-point method, but it has the advantage of being freely distributed (unlike `fmincon`, which requires Matlab's Optimization Toolbox).

## Graphical user interface

We have developed the toolbox with a graphical user interface (GUI) to simplify its usage. MagAnalyst allows users to set up a new project and fit an anhysteretic curve using the Silveyra-Conde Garrido approach with just a few clicks and inputs. Additionally, users have the flexibility to save their projects at any point during the analysis, enabling them to resume it at a later time.

The software automatically converts the input data for analysis into $M\left\lbrack \frac{A}{m} \right\rbrack$ vs $H\left\lbrack \frac{A}{m} \right\rbrack$ for the analysis and fitting process, following the conversion formulae provided in Table I. If other field units are required for the input data, they can be made available upon request.

The magnetization input data can be either an anhysteretic curve or a symmetric hysteresis loop. If a hysteresis loop is provided, the software calculates the anhysteretic curve as the mean of the left and right branches of the $M$ vs $H$ loop (input data can be noisy and begin at any point of the loop). MagAnalyst assumes that the anhysteretic curve exhibits odd symmetry and restricts the analysis to the first quadrant. The tab displays two plots: the raw and the processed input data plots, which can be viewed in linear or logarithmic scale for $H$ and are updated based on user selections. 

To digitize data from figures from the literature, we recommend using WebPlotDigitizer 4.6 [[15]](#15).

The Residual plots, available for $M$ vs. $H$, $\frac{\partial M}{\partial H}$ vs. $H$, and $\frac{\partial M}{\partial\ln H}$ vs. $H$ graphs, display the arrays of vertical errors 

$$\begin{align}
r_{i}\left( X_{i} \right) = Y\left( X_{i} \right) - \widehat{Y}\left( X_{i} \right),
\end{align}$$

where the dependent variable $Y$ is $M$, $\frac{\partial M}{\partial H}$, or $\frac{\partial M}{\partial\ln H}$, respectively, and the independent variable $X$ is $H$.

Tutorial videos are available in [YouTube](https://y-t.be/qvyw), illustrating how to analyze and fit an anhysteretic magnetization curve with either one or two component magnetizations.

### **Table I. Supported input fields and conversion formulae to obtain $M\left\lbrack \frac{A}{m} \right\rbrack$ vs $H\left\lbrack \frac{A}{m} \right\rbrack$ data**
  **Horizontal axis field**
  | **Input field**                                    |**Conversion to $\mathbf{H}\left\lbrack \frac{\mathbf{A}}{\mathbf{m}} \right\rbrack$**| 
  | -------------------------------------------| -------------------------------------------|
  | $$H\left\lbrack \frac{A}{m} \right\rbrack$$        | $$H\left\lbrack \frac{A}{m} \right\rbrack$$|
  | $$H\left\lbrack \frac{kA}{m} \right\rbrack$$       | $$H\left\lbrack \frac{kA}{m} \right\rbrack\frac{10^{3}\left\lbrack \frac{A}{m} \right\rbrack}{1\left\lbrack \frac{kA}{m} \right\rbrack}$$|
  | $$H\lbrack Oe\rbrack$$                             | $$H\lbrack Oe\rbrack\frac{79.5774715459\ \left\lbrack \frac{A}{m} \right\rbrack}{1\lbrack Oe\rbrack}$$|
  | $$H\lbrack kOe\rbrack$$                            | $$H\lbrack kOe\rbrack\frac{79577.4715459\ \left\lbrack \frac{A}{m} \right\rbrack}{1\lbrack kOe\rbrack}$$|
  | $$B_{ext}\lbrack T\rbrack$$                        | $$B_{ext}\lbrack T\rbrack\frac{1}{4\pi 10^{- 7}\left\lbrack \frac{T}{A/m} \right\rbrack}$$|
  | $$B_{ext}\lbrack G\rbrack$$                        | $$B_{ext}\lbrack G\rbrack\frac{1\lbrack T\rbrack}{10^{4}\lbrack G\rbrack}\frac{1}{4\pi 10^{- 7}\left\lbrack \frac{T}{A/m} \right\rbrack}$$|
  | $$B_{ext}\lbrack kG\rbrack$$                       | $$B_{ext}\lbrack kG\rbrack\frac{1\lbrack T\rbrack}{10\lbrack kG\rbrack}\frac{1}{4\pi 10^{- 7}\left\lbrack \frac{T}{A/m} \right\rbrack}$$|

  **Vertical axis field**
  |**Input field**                                     | **Conversion to $\mathbf{M}\left\lbrack \frac{\mathbf{A}}{\mathbf{m}} \right\rbrack$**|
  | -------------------------------------------| -------------------------------------------|
  | $$M\left\lbrack \frac{A}{m} \right\rbrack$$        | $$M\left\lbrack \frac{A}{m} \right\rbrack$$|
  | $$M\left\lbrack \frac{kA}{m} \right\rbrack$$       | $$M\left\lbrack \frac{kA}{m} \right\rbrack\frac{10^{3}\left\lbrack \frac{A}{m} \right\rbrack}{1\left\lbrack \frac{kA}{m} \right\rbrack}$$|
  |$$M\left\lbrack \frac{MA}{m} \right\rbrack$$        | $$M\left\lbrack \frac{MA}{m} \right\rbrack\frac{10^{6}\left\lbrack \frac{A}{m} \right\rbrack}{1\left\lbrack \frac{MA}{m} \right\rbrack}$$|
  |$$M\left\lbrack \frac{emu}{cm^{3}} \right\rbrack$$  | $$M\left\lbrack \frac{emu}{cm^{3}} \right\rbrack\frac{10^{3}\left\lbrack \frac{A}{m} \right\rbrack}{1\left\lbrack \frac{emu}{cm^{3}} \right\rbrack}$$|
  | $$J\lbrack T\rbrack$$                              | $$J\lbrack T\rbrack\frac{1}{4\pi 10^{- 7}\left\lbrack \frac{T}{A/m} \right\rbrack}$$|
  | $$B\lbrack T\rbrack$$                              | $$B\lbrack T\rbrack\frac{1}{4\pi 10^{- 7}\left\lbrack \frac{T}{A/m} \right\rbrack} - H\left\lbrack \frac{A}{m} \right\rbrack$$|
  | $$B\lbrack G\rbrack$$                              | $$B\lbrack G\rbrack\frac{1\lbrack T\rbrack}{10^{4}\lbrack G\rbrack}\frac{1}{4\pi 10^{- 7}\left\lbrack \frac{T}{A/m} \right\rbrack} - H\left\lbrack \frac{A}{m} \right\rbrack$$|
  | $$B\lbrack kG\rbrack$$                             | $$B\lbrack kG\rbrack\frac{1\lbrack T\rbrack}{10\lbrack kG\rbrack}\frac{1}{4\pi 10^{- 7}\left\lbrack \frac{T}{A/m} \right\rbrack} - H\left\lbrack \frac{A}{m} \right\rbrack$$|

Other input fields can be made available upon request.

## References
<a id="1">[1]</a> 
J. M. Silveyra and J. M. Conde Garrido, "On the anhysteretic magnetization of soft magnetic materials," AIP Advances, vol. 12, p. 035019, 2022. https://doi.org/10.1063/9.0000328
<br>
<a id="2">[2]</a>
P. Weiss, "L'hypothèse du champ moléculaire et la propriété ferromagnétique," J. Phys. Theor. Appl., vol. 6, pp. 661-690, 1907. https://doi.org/0.1051/jphystap:019070060066100
<br>
<a id="3">[3]</a>
P. Langevin, "Sur la théorie du magnétisme," J. Phys. Theor. Appl., vol. 4, pp. 678-693, 1905. https://doi.org/10.1051/jphystap:019050040067800
<br>
<a id="4">[4]</a>
J. M. Silveyra and J. M. Conde Garrido, "A physically based model for soft magnets’ anhysteretic curve," JOM, pp. 1-14, 2023. https://doi.org/10.1007/s11837-023-05704-x
<br>
<a id="5">[5]</a>
J. Pytlík, J. Luňáček, and O. Životský, "Differential isotropic model of ferromagnetic hysteresis," Physical Review B, vol. 108, p. 104414, 2023. https://doi.org/10.1103/PhysRevB.108.104414
<br>
<a id="6">[6]</a>
K. Chwastek, P. Gębara, A. Przybył, R. Gozdur, A. P. Baghel, and B. S. Ram, "An Alternative Formulation of the Harrison Model," Applied Sciences, vol. 13, p. 12009, 2023. https://doi.org/10.3390/app132112009
<br>
<a id="7">[7]</a>
M. Kröger, "Simple, admissible, and accurate approximants of the inverse Langevin and Brillouin functions, relevant for strong polymer deformations and flows," Journal of Non-Newtonian Fluid Mechanics, vol. 223, pp. 77-87, 2015. https://doi.org/10.1016/j.jnnfm.2015.05.007
<br>
<a id="8">[8]</a>
Matlab. linsolve - Solve linear system of equations. Available: https://www.mathworks.com/help/matlab/ref/linsolve.html. Access date: 03/11/2023
<br>
<a id="9">[9]</a>
Matlab. fzero - Root of nonlinear function. Available: https://www.mathworks.com/help/matlab/ref/fzero.html. Access date: 03/11/2023
<br>
<a id="10">[10]</a>
J. M. Silveyra and J. M. Conde Garrido, "On the modelling of the anhysteretic magnetization of homogeneous soft magnetic materials," Journal of Magnetism and Magnetic Materials, vol. 540, p. 168430, 2021. https://doi.org/10.1016/j.jmmm.2021.168430
<br>
<a id="11">[11]</a>
Matlab. interp1 - 1-D data interpolation. Available: https://www.mathworks.com/help/matlab/ref/interp1.html. Access date: 03/11/2023
<br>
<a id="12">[12]</a>
Matlab. minimize - Minimize constrained functions with FMINSEARCH or FMINLBFGS, globally or locally. Available: https://www.mathworks.com/matlabcentral/fileexchange/24298-minimize, https://github.com/rodyo/FEX-minimize/releases/tag/v1.8. Access date: 03/11/2023
<br>
<a id="13">[13]</a>
Matlab. fminsearch - Find minimum of unconstrained multivariable function using derivative-free method. Available: https://www.mathworks.com/help/matlab/ref/fminsearch.html. Access date: 03/11/2023
<br>
<a id="14">[14]</a>
Matlab. fmincon - Find minimum of constrained nonlinear multivariable function. Available: https://www.mathworks.com/help/optim/ug/fmincon.html. Access date: 03/11/2023
<br>
<a id="15">[15]</a>
A. Rohatgi. WebPlotDigitizer. Available: https://automeris.io/WebPlotDigitizer. Access date: 19/9/2023
