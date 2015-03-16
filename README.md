# dscr-smash
A simulation study comparing the wavelet shrinkage procedure SMASH (Xing and Stephens) and other popular wavelet denoising procedures

# Background 

For a general introduction to DSCs, see [here](https://github.com/stephens999/dscr/blob/master/intro.md).

In this simulation study, we aim to compare several methods for performing nonparametric regression in the Gaussian case. The problem is of the form Y_i=\mu_i+\epsilon_i, i=1,...,n, where \mu is the underlying mean function and assumed to be "smooth", and \epsilon_i's are independent Gaussian noise with mean 0 and variance \sigma_i^2. The goal is to recover \mu as accurately as possible given Y.

The simulation schemes cover a wide range of different mean and variance functions (\mu and \sigma), as well as different signal to noise ratios (SNRs). The various methods are run and the resulting estimate of \mu is scored using the mean integrated squared error (MISE), which is simply the standard mean squared error rescaled appropriately.

# Input, meta and output formats

This DSC uses the following formats:

`input: list(x [vector], sig.true [vector], sig.est [vector])` #x is the vector of observations. sig.true contains the true values of \sigma_i, and sig.est is an estimate of \sigma under the assumption that all \sigma_i's are equal.

`meta: list(mu [vector])` #mu contains the true values of \mu_i as defined above


`output: an estimate of \mu [vector]` 


# Scores

The performance of a method is scored by the quantity 10000*sum((\mu_i-\mu-hat_i)^2)/sum(\mu_i^2), where \mu is the true mean function and \mu-hat is the estimated mean function

See [score.R](score.R).

# To add a method

To add a method there are two steps.

- add a `.R` file containing an R function implenting that method to the `methods/` subdirectory
- add the method to the list of methods in the `methods.R` file.

Each method function must take arguments `(input,args)` where `input` is a list with the correct format (defined above), and `args` is a list containing any additional arguments the method requires.

Each method function must return `output`, where `output` is a list with the correct format (defined above).

# To add a scenario

To add a scenario there are two steps, the first of which can be skipped if you are using an existing datamaker function

- add a `.R` file containing an R function implenting a datamaker to the `datamakers/` subdirectory
- add the scenario to the list of scenarios in the `scenarios.R` file.

Each datamaker function must return a `list(meta,input)` where `meta` and `input` are each lists with the correct format
(defined above).


