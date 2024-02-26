## Contents of the explanation manual

1. [Theory for the anhysteretic magnetization model](#theory-for-the-anhysteretic-magnetization-model)
2. [Analysis plots](#analysis-plots)
3. [Strategy for retrieving the model parameters](#strategy-for-retrieving the-model-parameters)
4. [Calculation of other physical quantities](#calculation-of-other-physical-quantities) 
5. [Computation of the modeled anhysteretic curve](#computation-of-the-modeled-anhysteretic-curve)
6. [Optimization technique](#optimization-technique)
7. [Examples of the graphical user interface](#examples-of-the-graphical-user-interface)

## Explanation

We use the following law of mixtures to explain the anhysteretic magnetization of soft magnetic materials [1]: the magnetization field ($M$, which corresponds to the moments per unit volume) is the sum of the magnetization of its components ($M_{i}$), each at the same applied magnetic field ($H$) and temperature ($T$)

$$ M(H,T) = \sum_{i = 1}^{n}{M_{i}(H,T)}.$$