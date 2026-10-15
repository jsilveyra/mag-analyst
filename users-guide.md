## Contents of the User's Guide

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

This section gives a high-level picture of what MagAnalyst does and how its parts fit together; the remaining sections then document each part in full, low-level detail.

MagAnalyst was originally developed to retrieve the parameters of the **anhysteretic** magnetization of soft magnetic materials using the Silveyra-Conde Garrido law of mixtures [[1]](#1) (Sections 2-7 below).

* The **anhysteretic model** decomposes a hysteresis-free magnetization curve into $n$ Langevin-Weiss components, each described by a saturation magnetization $M_{Si}$, a molecular field constant $\alpha_{i}$, and a shape parameter $a_{i}$ (equivalently, by the fitting parameters $H_{cr\ i}$, $m_{i}(H_{cr\ i})$, and $H_{X_{i-1}}$). This is the subject of the **Anhysteretic fitting** tab.

The second release extended the toolbox with a full **hysteretic** feature built on the classical, rate-independent Jiles-Atherton (JA) model [[18]](#18) (Sections 8-10), which efficiently fits full hysteresis loops rather than only their anhysteretic backbone. The model is also implemented to forward-simulate hysteretic magnetic paths under different driving field protocols.

* The **hysteretic (JA) model** describes an entire, symmetric hysteresis loop with a single set of five parameters, $M_{S}$, $a$, $\alpha$, $k$, and $c$. This is the subject of the **Hysteretic fitting** tab and of the forward-simulation **Playground** tab.

Both models share the same underlying Langevin-Weiss description of the anhysteretic magnetization: the JA model is, in fact, built around the single-component ($n=1$) case of the anhysteretic equation of state, evaluated at the model's own internal effective field (see [Theory for the hysteretic (Jiles–Atherton) magnetization model](#theory-for-the-hysteretic-jiles-atherton-magnetization-model)).

**The typical workflow** follows the order of the GUI tabs:

1. **Input data** — import a measured curve (anhysteretic curve or symmetric hysteresis loop) from a two-column CSV file, choosing among the supported field/unit combinations (see Table I); the data are converted to $M$ [A/m] vs. $H$ [A/m] (or kept as mass magnetization $\sigma$ [Am²/kg] when that unit is selected) and resampled.
2. **Anhysteretic fitting** — retrieve the multicomponent Langevin-Weiss parameters. Automatic seed estimation, transformed fitting parameters, and a choice of error metrics make this step essentially "blind": no prior knowledge of the parameter search space is required.
3. **Hysteretic fitting** — retrieve the five JA parameters from a measured hysteresis loop with the blind method of Conde Garrido et al. [[19]](#19): seeds from the anhysteretic fit, a fit with $k$ tied to the measured coercive point, a refinement of all five parameters, and a polish to the reported significant digits.
4. **Playground** — forward-simulate the JA model under four driving-field protocols (major loop, nested minor loops, AC degaussing, and a distorted harmonic drive).
5. **Project menu** — save/reopen the whole session, and export every artifact — raw/processed data, fitted curves and parameters, residuals, Playground simulations, optimization-progress histories, and figures — at once from the unified **Project → Export…** dialog (see [Graphical user interface](#graphical-user-interface)).

Every fitting and simulation feature is also usable programmatically, without the GUI: the `demos/` folder contains seven standalone scripts, one per workflow (anhysteretic fits with one and two components, the JA fit, and the four Playground modes).

**Requirements.** MagAnalyst 2.0 runs on MATLAB R2022b or later and needs only base MATLAB, with no additional toolboxes. It was developed with R2025b and tested on R2022b and R2025b; older releases are not supported. On R2022b the app is fully functional; the only visible difference is that numeric fields that are blank on newer releases show `NaN`. See the README for details, including the separate constraint on *editing* `app.mlapp` in App Designer.

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

To aid in identifying the number of component magnetizations to model, it is recommended to use the following set of curves: $M$ vs. $H$, $\frac{\partial M}{\partial H}$ vs. $H$, and $\frac{\partial M}{\partial\ln H}$ vs. $H$ [[1]](#1)[[4]](#4). The last curve is particularly helpful in the fitting process and represents the slope of the semi-logarithmic plot of $M$ vs. $H$ (actually, directly proportional to such slope if we use a common logarithmic scale for $H$ in the horizontal axis and compute the derivative of $M$ with respect to the natural logarithm of $H$). MagAnalyst plots these curves for positive $H$ and provides the option to visualize them in either a linear or logarithmic scale for the applied field (independently for each axis, so linear-linear, semi-log, and log-log combinations are all available). The advantage of using semi-logarithmic plots is that they allow for easier observation of details at both low and high applied fields.

Since $M_{Si}$ may be negative (see [Theory for the anhysteretic magnetization model](#theory-for-the-anhysteretic-magnetization-model)), a component with $M_{Si}<0$ has a component curve that is negative everywhere; on a logarithmic vertical axis, such a curve is entirely off-scale and is not drawn (only the total curve, and any other component with $M_{Si}>0$, remain visible). When this happens, MagAnalyst notes it in the Messages log instead of only leaving the curve blank.

## Strategy for retrieving the model parameters

Silveyra and Conde Garrido proposed transforming the search space to retrieve the model parameters for an anhysteretic curve data. Instead of directly fitting $M_{Si}$, $\alpha_{i}$, and $a_{i}$, which can be challenging due to *a priori* unknown bounds and local minima in the optimization problem, they recommend searching for the optimal values of the critical fields ($H_{cr\ i}$) and the corresponding reduced magnetizations ($m_{i}(H_{cr\ i}) $). $H_{cr\ i}$ represents the applied field at which the semi-log derivative of the $i$-component magnetization reaches its peak value. Reasonable bounds and an initial approximation for $H_{cr\ i}$ can be determined by examining the semi-log $M$ derivative plot. MagAnalyst facilitates this step by indicating the input critical fields in the three plots. The reduced magnetizations $m_{i}(H_{cr\ i})$ should fall within the range of $0.4495 < m_{i}(H_{cr\ i}) < 1$ [[4]](#4). A value of $0.5$ is often a suitable starting point for the fitting process [[1]](#1). Higher or lower values will result in narrower or wider peaks in the semi-log $M$ derivative plot, respectively. A reduced magnetization $m_{i}(H_{cr\ i})=0.521657107787896$ together with the lowest $a_{i}$ selected, gives $\alpha_{i}=0$ (see Fig. 6 in Ref. [[4]](#4)), i.e., non-interacting magnetic entities.

### Automatic seed estimation

Rather than requiring the user to read $H_{cr\ i}$ and $m_{i}(H_{cr\ i})$ off the plot by eye, MagAnalyst estimates a full set of starting values automatically whenever the number of components is set or a new dataset is imported. This automatic estimate is only a *seed* for the optimizer described in [Optimization technique](#optimization-technique), not the fit itself — it only needs to land in the right basin, not at the exact optimum.

The estimation works on the semi-log derivative $H\ \partial M/\partial\ln H$ (the "halo") as a function of $\ln H$, in two stages:

1. **Peak-and-subtract.** The tallest peak of the (smoothed) halo is located; its basin — the range of $H$ over which it dominates the curve, bounded by the nearest flanking minima — gives a peak area and a full width at half maximum. Matching this shape (width and area-to-height ratio, both independent of the component's amplitude) against a precomputed library of single-component halo shapes for $m_{i}(H_{cr\ i}) \in \left[0.45,\ 0.95\right]$ yields $m_{i}(H_{cr\ i})$ for that component; $H_{cr\ i}$ is simply the peak's field. A single-component model curve with that shape is then scaled to match the peak's area and subtracted from the halo, and the process repeats on the residual to find the next component, and so on.
2. **Joint refinement.** Peak-and-subtract only resolves components whose $H_{cr\ i}$ are far enough apart, on the $\ln H$ axis, to show up as separate local maxima of the halo. When two (or more) components are closer together than their own widths, the weaker one shows up only as a *shoulder* on the dominant peak rather than as a separate maximum, and step 1 alone cannot separate them — it either finds only one component's worth of peaks, or the peak-and-subtract step degenerates (repeatedly finding the same peak, since subtracting a single-component template scaled to fit the whole merged basin removes little of it). MagAnalyst detects this — too few components found, or components found on top of each other — and, in that case, restarts from an even-area split of the halo curve in $\ln H$ (as many splits as requested components) and jointly fits all of them at once: a bounded least-squares fit, by Nelder-Mead, of $n$ single-component halo templates, letting all $H_{cr\ i}$, $m_{i}(H_{cr\ i})$, and $M_{Si}$ vary together against the measured halo curve. Unlike the sequential step, this deconvolution can trade contributions between components, which is what actually separates two overlapping peaks. It is also applied, starting from their positions, to well-separated components found in step 1. **This joint step generalizes to any number of components** ($n \geq 2$), not just two: it fits all $n$ templates simultaneously regardless of how many of them overlap.

Because step 2 solves a real (if small and low-precision) nonlinear optimization, seed estimation for two or more components can take several seconds; MagAnalyst shows a progress dialog while it runs.

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

The **Select aᵢ** column of the Anhysteretic tab's parameter table chooses the root for each component. **low** (the default) and **high** fix it. The two **auto** options, **auto (low)** and **auto (high)**, start on the named root and let the fit switch it. The two roots meet where $Q = 1$, at $m \approx 0.4496$, the default lower bound of $m_{i}(H_{cr\ i})$. When a fit ends with an auto component's $m_{i}(H_{cr\ i})$ on that bound, the optimum may lie on the other root. MagAnalyst then refits once from the current result, with every such auto component on the other root. It keeps the new root only if the fit error decreases. In that case the column changes to, e.g., *auto (high)*. Either way, the Messages panel reports the outcome for each component. A fixed **low** or **high** component never switches. The auto options are not the default because a better anhysteretic fit is not necessarily a better seed: on the MagAnalyst 2.0 benchmark loops, the switch lowered every anhysteretic fit error, but one of the Jiles–Atherton fits seeded from it ended in a worse minimum. When its $m_{i}(H_{cr\ i})$ ends on the bound, the Messages panel instead suggests trying the other root.

MagAnalyst utilizes Kröger's approximant to evaluate the Langevin inverse ($\mathcal{L}^{- 1}$), as it provides a balance between simplicity and accuracy. This approximant has a maximum relative error below $0.3\%$ [[7]](#7). The first and second derivatives of the Langevin function with respect to the reduced magnetic field are, respectively,

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

which MagAnalyst solves for $M_{Si}$ using the Matlab built-in `linsolve` function. The algorithm employs LU factorization with partial pivoting to solve the linear system [[8]](#8). In the case of $n$ equal components (i.e., with both $H_{cr\ i}$ and $m_{i}(H_{cr\ i})$ equal for every component), the saturation magnetization (which is then also equal for all $n$ components) is given by

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

### Linear term and held physical parameters

Some curves keep rising linearly at the highest fields, for instance because of the high-field susceptibility (paraprocess) of a ferromagnet close to its Curie temperature, or a paramagnetic phase. The **Linear term** box adds a component 0 with $M_{0} = \chi_{0}H$ ($\sigma_{0} = \chi_{m0}H$ for mass magnetization). $\chi_{0}$ is one more fitting parameter. It is the first row of the mathematical-parameters table in both modes, with its own value, bounds and **Fit** flag. Its seed is the slope of the curve over the top 20 % of the field range, an upper estimate, since the approach to saturation still adds slope there. The default bounds are $[0, \infty)$; set a negative lower bound for a diamagnetic term. With *Constrained by n data points* checked, the tip and cross-over constraints act on $M - \chi_{0}H$. With it unchecked, the mathematical-parameters table stays enabled for the $\chi_{0}$ row only. The calculated quantities gain a first row, *0 (linear)*, and $\chi_{in}$ includes $\chi_{0}$. On the plots the linear term is drawn as a dashed grey line with the components.

When *Constrained by n data points* is unchecked, the **Fit** columns of the physical-parameters table select which of $M_{Si}$, $\alpha_{i}$ and $a_{i}$ are fitted. An unticked parameter is held at its current value and excluded from the solver.

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

The unhatted values represent the data curve, while the hatted values represent the modeled curve. $Y_{N}$ is the data curve's own maximum $\left| Y \right|$ (the tip magnetization, since $M \geq 0$ throughout the anhysteretic domain). In the linear plane, $X = H$ and $X_{N}$ is likewise the tip field. In the semilogarithmic plane the field axis is instead $X = \ln\left( H/H_{\min} \right)$ with $X_{N} = \ln\left( H_{\mathrm{tip}}/H_{\min} \right)$, where $H_{\min}$ is the smallest positive field of the data curve, so that the data span exactly $[0, 1]$ along both normalized axes and field and magnetization misfits carry equal weight regardless of the numerical value of $H$ (before version 2.0.0 the log axis was the bare $\ln H$ in A/m scaled by its own maximum, which weighted the field axis by an amount that depended on where $H = 1$ A/m fell within the data). This objective function has been found to yield better fittings compared to conventional techniques that minimize the normalized root-mean-squared error of either $M$ at constant $H$ or $H$ at constant $M$ [[1]](#1)[[4]](#4); vertical and horizontal errors, respectively

$$\begin{align}
Vertical\ error = \frac{1}{Y_{N}}\sqrt{\frac{1}{N}\sum_{i = 0}^{N}\left( Y_{i} - \widehat{Y}\left( X_{i} \right) \right)^{2}},
\end{align}$$

$$\begin{align}
Horizontal\ error = \frac{1}{X_{N}}\sqrt{\frac{1}{N}\sum_{i = 0}^{N}\left( X_{i} - \widehat{X}\left( Y_{i} \right) \right)^{2}}.
\end{align}$$

In contrast, **Diagonal (continuous)** computes the orthogonal distance assuming a continuous representation of the modeled curve: the polyline through its consecutive computed points. For each data point, the distance to every segment of that polyline is computed (its perpendicular foot, or the nearer end point when the foot falls outside the segment) and the smallest is kept, again normalized per axis by $X_{N},Y_{N}$ and reduced with the same root-mean-square as above. Because the minimization runs over every segment of the polyline, the result is the exact point-to-polyline distance, and no common horizontal or vertical coordinate has to be chosen on the two curves: it works equally on a single branch and on a closed loop, where each $H$ has two $M$ values. The computation is done by `src/Common/point_to_polyline_distance.m`, which gives the same result as the MATLAB library `distance2curve` [[11]](#11) (to rounding) but processes the data points in blocks, several times faster on the long measured loops of the hysteretic fit. While computationally more demanding, this formulation provides an idealized and geometrically exact definition of the diagonal error, which is useful for analytical comparison.

However, the user has the option to optimize either of the traditional objective functions if desired; **Vertical** or **Horizontal** (they are faster to compute). Both are evaluated in the normalized linear plane ($X = H$, $X_{N} = H_{\mathrm{tip}}$); the Diagonal metrics come in both planes, **(H, …)** and **(logH, …)**. (Before 2026-09-25 they were evaluated in the semilogarithmic plane.) The toolbox utilizes the Matlab built-in `interp1` function [[12]](#12) to evaluate the data and modeled curves at fields that are not present in the set of values but are needed to calculate any of the errors. For interpolation and extrapolation, the default linear method is implemented.

> **Note on the error-metric convention.** The Diagonal/Vertical/Horizontal formulas above previously reduced the summed squared residual by dividing by $N$ *before* taking the square root, i.e. $\left( 1/N \right)\sqrt{\sum_{i}{(\cdot)}^{2}}$, exactly as published in [[1]](#1), [[4]](#4), and again in [[19]](#19). Since MagAnalyst 2.0, all four error metrics instead use a true root-mean-square, $\sqrt{\left( 1/N \right)\sum_{i}{(\cdot)}^{2}}$ (taking the mean *before* the square root), as shown above. The two conventions differ only by the constant factor $\sqrt{N}$, since $\left( 1/N \right)\sqrt{\sum{(\cdot)}^{2}} = \sqrt{\left( 1/N \right)\sum{(\cdot)}^{2}}/\sqrt{N}$; for a *fixed* $N$, a positive constant factor cannot change an optimizer's arg min, so no anhysteretic or hysteretic fit's *retrieved parameters* changed as a result of this update — only the *displayed* error magnitude did. The reason for the change is comparability: the root-mean-square convention makes the reported error a dataset-density- and dataset-scale-independent quantity, so error values are meaningfully comparable across curves fit with a different number of points, or of different physical magnitude. The original $\left( 1/N \right)\sqrt{\sum{(\cdot)}^{2}}$ convention is not comparable this way — it shrinks roughly as $1/\sqrt{N}$ purely from resampling the *same* curve more densely, independent of any actual change in fit quality.

**Solvers.** Both fitting tabs have a **Solver** dropdown with three derivative-free methods; **DFO-LS** is the default in both. All three minimize the same error, $F$ (the value of the selected metric, shown in the **Error** field), within the same bounds, and all work on scaled variables: each parameter is divided by the magnitude of its initial estimate (by 1 if that estimate is zero), so that parameters of very different magnitude, such as $M_{S}\sim10^{5}$–$10^{6}$ A/m and $\alpha\sim10^{-4}$, weigh equally in the steps and in the stopping tests [[24]](#24). The bounds are scaled in the same way. Because every **Fit** starts from the current values, fitting again (for instance after **Stop fit**) also rescales by the latest result. Everything shown, saved, or exported is in physical units.

- **DFO-LS** — a trust-region method for least-squares problems, after Cartis et al. [[31]](#31) (`src/Common/dfols_mat.m`). Every error metric is the root mean square of one residual per data point. DFO-LS builds a *linear* model of each residual from $p+1$ evaluated points, $p$ being the number of free parameters, and takes Gauss–Newton steps that minimize $\lVert r + J s \rVert^{2}$ within the trust region and the bounds. The residuals are signed, so that each one crosses zero smoothly when the model curve crosses its data point: the distance to the model curve, signed by the side of the curve on which the point lies (continuous Diagonal; for a loop, positive inside), the altitude of the sampled Diagonal, signed by the horizontal offset, and the plain vertical or horizontal offsets. Their root mean square is exactly $F$. MagAnalyst implements Algorithm 1 of [[31]](#31) with that paper's settings for *noisy* objectives (slow reductions of the trust region), because the hysteretic error comes from an adaptive numerical integration whose small, irregular errors make the settings for smooth problems stop too early.
- **BOBYQA** — a trust-region method that interpolates the error with a quadratic model at a set of evaluated points and minimizes that model within the trust region and the bounds [[22]](#22). MagAnalyst's plain-MATLAB implementation (`src/lib/bobyqa_mat/`) reuses PRIMA's [[23]](#23) model-update routines and solves the trust-region and geometry-improving subproblems exactly (active-set method with Moré–Sorensen steps), where Powell's code takes approximate steps. The number of interpolation points is a full quadratic model, $(p+1)(p+2)/2$, for $p \leq 6$, and $2p+1$ for larger problems (Anhysteretic fits with three or more components); this threshold is an empirical rule found on MagAnalyst's own fits, documented in `src/lib/bobyqa_mat/README.md`. BOBYQA is given the square of the error, $F^{2}$, which has the same minimizers: $F$ is not differentiable at a minimum where all residuals vanish (as for synthetic data) and is sharply curved near one where they are small, and a quadratic model of it then stops early.
- **Nelder-Mead** — the simplex method through the function `minimize` by Oldenhuis [[13]](#13), which calls MATLAB's `fminsearch` [[14]](#14) and has the syntax of `fmincon` [[15]](#15) without requiring the Optimization Toolbox. It compares error values only, and it imposes the bounds by transforming the variables ($x = \ell + z^{2}$ for a lower bound $\ell$, $x = \ell + (u - \ell)(\sin z + 1)/2$ for a range $[\ell, u]$), so that every trial point satisfies them. It was MagAnalyst's only solver before version 2.0.

The initial trust-region radius of DFO-LS and BOBYQA is 0.1 (10 % of each initial estimate), and the search ends when the radius reaches $10^{-4}$, about the parameter resolution that the ODE tolerances allow, or after $400(p+1)$ evaluations. Nelder-Mead stops at `TolX` = `TolFun` = $10^{-5}$ (on the scaled variables), or after 2000 iterations or $10^{4}$ evaluations.

**Why three solvers.** DFO-LS is the default because, on the Jiles–Atherton benchmark loops of the MagAnalyst 2.0 paper, it reached errors equal to or lower than BOBYQA's, typically in less time. No solver is best on every problem, so the other two remain available, and they provide an independent check: methods of different families that agree on the parameters indicate a well-determined minimum, whereas similar errors at clearly different parameters, as for the Nd-Fe-B–silicone composite of the paper, reveal directions that the measured curve does not constrain, a property of the data rather than of the solvers. All three are deterministic: given the same initial values, bounds, and data, they return the same result every time, and none samples random points or keeps a population of candidates.

**Significant digits and the lattice polish.** Next to the **Solver** dropdown, both fitting tabs have a **Signif. digits** dropdown (3, 4, 5, 6, or *Full precision*; default 3) and a **Polish** button. A fit that converges in double precision may not be reproduced from the few digits a table can print: rounding the fitted parameters to three or four digits can raise the error by several percent and, on sensitive loops, can even leave parameters that cannot be integrated. **Fit** therefore always returns the solver's full-precision result, and **Polish** is a separate step: set **Signif. digits** to the number of digits you will report and press **Polish**. The parameters are rounded to that many significant digits and then improved by a direct search on the lattice of such numbers: one unit of the last digit up or down in each parameter, then in every pair of parameters, and finally in pairs with steps of two units, which follow a curved valley between lattice points; at each step the best neighbour is taken, until a complete sweep finds nothing better. The reported parameters are then exactly the printed ones, the error shown is the error at those values, and no neighbouring set of printed values fits better. A complete sweep visits 170 lattice points for five parameters, so a polish takes seconds to a minute; it stops after 300 trial points if the start is far from a lattice optimum (the Messages panel then says that the result is not certified). Points already evaluated are not integrated again, and a point with an error of exactly zero, as on synthetic data generated with the same settings, is certified at once. On the Jiles 1992 synthetic loop, the three solvers recover the ground-truth parameters exactly only through this polish: their full-precision results end within about 0.1 % of the truth, on a flat valley of the error.

This is the round-then-local-search of finite-wordlength filter design [[29]](#29) and the final poll at minimal mesh size of mesh adaptive direct search over *granular variables* (variables with a set number of decimals) [[30]](#30). The polish acts on the physical parameter values, whatever the solver. In the Anhysteretic tab it acts on the variables of the active mode: $H_{cr\ i}$, $m_{i}(H_{cr\ i})$, and $H_{X_{i}}$ when *Constrained by n data points* is checked (the model is forced through $n$ measured points, $n$ being the number of components: the tip and the cross-over points $H_{X_{i}}$), and $M_{Si}$, $\alpha_{i}$, and $a_{i}$ when it is unchecked; parameters excluded from the fit are neither rounded nor moved. In the Hysteretic tab it acts on the free JA parameters; when $k$ is *Constrained by Hc* it is derived, not fitted, so it is polished only in the unconstrained fit. After every refinement fit, the Messages panel reminds you to choose **Signif. digits** and press **Polish**. The setting is recorded in the exported metadata.

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

Because the JA ODE has no closed-form solution, MagAnalyst integrates it numerically with the Matlab `ode23tb` solver [[20]](#20), an implicit Runge-Kutta pair (TR-BDF2, combining the trapezoidal rule with a second-order backward differentiation formula) well suited to the locally stiff behavior of $dM/dH$ near saturation and near field turning points [[19]](#19). Every simulated branch is integrated at a fixed sweep direction $\delta$, with tolerances `RelTol = 1e-7` and `AbsTol = 1e-6`; the derivative of $dM/dH$ with respect to $M$, which the implicit solver needs at every Newton iteration, is supplied in closed form (`src/Common/ja_ode_jacobian.m`) rather than estimated by finite differences. Parameters identified this way should be used with equally tight tolerances in other software. Since it is $\delta$, and not the sweep rate, that determines which branch is followed, the JA model as implemented here is explicitly **rate-independent**: the magnetization at any point of the field history depends only on the sequence of field values already visited (in particular, on the field's turning points), never on how fast $H(t)$ changes. This property is exploited throughout the Playground subsystem (see below), where only the turning points of a prescribed field waveform ever need to be computed.

## Hysteretic fitting workflow

The **Hysteretic fitting** tab retrieves the five JA parameters ($M_{S}$, $a$, $\alpha$, $k$, $c$) of a measured major loop without user-supplied initial values or search bounds, following the blind method of Conde Garrido et al. [[19]](#19), in four steps:

1. **Retrieve seeds.** $M_{S}$, $a$, and $\alpha$ are taken from the fit of the Anhysteretic tab, which should have one component, since the anhysteretic equation of the JA model is itself a single-component model (with more components, the first one is used); $c = 1/3$; and $k$ is obtained from the closed-form expression below.
2. **Fit** with **Constrained by Hc** checked: $M_{S}$, $a$, $\alpha$, and $c$ are optimized, and $k$ is recomputed at every evaluation as the value for which the JA equation reproduces the measured differential susceptibility $\chi_{C}$ at the measured coercive point $\left( - H_{C},0 \right)$ [[19]](#19),

$$\begin{align}
k = \frac{M_{S}\mathcal{L}\left( - H_{C}/a \right)}{c\frac{M_{S}}{a}\mathcal{L}^{'}\left( - H_{C}/a \right) - \left( \chi_{C}^{- 1} + \alpha \right)^{- 1}},
\end{align}$$

   where $\chi_{C}$ is obtained from the numerically differentiated descending branch. This removes $k$ from the search.

3. **Fit** again with **Constrained by Hc** unchecked, as the Messages panel suggests: all five parameters are optimized, starting from the previous result.
4. **Polish** to the number of significant digits to be reported (see [Optimization technique](#optimization-technique)).

Any parameter can be held fixed (**Fit** column) and its bounds edited. The default bounds are only the physically motivated ones: $M_{S} \geq M_{TIP}$, $a \geq 0$, $k \geq 0$, and $0 \leq c \leq 1$, with $\alpha$ unbounded, since negative values of $\alpha$ are physically meaningful [[10]](#10).

**Data.** The fit compares the model with every measured point of the loop, without resampling, after conversion to A/m (or in mass-magnetization units, see [Graphical user interface](#graphical-user-interface)). The measured descending and ascending branches are both used, so an asymmetric loop is fitted as measured. The **N° of points** of the Input data tab applies only to the anhysteretic curve.

**Simulated loop.** The **Fitting conditions** panel sets how the model loop is generated at every evaluation:

- **Starting point** — *Demagnetized* (default): the integration starts at $(H,M) = (0,0)$ and rises to $H_{TIP}$; *Tip point*: it starts at the measured tip.
- **Fitting region** — *Entire loop* (default): the field is then cycled $+ H_{TIP} \to - H_{TIP} \to + H_{TIP}$, and the last cycle is compared with the whole measured loop. *Left branch only*: only the descending branch $+ H_{TIP} \to - H_{TIP}$ is simulated and compared with the measured descending branch; this is faster but assumes an antisymmetric loop, and it is the protocol of [[19]](#19) when combined with the demagnetized start.
- **Stop criterion** (Entire loop) — *Until convergence* (default) cycles until the magnetization at $+ H_{TIP}$ changes by less than the **Relative tolerance** ($10^{-3}$ by default) between consecutive cycles, or until **Maximum repetitions** (5 by default, raised from 3 on 2026-09-26 — the tolerance was not always reached within 3 cycles) is reached; *Fixed repetitions* runs a set number of cycles.

**Error metrics.** The tab offers the metrics of the Anhysteretic fit (see [Optimization technique](#optimization-technique)) in the normalized linear plane, $H/H_{TIP}$ and $M/M_{TIP}$: **Diagonal (H, continuous)** (default), **Diagonal (H, sampled)**, **Vertical**, and **Horizontal**. The continuous metric measures the distance from each measured point to the whole simulated cycle. The other three need single-valued curves, so the measured and simulated loops are split at their minimum-$H$ corner into descending and ascending branches, each measured branch is compared with its simulated counterpart, and the residuals of both branches are pooled into one root mean square. **Diagonal (H, sampled)** is the objective of [[19]](#19), up to the root-mean-square convention noted above.

## Playground: forward hysteretic simulations

The **Playground** tab is a forward-simulation sandbox: given a set of JA parameters ($M_{S}$, $a$, $\alpha$, $k$, $c$), typically the output of the Hysteretic fitting tab, it simulates and plots the magnetization response to a prescribed applied-field history. It offers four simulation modes, all built from the same monotonic-branch integrator described in the previous section.

- **Major loop** — a single symmetric hysteresis loop between $\pm H_{TIP}$, started from a demagnetized state, from the data tip, or from a user-defined $\left( H_{start},M_{start} \right)$, and cycled either a fixed number of times or until the returning tip magnetization converges. This reproduces the same simulated loop used internally by the Hysteretic fitting tab and is the standard way to visually check a fitted parameter set or to explore how each JA parameter shapes the loop.
- **Minor loops (nested)** — a sequence of symmetric field excursions $\pm H_{tip\ i}$ of increasing amplitude, run from a demagnetized state and bridged from the smallest to the largest tip, each cycled to a fixed repetition count or to convergence. With a measured loop loaded, the three default amplitudes are spaced geometrically from half its coercive field to its tip, $H_{l}\left( H_{TIP}/H_{l} \right)^{1/3,\ 2/3,\ 1}$ with $H_{l} = H_{C}/2$, so that the loops stay open and distinct however far the measurement was driven into saturation. This simulates the family of nested minor (recoil) loops obtained by driving a sample with sub-saturation field amplitudes.
- **Degaussing** — a decaying, alternating sequence of field reversals (by default, ten amplitudes decaying geometrically from the measured tip field to 2 % of it; the number of steps and both amplitudes are editable) ending in a sweep to $H=0$, reproducing the standard AC-demagnetization ("degaussing") protocol used experimentally to bring a sample to a low-remanence state.
- **Major loop with harmonics** — a major loop driven by a distorted periodic field $H(\theta) = \sum_{j}{A_{j}\sin\left( j\theta + \varphi_{j} \right)}$, with $j$ running over the harmonic orders chosen, instead of a pure sinusoid ($\theta$ being the field's phase over one period). Because the JA model is rate-independent (see previous section), the simulation only needs the field's turning points within one period, found by densely sampling $H(\theta)$; harmonic content adds extra turning points, which appear as extra, generally asymmetric, minor loops nested inside the major loop. This mode is relevant, e.g., to estimate the hysteretic response under non-sinusoidal (harmonic-rich) excitation, as encountered downstream of power-electronic converters — although, being rate-independent, the JA model still cannot capture frequency-dependent (eddy-current, magnetic viscosity) losses.

Every mode integrates the prescribed field history leg by leg, concatenating consecutive monotonic branches; the resulting curve, its underlying per-branch bookkeeping (e.g., which samples belong to each tip's last loop, or to each period), and the field-history metadata used to generate it can all be exported from the unified Export dialog together with the simulated figure.

## Graphical user interface

We have developed the toolbox with a graphical user interface (GUI) to simplify its usage. The GUI is organized into four tabs — **Input data**, **Anhysteretic fitting**, **Hysteretic fitting**, and **Playground** — plus a **Project** menu for project management and data export. MagAnalyst allows users to set up a new project, fit an anhysteretic curve using the Silveyra-Conde Garrido approach, fit a hysteresis loop using the Jiles-Atherton model, and forward-simulate JA loops in the Playground tab, all with just a few clicks and inputs. Additionally, users have the flexibility to save their projects at any point during the analysis, enabling them to resume it at a later time.

The software automatically converts the input data for analysis into $M\left\lbrack \frac{A}{m} \right\rbrack$ vs $H\left\lbrack \frac{A}{m} \right\rbrack$ for the analysis and fitting process, following the conversion formulae provided in Table I. If other field units are required for the input data, they can be made available upon request.

The vertical axis may also be imported as **mass magnetization**, $\sigma\left\lbrack \frac{emu}{g} = \frac{Am^{2}}{kg} \right\rbrack$ (the two units are numerically identical). In that case no volume conversion is applied: since the model equations are unit-agnostic, the whole analysis — fitting parameters, modeled curves, and errors — proceeds consistently in mass-magnetization units, and the GUI relabels every magnetization quantity accordingly ($\sigma$, $\sigma_{S}$, etc.). The approach for fitting mass-magnetization curves is described in Ref. [[21]](#21).

The magnetization input data can be either an anhysteretic curve or a symmetric hysteresis loop. If a hysteresis loop is provided, the software calculates the anhysteretic curve as the mean of the left and right branches of the $M$ vs $H$ loop (input data can be noisy and begin at any point of the loop). MagAnalyst assumes that the anhysteretic curve exhibits odd symmetry and restricts the analysis to the first quadrant. The Matlab function `interparc`, developed by John D'Errico [[16]](#16), guarantees that the points are evenly spaced in a normalized M vs log(H) plane. The tab displays two plots: the raw and the processed input data plots, which can be viewed in linear or logarithmic scale for $H$ and are updated based on user selections. 

### Digitizing data from published figures

Measured curves are often only available as a figure in a paper. MagAnalyst ships its own digitizer for this, the **MagAnalyst Plot Digitizer** (version 1.0.0, in `tools/plot_digitizer/`), which recovers numerical $(x,y)$ data from a raster image of a plot and writes it as a CSV ready for the Input-data tab. It is a separate GUI, not loaded by the main app; launch it with

```matlab
addpath(fullfile('tools','plot_digitizer'));
PlotDigitizer
```

The workflow is: load the image, calibrate each axis from two points of known value (linear or logarithmic axes are both supported), restrict the working region to the plot box (detected automatically), then extract either

- a **continuous line**, traced by masking the curve's color — detected automatically from the image — thinning the mask to a one-pixel centerline with a Zhang-Suen-family algorithm [[25]](#25)[[26]](#26), and ordering that skeleton into a single polyline; or
- **discrete data markers**, located by normalized cross-correlation against a marker template the user picks from the image [[27]](#27), with a Hough circle vote [[28]](#28) refining round-marker centers.

A whole digitizing session (image, calibration, extracted series) is saved as a `.pdig` project file and can be reopened later. The tool is documented in full, for its own standalone release, in `tools/plot_digitizer/README.md`; `demo_plot_digitizer` walks through a worked example and `test_plot_digitizer` runs its self-test suite.

The general-purpose web tool WebPlotDigitizer [[17]](#17) (version 5.2 at the time of writing; the sample data shipped with MagAnalyst was digitized with version 4.6) remains a good alternative, particularly for figure types outside the $M(H)$ curves the MagAnalyst Plot Digitizer is tuned for.

The Residual plots, available for $M$ vs. $H$, $\frac{\partial M}{\partial H}$ vs. $H$, and $\frac{\partial M}{\partial\ln H}$ vs. $H$ graphs, display the arrays of vertical errors 

$$\begin{align}
r_{i}\left( X_{i} \right) = Y\left( X_{i} \right) - \widehat{Y}\left( X_{i} \right),
\end{align}$$

where the dependent variable $Y$ is $M$, $\frac{\partial M}{\partial H}$, or $\frac{\partial M}{\partial\ln H}$, respectively, and the independent variable $X$ is $H$.

Tutorial videos are available on YouTube, illustrating how to analyze and fit an anhysteretic magnetization curve with either [one](https://youtu.be/r4jyjOQ61yY) or [two](https://youtu.be/7WqBK7YCKWY) component magnetizations.

Both fitting tabs display a live **optimization progress** plot: the lowest error found so far, on a logarithmic axis, against the solver's iterations (Nelder-Mead) or evaluations (DFO-LS, BOBYQA, and the polish). A fit can be stopped at any point with **Stop fit** and started again from the best point found.

All artifacts produced by the toolbox — raw and processed input data, the modeled anhysteretic curve with its parameters and residuals, the modeled hysteresis loop with its JA parameters and residuals, every Playground-simulated curve with its metadata, the optimization-progress histories, and every figure — can be exported at once from the unified **Project → Export…** dialog, as CSV/TXT data files and PNG/PDF/SVG figures. The parameter files also record the fitting conditions: for the anhysteretic fit, the number of components, the fit mode (constrained by $n$ data points or free), the linear term, the parameters held at their value, the error metric, the solver and the significant digits; for the Jiles–Atherton fit, the starting point, fitting region, stop criterion, whether $k$ was derived from $H_{C}$, the error metric, solver, significant digits and bounds.

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
  | $$\sigma\left\lbrack \frac{emu}{g} = \frac{Am^{2}}{kg} \right\rbrack$$ | kept as $$\sigma\left\lbrack \frac{Am^{2}}{kg} \right\rbrack$$ (mass magnetization; see text above and Ref. [[21]](#21))|

Other input fields can be made available upon request.

## References

<a id="1">[1]</a> 
J. M. Silveyra and J. M. Conde Garrido, "On the anhysteretic magnetization of soft magnetic materials," AIP Advances, vol. 12, p. 035019, 2022. https://doi.org/10.1063/9.0000328
<br>
<a id="2">[2]</a>
P. Weiss, "L'hypothèse du champ moléculaire et la propriété ferromagnétique," J. Phys. Theor. Appl., vol. 6, pp. 661-690, 1907. https://doi.org/10.1051/jphystap:019070060066100
<br>
<a id="3">[3]</a>
P. Langevin, "Sur la théorie du magnétisme," J. Phys. Theor. Appl., vol. 4, pp. 678-693, 1905. https://doi.org/10.1051/jphystap:019050040067800
<br>
<a id="4">[4]</a>
J. M. Silveyra and J. M. Conde Garrido, "A physically based model for soft magnets’ anhysteretic curve," JOM, vol. 75, pp. 1810-1823, 2023. https://doi.org/10.1007/s11837-023-05704-x
<br>
<a id="5">[5]</a>
J. Pytlík, J. Luňáček, and O. Životský, "Differential isotropic model of ferromagnetic hysteresis," Physical Review B, vol. 108, p. 104414, 2023. https://doi.org/10.1103/PhysRevB.108.104414
<br>
<a id="6">[6]</a>
K. Chwastek, P. Gębara, A. Przybył, R. Gozdur, A. P. S. Baghel, and B. S. Ram, "An Alternative Formulation of the Harrison Model," Applied Sciences, vol. 13, p. 12009, 2023. https://doi.org/10.3390/app132112009
<br>
<a id="7">[7]</a>
M. Kröger, "Simple, admissible, and accurate approximants of the inverse Langevin and Brillouin functions, relevant for strong polymer deformations and flows," Journal of Non-Newtonian Fluid Mechanics, vol. 223, pp. 77-87, 2015. https://doi.org/10.1016/j.jnnfm.2015.05.007
<br>
<a id="8">[8]</a>
Matlab. linsolve - Solve linear system of equations. Available: https://www.mathworks.com/help/matlab/ref/linsolve.html. Accessed: 3 November 2023
<br>
<a id="9">[9]</a>
Matlab. fzero - Root of nonlinear function. Available: https://www.mathworks.com/help/matlab/ref/fzero.html. Accessed: 3 November 2023
<br>
<a id="10">[10]</a>
J. M. Silveyra and J. M. Conde Garrido, "On the modelling of the anhysteretic magnetization of homogeneous soft magnetic materials," Journal of Magnetism and Magnetic Materials, vol. 540, p. 168430, 2021. https://doi.org/10.1016/j.jmmm.2021.168430
<br>
<a id="11">[11]</a>
J. D'Errico. distance2curve - Distance from a point or points to a general curvilinear n-dimensional arc. Available: https://www.mathworks.com/matlabcentral/fileexchange/34869-distance2curve. Accessed: 13 April 2026
<br>
<a id="12">[12]</a>
Matlab. interp1 - 1-D data interpolation. Available: https://www.mathworks.com/help/matlab/ref/interp1.html. Accessed: 3 November 2023
<br>
<a id="13">[13]</a>
Matlab. minimize - Minimize constrained functions with FMINSEARCH or FMINLBFGS, globally or locally. Available: https://www.mathworks.com/matlabcentral/fileexchange/24298-minimize, https://github.com/rodyo/FEX-minimize/releases/tag/v1.8. Accessed: 3 November 2023
<br>
<a id="14">[14]</a>
Matlab. fminsearch - Find minimum of unconstrained multivariable function using derivative-free method. Available: https://www.mathworks.com/help/matlab/ref/fminsearch.html. Accessed: 3 November 2023
<br>
<a id="15">[15]</a>
Matlab. fmincon - Find minimum of constrained nonlinear multivariable function. Available: https://www.mathworks.com/help/optim/ug/fmincon.html. Accessed: 3 November 2023
<br>
<a id="16">[16]</a>
J. D'Errico. interparc - Distance based interpolation along a general curve in space. Available: https://www.mathworks.com/matlabcentral/fileexchange/34874-interparc. Accessed: 19 July 2026
<br>
<a id="17">[17]</a>
A. Rohatgi. WebPlotDigitizer. Available: https://automeris.io. Accessed: 19 September 2023
<br>
<a id="18">[18]</a>
D. C. Jiles and D. L. Atherton, "Theory of ferromagnetic hysteresis," Journal of Magnetism and Magnetic Materials, vol. 61, no. 1-2, pp. 48-60, 1986. https://doi.org/10.1016/0304-8853(86)90066-1
<br>
<a id="19">[19]</a>
J. M. Conde Garrido, J. Ugarte Valdivielso, J. I. Aizpurua, M. Barrenetxea Iñarra, and J. M. Silveyra, "Blind Efficient Method for Optimizing Jiles-Atherton Model Parameters," IEEE Transactions on Magnetics, vol. 62, pp. 1-11, 2026. https://doi.org/10.1109/TMAG.2025.3632479
<br>
<a id="20">[20]</a>
Matlab. ode23tb - Solve stiff differential equations and DAEs — trapezoidal rule + backward differentiation formula. Available: https://www.mathworks.com/help/matlab/ref/ode23tb.html. Accessed: 7 April 2026
<br>
<a id="21">[21]</a>
J. M. Silveyra, A. Rosales Rivera, N. Salazar Henao, D. Salazar, and J. M. Conde Garrido, "Magnetometry analysis via a multicomponent Langevin-Weiss model with susceptibility-dependent demagnetization," Journal of Magnetism and Magnetic Materials, vol. 647, p. 174000, 2026. https://doi.org/10.1016/j.jmmm.2026.174000
<br>
<a id="22">[22]</a>
M.J.D. Powell, "The BOBYQA algorithm for bound constrained optimization without derivatives," Report DAMTP 2009/NA06, Centre for Mathematical Sciences, University of Cambridge, 2009.
<br>
<a id="23">[23]</a>
Z. Zhang, "PRIMA: Reference Implementation for Powell's Methods with Modernization and Amelioration," available at https://www.libprima.net, 2023. https://doi.org/10.5281/zenodo.8052654
<br>
<a id="24">[24]</a>
J. E. Dennis, Jr. and R. B. Schnabel, Numerical Methods for Unconstrained Optimization and Nonlinear Equations, Classics in Applied Mathematics, vol. 16. Philadelphia, PA, USA: SIAM, 1996, ch. 7. https://doi.org/10.1137/1.9781611971200
<br>
<a id="25">[25]</a>
T. Y. Zhang and C. Y. Suen, "A fast parallel algorithm for thinning digital patterns," Communications of the ACM, vol. 27, no. 3, pp. 236-239, 1984. https://doi.org/10.1145/357994.358023
<br>
<a id="26">[26]</a>
H. E. Lu and P. S. P. Wang, "A comment on 'A fast parallel algorithm for thinning digital patterns'," Communications of the ACM, vol. 29, no. 3, pp. 239-242, 1986. https://doi.org/10.1145/5666.5670
<br>
<a id="27">[27]</a>
J. P. Lewis, "Fast normalized cross-correlation," Vision Interface, vol. 10, no. 1, pp. 120-123, 1995. Available: https://scribblethink.org/Work/nvisionInterface/nip.html
<br>
<a id="28">[28]</a>
R. O. Duda and P. E. Hart, "Use of the Hough transformation to detect lines and curves in pictures," Communications of the ACM, vol. 15, no. 1, pp. 11-15, 1972. https://doi.org/10.1145/361237.361242
<br>
<a id="29">[29]</a>
D. Kodek and K. Steiglitz, "Comparison of optimal and local search methods for designing finite wordlength FIR digital filters," IEEE Transactions on Circuits and Systems, vol. 28, no. 1, pp. 28-32, 1981. https://doi.org/10.1109/TCS.1981.1084909
<br>
<a id="30">[30]</a>
C. Audet, S. Le Digabel, and C. Tribes, "The mesh adaptive direct search algorithm for granular and discrete variables," SIAM Journal on Optimization, vol. 29, no. 2, pp. 1164-1189, 2019. https://doi.org/10.1137/18M1175872
<br>
<a id="31">[31]</a>
C. Cartis, J. Fiala, B. Marteau, and L. Roberts, "Improving the flexibility and robustness of model-based derivative-free optimization solvers," ACM Transactions on Mathematical Software, vol. 45, no. 3, art. 32, 2019. https://doi.org/10.1145/3338517
