\name{cauchy.regs}
\alias{cauchy.regs}
\title{
Many simple Cauchy regressions
}

\description{
Many simple Cauchy regressions
}

\usage{
cauchy.regs(y, x, tol = 1e-07, maxit = 100)
}

\arguments{
\item{y}{
A numerical vector with the response values.
}
\item{x}{
A numerical matrix with predictor variables.
}
\item{tol}{
The tolerance value to terminate the IRLS algorithm.
}
\item{maxit}{
The maximum number of iterations to perform the IRLS algorithm.
}
}

\details{
The function performs many simply Cauchy regressions, one for each column of x.
}

\value{
A matrix with 4 columns, the constant terms, the slope coefficients, the scale parameters and the
log-likelihood values. Each row corresponds to a column in x.
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
\code{\link{cauchy.reg}, \link{cauchy.reg.lasso}
}
}

\examples{
y <- iris[, 1]
x <- as.matrix(iris[, 2:4])
mod <- cauchy.regs(y, x)
}
