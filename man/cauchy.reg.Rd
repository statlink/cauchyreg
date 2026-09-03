\name{cauchy.reg}
\alias{cauchy.reg}
\title{
Cauchy regression
}

\description{
Cauchy regression
}

\usage{
cauchy.reg(y, x, tol = 1e-07, maxit = 100, xnew = NULL)
}

\arguments{
\item{y}{
A numerical vector with the response values.
}
\item{x}{
A numerical matrix or a data.frame with predictor variables.
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
Cauchy regression is performed.
}

\value{
A list including:
\item{be}{
The regression coefficients.
}
\item{sigma}{
The scale parameter.
}
\item{iters}{
The number of iterations the Newton-Raphson required.
}
\item{loglik}{
The log-likelihood value.
}
\item{est}{
The estimated values if xnew is not NULL, otherwise this is NULL.
}
}

\references{
Liu T. and Tao D. (2014, April). On the robustness and generalization of Cauchy regression.
In 2014 4th IEEE International Conference on Information Science and Technology (pp. 100-105). IEEE.
}

\author{
Michail Tsagris.

R implementation and documentation: Michail Tsagris \email{mtsagris@uoc.gr}.
}

%\note{
%%  ~~further notes~~
%}

\seealso{
\code{\link{cauchy.regs}, \link{cauchy.reg.lasso}
}
}

\examples{
y <- iris[, 1]
x <- as.matrix(iris[, 2:4])
mod <- cauchy.reg(y, x)
}
