## Contents of the explanation manual

1. [Theory for the anhysteretic magnetization model](#theory-for-the-anhysteretic-magnetization-model)
2. [Analysis plots](#analysis-plots)
3. [Strategy for retrieving the model parameters](#strategy-for-retrieving-the-model-parameters)
4. [Calculation of other physical quantities](#calculation-of-other-physical-quantities) 
5. [Computation of the modeled anhysteretic curve](#computation-of-the-modeled-anhysteretic-curve)
6. [Optimization technique](#optimization-technique)
7. [Examples of the graphical user interface](#examples-of-the-graphical-user-interface)

## Explanation

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

which MagAnalyst solves for $M_{Si}$ using the ^^Matlab^^ [Matlab]{.smallcaps} built-in 'linsolve' function. The algorithm employs LU factorization with partial pivoting to solve the linear system [[6]](#6). In the case of $n$ equal components (i.e., with equal both $H_{cr\ i}$ and $m_{i}(H_{cr\ i})$, the saturation magnetization (which is equal for all $n$ components) is given by

$$\begin{align}
M_{Si} = \frac{M_{TIP}}{n{\ m}_{i}\left( H_{TIP} \right)}.
\end{align}$$

The reduced magnetizations $m_{1}\left( H_{TIP} \right)$, ..., $m_{n}\left( H_{X_{n - 1}} \right)$ are obtained by solving

$$\begin{align}
\mathcal{L}\left( \frac{H + \alpha_{i}M_{Si}m_{i}(H)}{a_{i}} \right) - m_{i}(H) = 0,
\end{align}$$

for $m_{i}$ at the respective applied fields. The $a_{i}$ parameters required in the above equation are calculated by using their dependence on $H_{cr\ i}$ and $m_{i}(H_{cr\ i})$, and the products $\alpha_{i}M_{Si}$ are given by

$$\begin{align}
\alpha_{i}M_{Si} = \frac{\mathcal{L}^{- 1}\left( m_{i}\left( H_{cr\ i} \right) \right)a_{i} - H_{cr\ i}}{m_{i}\left( H_{cr\ i} \right)}.
\end{align}$$


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

<br>
<a id="10">[10]</a>

<br>
<a id="11">[11]</a>

<br>
<a id="12">[12]</a>








