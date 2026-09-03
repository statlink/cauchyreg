\name{cv.cauchyreglasso}
\alias{cv.cauchyreglasso}
\title{
LASSO Cauchy regression
}

\description{
Cross-validation for the LASSO Cauchy regression
}

\usage{
cv.cauchyreglasso(y, x, lambda = NULL, nlambda = 100, tol = 1e-07, maxit = 100,
folds = NULL, nfolds = 10, seed = NULL)
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
\item{folds}{
If you have the list with the folds supply it here. You can also leave it NULL and the function will create folds.
}
\item{nfolds}{
If the user did not pass the folds argument, then they need to specify the number of folds to produce.
}
\item{seed}{
You can specify your own seed number here or leave it NULL.
}
}

\details{
The function performs K-fold cross-validation to select the optimal value of lambda.
}

\value{
A matrix with two columns, the lambda values and their corresponding MSE values.
}

%\references{
%}

\author{
Michail Tsagris.

R implementation and documentation: Michail Tsagris \email{mtsagris@uoc.gr}.
}

\seealso{
\code{\link{cauchy.regs}, \link{cauchy.reg.lasso}
}
}

\examples{
y <- iris[, 1]
x <- as.matrix(iris[, 2:4])
}
