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

```math
M_{i} = M_{Si}m_{i}, \\
m_{i} = \mathcal{L}\left( h_{i} \right) = \coth\left( h_{i} \right) - h_{i}^{- 1}, \\
h_{i} = \frac{H + \alpha_{i}M_{Si}m_{i}}{a_{i}}. \\
```

$$
\begin{aligned}
p & = \hbar k \\
E & = \hbar \omega \\
\end{aligned}
$$

$$ M_{i} = M_{Si}m_{i} $$,
$$ m_{i} = \mathcal{L}\left( h_{i} \right) = \coth\left( h_{i} \right) - h_{i}^{- 1} $$,
<br>	
$$ h_{i} = \frac{H + \alpha_{i}M_{Si}m_{i}}{a_{i}}.$$

In the equations above, $m_{i}$ and $h_{i}$ denote the reduced magnetization and the reduced magnetic field for the component $i$, respectively. $\mathcal{L}$ is the so-called Langevin function [[3]](#3), which assumes that the magnetic entities are regular pseudo-domains with
fixed and equal effective magnetic moment and size (each magnetic entity consists of a collection of sub-entities with magnetic moments that rotate coherently, resulting in a fixed effective magnetic moment). Each component has three fitting parameters: the saturation magnetization
($M_{Si}$), the molecular field constant ($\alpha_{i}$), and the parameter related to material's temperature and pseudo-domain density ($a_{i}$). The Silveyra-Conde Garrido formulation allows for both positive and negative values of $M_{Si}$ and $\alpha_{i}$. The sign of the saturation magnetization indicates whether the component magnetization aids or opposes the applied magnetic field (positive or negative, respectively) [[1]](#1). The molecular field constant is
linked to crystal electric forces and to demagnetizing effects, rather than solely to exchange forces [[4]](#4). The proposal of negative molecular field constants by Silveyra and Conde Garrido is gaining acceptance among the scientific community [[5]](#5)[[6]](#6).

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

<br>
<a id="8">[8]</a>

<br>
<a id="9">[9]</a>

<br>
<a id="10">[10]</a>

<br>
<a id="11">[11]</a>

<br>
<a id="12">[12]</a>








