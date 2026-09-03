cv.cauchyreglasso <- function(y, x, lambda = NULL, nlambda = 100, tol = 1e-07, maxit = 100,
                     folds = NULL, nfolds = 10, seed = NULL) {

  n <- dim(x)[1]
  if ( is.null(folds) )  folds <- Compositional::makefolds(1:n, nfolds = nfolds, seed = seed,
                                                 stratified = FALSE)
  nfolds <- length(folds)
  lambda <- cauchyreg::cauchy.reg.lasso(y = y, x = x, lambda = lambda, nlambda = nlambda, tol = tol, maxit = maxit)$lambda
  mse <- matrix(nrow = nfolds, ncol = length(lambda) )

  for ( k in 1:nfolds ) {
    xtest <- x[ folds[[ k ]], ]
    xtrain <- x[ -folds[[ k ]], ]
    ytest <- y[ folds[[ k ]] ]
    ytrain <- y[ -folds[[ k ]] ]
    est <- cauchyreg::cauchy.reg.lasso(y = ytrain, x = xtrain, lambda = lambda, tol = tol, maxit = maxit, xnew = xtest)$est
    mse[k, ] <- Rfast::colmeans( (est - ytest)^2 )
  }
  mse <- cbind( lambda, Rfast::colmeans(mse) )
  colnames(mse) <- c("lambda", "mse")
}

