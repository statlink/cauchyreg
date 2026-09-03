\name{cauchy.reg.lasso}
\alias{cauchy.reg.lasso}
\title{
LASSO Cauchy regression
}

\description{
LASSO Cauchy regression
}

\usage{
cauchy.reg.lasso(y, x, lambda = NULL, nlambda = 100,
tol = 1e-07, maxit = 100, xnew = NULL)
}

\arguments{
\item{y}{
A numerical vector with the response values.
}
\item{x}{
A numerical matrix with predictor variables.
}
\item{lambda}{
The user may supply their own lambda values. If NULL, the function computes the grid of values.
}
\item{nlambda}{
If the user does not provide a vector of lambda values they may specify how many shall the function use.
}
\item{tol}{
The tolerance value to terminate the IRLS algorithm.
}
\item{maxit}{
The maximum number of iterations to perform the IRLS algorithm.
}
\item{xnew}{
If you have new values for the predictors put them here.
}
}

\details{
LASSO is implemented using a path of lambda values.
}

\value{
A list including:
\item{B}{
A matrix with the stimated coefficients for each value of lambda. The rows correspond to the predictors
and the columns to the lambda values.
}
\item{est}{
A matrix with the estimated response values if xnew is not NULL. Each column corresponds to a different
value of lambda.
}
\item{lambda}{
The lambda values used.
}
\item{norm}{
The sum of the absolute values of the coefficients for each value of lambda.
}
}

%\references{
%}

\author{
Michail Tsagris.

R implementation and documentation: Michail Tsagris \email{mtsagris@uoc.gr}.
}


\seealso{
\code{\link{cv.cauchyreglasso}, \link{cauchy.reg}
}
}

\examples{
y <- iris[, 1]
x <- as.matrix(iris[, 2:4])
mod <- cauchy.reg.lasso(y, x)
}
