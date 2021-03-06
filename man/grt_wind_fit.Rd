% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/grt_wind_fit.R
\name{grt_wind_fit}
\alias{grt_wind_fit}
\title{Fit a GRT-wIND model to identification data}
\usage{
grt_wind_fit(cmats, start_params = c(), rand_pert = 0.3,
  control = list(maxit = 1000, factr = 1e+10))
}
\arguments{
\item{cmats}{List of confusion matrices. Each entry in the list should contain
the 4x4 confusion matrix from one individual (see Details).}

\item{start_params}{An optional vector of parameters to start the
optimization algorithm. You can provide either the group parameters or both
group and individual parameters. It will be created automatically if not
provided (see Details).}

\item{rand_pert}{Maximum value of a random perturbation added to the starting
parameters. With a value of zero, the algorithm is started exactly at
\code{start_params}. As the value of \code{rand_pert} is increased, the starting
parameters become closer to be "truly random."}

\item{control}{A list of control parameters for the \code{optim} function. See
  \code{\link[stats]{optim}}.}
}
\value{
An object of class "\code{grt_wind_fit}."

The function \code{\link{wald}} is used to obtain the
results of Wald tests of perceptual separability, decisional separability and
perceptual independence, using the maximum likelihood parameters estimated
through \code{grt_wind_fit}.

The function \code{summary} is used to obtain a summary of the model fit to
data and the results of Wald tests (if available). The function
\code{\link[=plot.grt_wind_fit]{plot}} is used to print a graphical
representation of the fitted model.
}
\description{
Uses the BFGS optimization method to fit a full GRT-wIND model to data from a
2x2 identification experiment (see Soto et al., 2015).
}
\details{
We recommend that you fit GRT-wIND to your data repeated times, each time
with a different value for the starting parameters, and keep the solution
with the smallest negative log-likelihood. This facilitates finding the true
maximum likelihood estimates of the model's parameters, which is necessary to
make valid conclusions about dimensional separability and independence. The
function \code{\link{grt_wind_fit_parallel}} does exactly this, taking
advantage of multiple CPUs in your computer to speed up the process. For most
applications, you should use \code{\link{grt_wind_fit_parallel}} instead of
the current function.

A 2x2 identification experiment involves two dimensions, A and B, each with
two levels, 1 and 2. Stimuli are represented by their level in each dimension
(A1B1, A1B2, A2B1, and A2B2) and so are their corresponding correct
identification responses (a1b1, a1b2, a2b1, and a2b2).

The data from a single participant in the experiment should be ordered in a
4x4 confusion matrix with rows representing stimuli and columns representing
responses. Each cell has the frequency of responses for the stimulus/response
pair. Rows and columns should be ordered in the following way:

\itemize{ \item{Row 1: Stimulus A1B1} \item{Row 2: Stimulus A2B1}
\item{Row 3: Stimulus A1B2} \item{Row 4: Stimulus A2B2} \item{Column
1: Response a1b1} \item{Column 2: Response a2b1} \item{Column 3: Response a1b2}
\item{Column 4: Response a2b2} }

The argument \code{cmats} is a list with all individual confusion matrices
from an experimental group.

If the value of \code{start_params} is not provided, the starting parameters
for the optimization algorithm are the following:
\itemize{
\item{Means:}{ A1B1=(0,0), A2B1=(1,0), A1B2=(1,0), A2B1=(1,1)}
\item{Variances:}{ All set to one}
\item{Correlations:}{ All set to zero}
\item{Decision bounds:}{ All orthogonal to their corresponding dimension}
\item{Attention parameters:}{ No differences in global attention (kappa=2) and no
selective attention (lambda=0.5)}
}

Note that a random value will be added to these parameters if
\code{rand_pert} is given a value higher than zero.
}
\examples{
# Create list with confusion matrices # In this example, we enter data from
# an experiment with 5 participants. For each participant, inside the c(...),
# enter the data from row 1 in the matrix, then from row 2, etc.
cmats <- list(matrix(c(100,1,9,8,10,110,7,4,31,3,80,10,54,4,52,19),nrow=4,ncol=4,byrow=TRUE))
cmats[[2]] <- matrix(c(122,7,0,1,1,102,1,5,3,2,111,9,11,7,11,106),nrow=4,ncol=4,byrow=TRUE)
cmats[[3]] <- matrix(c(107,0,5,0,0,101,1,4,3,1,113,2,0,3,1,108),nrow=4,ncol=4,byrow=TRUE)
cmats[[4]] <- matrix(c(122,1,0,0,1,120,0,0,0,0,118,6,0,1,6,118),nrow=4,ncol=4,byrow=TRUE)
cmats[[5]] <- matrix(c(89,17,6,4,4,81,8,6,14,7,86,1,11,25,17,26),nrow=4,ncol=4,byrow=TRUE)

# fit the model to data
fitted_model <- grt_wind_fit(cmats)

# plot a graphical representation of the fitted model
plot(fitted_model)

# optionally, you can run a Wald test of separability and independence
fitted_model <- wald(fitted_model, cmats)

# print a summary of the fitted model and tests to screen
summary(fitted_model)

# a data frame with the values of all individual parameters is available in
# in fitted_model$indpar
fitted_model$indpar
}
\references{
Soto, F. A., Musgrave, R., Vucovich, L., & Ashby, F. G. (2015).
  General recognition theory with individual differences: A new method for
  examining perceptual and decisional interactions with an application to
  face perception. \emph{Psychonomic Bulletin & Review, 22}(1), 88-111.
}

