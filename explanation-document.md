## Contents of the explanation document

1. [Overview](#overview)
2. [Theory for the anhysteretic magnetization model](#theory-for-the-anhysteretic-magnetization-model)
3. [Analysis plots](#analysis-plots)
4. [Strategy for retrieving the model parameters](#strategy-for-retrieving-the-model-parameters)
5. [Calculation of other physical quantities](#calculation-of-other-physical-quantities) 
6. [Computation of the modeled anhysteretic curve](#computation-of-the-modeled-anhysteretic-curve)
7. [Optimization technique](#optimization-technique)
8. [Theory for the hysteretic (Jiles–Atherton) magnetization model](#theory-for-the-hysteretic-jiles-atherton-magnetization-model)
9. [Hysteretic fitting workflow](#hysteretic-fitting-workflow)
10. [Playground: forward hysteretic simulations](#playground-forward-hysteretic-simulations)
11. [Graphical user interface](#graphical-user-interface)
12. [References](#references)

## Overview

MagAnalyst was originally developed to retrieve the parameters of the **anhysteretic** magnetization of soft magnetic materials using the Silveyra-Conde Garrido law of mixtures [[1]](#1) (Sections 2-7 below).

* The **anhysteretic model** decomposes a hysteresis-free magnetization curve into n Langevin-Weiss components, each described by a saturation magnetization M_{Si}, a molecular field constant \alpha_{i}, and a shape parameter a_{i} (equivalently, by the fitting parameters H_{cr\ i}, m_{i}(H_{cr\ i}), and H_{X_{i-1}}). This is the subject of the **Anhysteretic fitting** tab.

The second release extends the toolbox with a full **hysteretic** feature built on the classical, rate-independent Jiles-Atherton (JA) model [[18]](#18) (Sections 8-10), which efficiently fits full hysteresis loops rather than only their anhysteretic backbone. The model is also implemented to forward-simulate hysteretic magnetic paths under different driving field protocols.

* The **hysteretic (JA) model** describes an entire, symmetric hysteresis loop with a single set of five parameters, $M_{S}$, $a$, $\alpha$, $k$, and $c$. This is the subject of the **Hysteretic fitting** tab and of the forward-simulation **Playground** tab.

Both models share the same underlying Langevin-Weiss description of the anhysteretic magnetization: the JA model is, in fact, built around the single-component ($n=1$) case of the anhysteretic equation of state, evaluated at the model's own internal effective field (see [Theory for the hysteretic (Jiles–Atherton) magnetization model](#theory-for-the-hysteretic-jiles-atherton-magnetization-model)). Fitted or user-supplied results from either tab, together with every intermediate curve, residual, and optimization-progress plot, can be exported at once from the unified **Project → Export…** dialog (see [Graphical user interface](#graphical-user-interface)).

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

Silveyra and Conde Garrido proposed transforming the search space to retrieve the model parameters for an anhysteretic curve data. Instead of directly fitting $M_{Si}$, $\alpha_{i}$, and $a_{i}$, which can be challenging due to *a priori* unknown bounds and local minima in the optimization problem, they recommend searching for the optimal values of the critical fields ($H_{cr\ i}$) and the corresponding reduced magnetizations ($m_{i}(H_{cr\ i}) $). $H_{cr\ i}$ represents the applied field at which the semi-log derivative of the $i$-component magnetization reaches its peak value. Reasonable bounds and an initial approximation for $H_{cr\ i}$ can be determined by examining the semi-log $M$ derivative plot. MagAnalyst facilitates this step by indicating the input critical fields in the three plots. The reduced magnetizations $m_{i}(H_{cr\ i})$ should fall within the range of $0.4495 < m_{i}(H_{cr\ i}) < 1$ [[4]](#4). A value of $0.5$ is often a suitable starting point for the fitting process [[1]](#1). Higher or lower values will result in narrower or wider peaks in the semi-log $M$ derivative plot, respectively. A reduced magnetization $m_{i}(H_{cr\ i})=0.521657107787896$ together with the lowest $a_{i}$ selected, gives $\alpha_{i}=0$ (see Fig. 6 in Ref. [[4]](#4)), i.e., non-interacting magnetic entities.

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

By default, MagAnalyst fits the anhysteretic curve by minimizing the mean orthogonal distance error between the data and modeled curve, also known as the diagonal distance error. In **Diagonal (sampled)**, the diagonal error is evaluated at the discrete, measured data points using analytical expressions. This is done either in a linear or a normalized $(X,Y) = \left( \log H,M \right)$ plane [[4]](#4) computing

$$\begin{align}
\mathrm{\Delta}o_{i} = \mathrm{\Delta}y_{i}\cos\left( {atan}\left( \frac{\mathrm{\Delta}y_{i}}{\mathrm{\Delta}x_{i}} \right) \right),
\end{align}$$

$$\begin{align}
\mathrm{\Delta}x_{i} = \frac{1}{X_{N}}\left| \widehat{X}\left( Y_{i} \right) - X_{i} \right|, \quad
\mathrm{\Delta}y_{i} = \frac{1}{Y_{N}}\left| Y\left( \widehat{X}\left( Y_{i} \right) \right) - Y_{i} \right|,
\end{align}$$

$$\begin{align}
Diagonal\ error = \sqrt{\frac{1}{N}\sum_{i = 0}^{N}{\mathrm{\Delta}o}_{i}^{2}},
\end{align}$$

The unhatted values represent the data curve, while the hatted values represent the modeled curve. $X_{N}$ and $Y_{N}$ are the data curve's own maximum $\left| X \right|$ and $\left| Y \right|$ values (equal to the curve-tip coordinates when the arrays are sorted in ascending order, since $H,M \geq 0$ throughout the anhysteretic domain). This objective function has been found to yield better fittings compared to conventional techniques that minimize the normalized root-mean-squared error of either $M$ at constant $H$ or $H$ at constant $M$ [[1]](#1)[[4]](#4); vertical and horizontal errors, respectively

$$\begin{align}
Vertical\ error = \frac{1}{Y_{N}}\sqrt{\frac{1}{N}\sum_{i = 0}^{N}\left( Y_{i} - \widehat{Y}\left( X_{i} \right) \right)^{2}},
\end{align}$$

$$\begin{align}
Horizontal\ error = \frac{1}{X_{N}}\sqrt{\frac{1}{N}\sum_{i = 0}^{N}\left( X_{i} - \widehat{X}\left( Y_{i} \right) \right)^{2}}.
\end{align}$$

In constrast, **Diagonal (continuous)** computes the orthogonal distance assuming a continuous representation of both the data and modeled curves. This variant relies on the external MATLAB library `distance2curve` [[11]](#11) to numerically evaluate the minimum Euclidean distance between continuous parametric curves, again normalized per axis by $X_{N},Y_{N}$ and reduced with the same root-mean-square as above. While computationally more demanding, this formulation provides an idealized and geometrically exact definition of the diagonal error, which is useful for analytical comparison.

However, the user has the option to optimize either of the traditional objective functions if desired; **Vertical** or **Horizontal** (they are faster to compute). The toolbox utilizes the Matlab built-in `interp1` function [[12]](#12) to evaluate the data and modeled curves at fields that are not present in the set of values but are needed to calculate any of the errors. For interpolation and extrapolation, the default linear method is implemented.

> **Note on the error-metric convention (updated 2026-07-13).** The Diagonal/Vertical/Horizontal formulas above previously reduced the summed squared residual by dividing by $N$ *before* taking the square root, i.e. $\left( 1/N \right)\sqrt{\sum_{i}{(\cdot)}^{2}}$, exactly as published in [[1]](#1), [[4]](#4), and again in [[19]](#19). As of 2026-07-13, all four error metrics instead use a true root-mean-square, $\sqrt{\left( 1/N \right)\sum_{i}{(\cdot)}^{2}}$ (taking the mean *before* the square root), as shown above. The two conventions differ only by the constant factor $\sqrt{N}$, since $\left( 1/N \right)\sqrt{\sum{(\cdot)}^{2}} = \sqrt{\left( 1/N \right)\sum{(\cdot)}^{2}}/\sqrt{N}$; for a *fixed* $N$, a positive constant factor cannot change an optimizer's arg min, so no anhysteretic or hysteretic fit's *retrieved parameters* changed as a result of this update — only the *displayed* error magnitude did. The reason for the change is comparability: the root-mean-square convention makes the reported error a dataset-density- and dataset-scale-independent quantity, so error values are meaningfully comparable across curves fit with a different number of points, or of different physical magnitude. The original $\left( 1/N \right)\sqrt{\sum{(\cdot)}^{2}}$ convention is not comparable this way — it shrinks roughly as $1/\sqrt{N}$ purely from resampling the *same* curve more densely, independent of any actual change in fit quality, which was verified numerically before adopting the change.

Currently, MagAnalyst utilizes the Matlab function `minimize`, developed by Oldenhuis [[13]](#13), to find the constrained minimum of the objective function starting at the user's initial estimates. This function uses `fminsearch` [[14]](#14) as its engine, which is a Matlab built-in function that employs the Nelder-Mead simplex method, an heuristic search method. `minimize` shares the same syntaxis of `fmincon` [[15]](#15), which offers deterministic algorithms such like the interior-point method, but it has the advantage of being freely distributed (unlike `fmincon`, which requires Matlab's Optimization Toolbox).

## Theory for the hysteretic (Jiles–Atherton) magnetization model

While the anhysteretic model above describes a hysteresis-free magnetization curve, real ferromagnets exhibit hysteresis: domain-wall pinning at microstructural inhomogeneities makes the magnetization at a given applied field $H$ depend on the field's history. MagAnalyst models this behavior with the classical Jiles-Atherton (JA) model [[18]](#18), a rate-independent, mean-field description of ferromagnetic hysteresis.

As in the anhysteretic model, the starting point is an anhysteretic magnetization, but now evaluated at an internal **effective field** $H_{eff}$ rather than at the applied field $H$ itself,

$$\begin{align}
H_{eff} = H + \alpha M,
\end{align}$$

$$\begin{align}
M_{anh} = M_{S}\mathcal{L}\left( \frac{H_{eff}}{a} \right),
\end{align}$$

where $M_{S}$ is the saturation magnetization, $\mathcal{L}$ is the Langevin function, $a$ plays the same role as in the anhysteretic model, and $\alpha$ is the molecular field (Weiss) constant [[2]](#2), which here couples the internal field to the material's own (hysteretic) magnetization $M$ rather than to a component magnetization. Because $M$ is hysteretic, $M_{anh}$ computed this way is also hysteretic, unlike the genuinely path-independent anhysteretic curve of the previous sections.

Following Jiles and Atherton, the magnetization is split into a fraction that reversibly tracks $M_{anh}$ and an irreversible fraction subject to pinning losses, weighed by a reversibility coefficient $c \in (0,1)$. An energy-balance argument for the irreversible magnetization, after eliminating intermediate variables, yields a single first-order ODE for $M(H)$ [[18]](#18)[[19]](#19)

$$\begin{align}
\frac{dM}{dH} = \frac{num}{den},
\end{align}$$

$$\begin{align}
num = k\delta c\frac{dM_{anh}}{dH_{eff}} + \left( M_{anh} - M \right)\delta_{M},
\end{align}$$

$$\begin{align}
den = k\delta - \alpha\, num,
\end{align}$$

$$\begin{align}
\delta_{M} = \frac{1}{2}\left\lbrack 1 + \operatorname{sign}\left( M_{anh} - M \right)\delta \right\rbrack,
\end{align}$$

where $\delta = \operatorname{sign}(dH) \in \{+1,-1\}$ tracks the field-sweep direction and $k>0$ is the pinning parameter setting the loop's coercivity and width. The switching term $\delta_{M}$ is a patch, introduced to prevent the unphysical negative differential susceptibilities that the unpatched equation would otherwise produce right after a field reversal [[19]](#19). The derivative $\frac{dM_{anh}}{dH_{eff}} = \frac{M_{S}}{a}\mathcal{L}^{'}\left( \frac{H_{eff}}{a} \right)$ reuses the same Langevin derivative (and its small-argument Taylor expansion) already introduced for the anhysteretic model.

The five JA parameters play distinct physical roles: $M_{S}$, $a$, and $\alpha$ mostly set the loop's overall backbone/shape (and are close in value and meaning to the corresponding parameters of a single-component anhysteretic fit), while $k$ and $c$ govern the loop's width, i.e., its hysteretic character. $c$ apportions the magnetization between the anhysteretic (reversible) and the irreversible, pinning-controlled response, and $k$ scales the irreversible loss.

Because the JA ODE has no closed-form solution, MagAnalyst integrates it numerically with the Matlab `ode23tb` solver [[20]](#20), an implicit Runge-Kutta pair (TR-BDF2, combining the trapezoidal rule with a second-order backward differentiation formula) well suited to the locally stiff behavior of $dM/dH$ near saturation and near field turning points [[19]](#19). Every simulated branch is integrated at a fixed sweep direction $\delta$, with default tolerances `RelTol = 1e-7` and `AbsTol = 1e-6`. Since it is $\delta$, and not the sweep rate, that determines which branch is followed, the JA model as implemented here is explicitly **rate-independent**: the magnetization at any point of the field history depends only on the sequence of field values already visited (in particular, on the field's turning points), never on how fast $H(t)$ changes. This property is exploited throughout the Playground subsystem (see below), where only the turning points of a prescribed field waveform ever need to be computed.

## Hysteretic fitting workflow

The **Hysteretic fitting** tab retrieves the five JA parameters ($M_{S}$, $a$, $\alpha$, $k$, $c$) that best reproduce a measured hysteresis loop. As in the anhysteretic tab, the user can hold any subset of parameters fixed and optimize only the rest; in addition, $k$ can either be fitted directly or estimated in closed form (**Constrained by Hc**) at every trial parameter set from the coercive field $H_{C}$ of the measured left branch, following the blind initialization strategy of Conde Garrido et al. [[19]](#19)

$$\begin{align}
k = \frac{M_{S}\mathcal{L}\left( - H_{C}/a \right)}{c\frac{M_{S}}{a}\mathcal{L}^{'}\left( - H_{C}/a \right) - \left( \chi_{C}^{- 1} + \alpha \right)^{- 1}},
\end{align}$$

where $\chi_{C} = dM/dH$ at the coercive point is obtained from the numerically differentiated left branch. Whenever it is used, this removes $k$ from the free-parameter search, since it no longer needs to be optimized independently of $M_{S}$, $a$, $\alpha$, and $c$.

Two settings control how the modeled loop is generated and compared against the data during optimization:

- **Fitting region** — **Entire loop** (the default, and the setting used by `demos/demo_3_hysteretic_ja_fit.m`) compares the model against a full, point-symmetric measured cycle (both branches, built by reflecting the extracted left branch), simulated to a steady state over one or more cycles from a demagnetized start. **Left branch only** instead compares against only the descending branch, from $+ H_{TIP}$ to $- H_{TIP}$, which is sufficient whenever the loop is (or is assumed to be) point-symmetric, and is the region used by Conde Garrido et al.'s blind Jiles-Atherton method [[19]](#19) (whose own model-generation procedure — a discarded $0 \to H_{TIP}$ sweep, then one $H_{TIP} \to -H_{TIP}$ pass — is more closely reproduced within MagAnalyst by choosing **Entire loop** with a demagnetized start and a single repetition than by this tab's own **Left branch only** mode, which instead starts the model directly from the data's own measured tip point).
- **Stop criterion** — for **Entire loop** fitting, each trial parameter set is simulated by repeatedly cycling $+ H_{TIP} \to - H_{TIP} \to + H_{TIP}$, starting either from the data tip or from the demagnetized state (an initial $0 \to H_{TIP}$ sweep is simulated and discarded). **Fixed repetitions** stops after a user-set number of cycles; **Until convergence** instead stops once the returning magnetization at $+ H_{TIP}$ changes, between consecutive cycles, by less than a relative tolerance, capped at a maximum number of cycles.

The objective function reuses the same error-metric hierarchy as the anhysteretic-curve fit (see [Optimization technique](#optimization-technique)), generalized to a linear (never logarithmic) $H$ axis, since the hysteretic branch spans both positive and negative applied fields — unlike the anhysteretic curve, which is confined to $H \geq 0$ and can therefore use a $\log H$ axis. Three options are offered: **Diagonal (H, sampled)** and **Diagonal (H, continuous)** (the analytical/discrete and the `distance2curve`-based [[11]](#11) continuous formulations of the Diagonal error, respectively — both defined in [Optimization technique](#optimization-technique)), or the faster **Vertical** and **Horizontal** errors, evaluated via `interp1` [[12]](#12). All three normalize each axis by the measured branch's own maximum $\left| H \right|$ and $\left| M \right|$ (i.e., $X_{N},Y_{N}$ as defined in [Optimization technique](#optimization-technique)); for a point-symmetric major loop, this coincides almost exactly with the branch's half-range in $H$ and in $M$, the convention used before 2026-07-13, so unifying the two tabs' formulas this way leaves the fit essentially unaffected. **Diagonal (H, sampled)** reproduces, term for term (up to the root-mean-square-vs-$\left(1/N\right)$ reduction convention discussed in [Optimization technique](#optimization-technique)), the "mean orthogonal distance" objective used by Conde Garrido et al.'s blind Jiles-Atherton parameter-estimation method [[19]](#19); **Diagonal (H, continuous)** is a newer, geometrically exact refinement not used in that work.

When the fitting region is the **Entire loop**, the three single-valued-projection metrics — **Diagonal (H, sampled)**, **Vertical**, and **Horizontal** — are evaluated on only the descending (left) branch of both the measured and modeled loop, not the full closed loop. This is necessary, not merely a simplification: those metrics interpolate one curve onto the other's abscissa (they need $\widehat{X}(Y)$ or $\widehat{Y}(X)$ to be single-valued functions), which is undefined on a closed loop where each $H$ maps to two $M$ values (one per branch) and vice versa. Restricting them to the descending branch — which, for the point-symmetric JA major loop, alone determines the fit, and is exactly the branch the blind method [[19]](#19) compares — makes the projection well-defined. The **Diagonal (H, continuous)** metric needs no such restriction: `distance2curve` computes a true point-to-polyline distance that is valid on a closed loop, so it is evaluated on the full loop as-is. (In the **Left branch only** fitting region every metric already receives a single descending branch, so the two behaviours coincide.) As in the anhysteretic tab, MagAnalyst minimizes the objective with the `minimize` routine [[13]](#13) (Nelder-Mead via `fminsearch` [[14]](#14)), subject to user-editable lower/upper bounds on each fitted parameter, and displays a live plot of the error value versus iteration number while the fit runs (see [Graphical user interface](#graphical-user-interface)).

## Playground: forward hysteretic simulations

The **Playground** tab is a forward-simulation sandbox: given a set of JA parameters ($M_{S}$, $a$, $\alpha$, $k$, $c$), typically the output of the Hysteretic fitting tab, it simulates and plots the magnetization response to a prescribed applied-field history. It offers four simulation modes, all built from the same monotonic-branch integrator described in the previous section.

- **Major loop** — a single symmetric hysteresis loop between $\pm H_{TIP}$, started from a demagnetized state, from the data tip, or from a user-defined $\left( H_{start},M_{start} \right)$, and cycled either a fixed number of times or until the returning tip magnetization converges. This reproduces the same simulated loop used internally by the Hysteretic fitting tab and is the standard way to visually check a fitted parameter set or to explore how each JA parameter shapes the loop.
- **Minor loops (nested)** — a sequence of symmetric field excursions $\pm H_{tip\ i}$ of increasing amplitude, run from a demagnetized state and bridged from the smallest to the largest tip, each cycled to a fixed repetition count or to convergence. This simulates the family of nested minor (recoil) loops obtained by driving a sample with sub-saturation field amplitudes.
- **Degaussing** — a decaying, alternating sequence of field reversals (by default, a geometric decay from an initial to a final amplitude over a user-set number of steps) ending in a sweep to $H=0$, reproducing the standard AC-demagnetization ("degaussing") protocol used experimentally to bring a sample to a low-remanence state.
- **Major loop with harmonics** — a major loop driven by a distorted periodic field $H(\theta) = \sum_{j}{A_{j}\sin\left( k_{j}\theta + \varphi_{j} \right)}$ instead of a pure sinusoid ($\theta$ being the field's phase over one period). Because the JA model is rate-independent (see previous section), the simulation only needs the field's turning points within one period, found by densely sampling $H(\theta)$; harmonic content adds extra turning points, which appear as extra, generally asymmetric, minor loops nested inside the major loop. This mode is relevant, e.g., to estimate the hysteretic response under non-sinusoidal (harmonic-rich) excitation, as encountered downstream of power-electronic converters — although, being rate-independent, the JA model still cannot capture frequency-dependent (eddy-current, magnetic viscosity) losses.

Every mode integrates the prescribed field history leg by leg, concatenating consecutive monotonic branches; the resulting curve, its underlying per-branch bookkeeping (e.g., which samples belong to each tip's last loop, or to each period), and the field-history metadata used to generate it can all be exported from the unified Export dialog together with the simulated figure.

## Graphical user interface

We have developed the toolbox with a graphical user interface (GUI) to simplify its usage. The GUI is organized into four tabs — **Input data**, **Anhysteretic fitting**, **Hysteretic fitting**, and **Playground** — plus a **Project** menu for project management and data export. MagAnalyst allows users to set up a new project, fit an anhysteretic curve using the Silveyra-Conde Garrido approach, fit a hysteresis loop using the Jiles-Atherton model, and forward-simulate JA loops in the Playground tab, all with just a few clicks and inputs. Additionally, users have the flexibility to save their projects at any point during the analysis, enabling them to resume it at a later time.

The software automatically converts the input data for analysis into $M\left\lbrack \frac{A}{m} \right\rbrack$ vs $H\left\lbrack \frac{A}{m} \right\rbrack$ for the analysis and fitting process, following the conversion formulae provided in Table I. If other field units are required for the input data, they can be made available upon request.

The magnetization input data can be either an anhysteretic curve or a symmetric hysteresis loop. If a hysteresis loop is provided, the software calculates the anhysteretic curve as the mean of the left and right branches of the $M$ vs $H$ loop (input data can be noisy and begin at any point of the loop). MagAnalyst assumes that the anhysteretic curve exhibits odd symmetry and restricts the analysis to the first quadrant. The Matlab function `interparc`, developed by John D'Errico [[16]](#16), guarantees that the points are evenly spaced in a normalized M vs log(H) plane. The tab displays two plots: the raw and the processed input data plots, which can be viewed in linear or logarithmic scale for $H$ and are updated based on user selections. 

To digitize data from figures from the literature, we recommend using WebPlotDigitizer 4.6 [[17]](#17).

The Residual plots, available for $M$ vs. $H$, $\frac{\partial M}{\partial H}$ vs. $H$, and $\frac{\partial M}{\partial\ln H}$ vs. $H$ graphs, display the arrays of vertical errors 

$$\begin{align}
r_{i}\left( X_{i} \right) = Y\left( X_{i} \right) - \widehat{Y}\left( X_{i} \right),
\end{align}$$

where the dependent variable $Y$ is $M$, $\frac{\partial M}{\partial H}$, or $\frac{\partial M}{\partial\ln H}$, respectively, and the independent variable $X$ is $H$.

Tutorial videos are available in [YouTube](https://y-t.be/qvyw), illustrating how to analyze and fit an anhysteretic magnetization curve with either one or two component magnetizations.

Both the anhysteretic and the hysteretic fits display a live **optimization progress** plot — the value of the selected error metric versus iteration number, on a logarithmic vertical axis — that updates while the corresponding optimizer runs, so convergence (or the lack thereof) can be monitored in real time and the fit can be stopped early if desired.

All artifacts produced by the toolbox — raw and processed input data, the modeled anhysteretic curve with its parameters and residuals, the modeled hysteresis loop with its JA parameters and residuals, every Playground-simulated curve with its metadata, the optimization-progress histories, and every figure — can be exported at once from the unified **Project → Export…** dialog, as CSV/TXT data files and PNG/PDF/SVG figures.

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
J. D'Errico. distance2curve - Distance from a point or points to a general curvilinear n-dimensional arc. Available: https://la.mathworks.com/matlabcentral/fileexchange/34869-distance2curve. Access date: 04/13/2026
<br>
<a id="12">[12]</a>
Matlab. interp1 - 1-D data interpolation. Available: https://www.mathworks.com/help/matlab/ref/interp1.html. Access date: 03/11/2023
<br>
<a id="13">[13]</a>
Matlab. minimize - Minimize constrained functions with FMINSEARCH or FMINLBFGS, globally or locally. Available: https://www.mathworks.com/matlabcentral/fileexchange/24298-minimize, https://github.com/rodyo/FEX-minimize/releases/tag/v1.8. Access date: 03/11/2023
<br>
<a id="14">[14]</a>
Matlab. fminsearch - Find minimum of unconstrained multivariable function using derivative-free method. Available: https://www.mathworks.com/help/matlab/ref/fminsearch.html. Access date: 03/11/2023
<br>
<a id="15">[15]</a>
Matlab. fmincon - Find minimum of constrained nonlinear multivariable function. Available: https://www.mathworks.com/help/optim/ug/fmincon.html. Access date: 03/11/2023
<br>
<a id="16">[16]</a>
Matlab. interparc - Distance based interpolation along a general curve in space. Available: https://www.mathworks.com/help/matlab/ref/fminsearch.html. Access date: 21/07/2024
<br>
<a id="17">[17]</a>
A. Rohatgi. WebPlotDigitizer. Available: https://automeris.io/WebPlotDigitizer. Access date: 19/9/2023
<br>
<a id="18">[18]</a>
D. C. Jiles and D. L. Atherton, "Theory of ferromagnetic hysteresis," Journal of Magnetism and Magnetic Materials, vol. 61, no. 1-2, pp. 48-60, 1986. https://doi.org/10.1016/0304-8853(86)90066-1
<br>
<a id="19">[19]</a>
J. M. Conde Garrido, J. Ugarte Valdivielso, J. I. Aizpurua, M. Barrenetxea Iñarra, and J. M. Silveyra, "Blind Efficient Method for Optimizing Jiles-Atherton Model Parameters," IEEE Transactions on Magnetics, 2025. https://doi.org/10.1109/TMAG.2025.3632479
<br>
<a id="20">[20]</a>
Matlab. ode23tb - Solve stiff differential equations and DAEs — trapezoidal rule + backward differentiation formula. Available: https://www.mathworks.com/help/matlab/ref/ode23tb.html. Access date: 07/04/2026
