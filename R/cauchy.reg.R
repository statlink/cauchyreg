cauchy.reg <- function(y, x, tol = 1e-07, maxit = 100, xnew = NULL) {

  x <- model.matrix( y~., data.frame(x) )
  dm <- dim(x)
  n <- dm[1]     ;     p <-  dm[2]
  nlogpi <-  - n * log(pi)
  mod <- Rfast::cauchy.mle(y)
  lik1 <- mod$loglik
  be <- c(mod$par[1], numeric(p - 1) )
  g <- mod$param[2]
  res <- y - mod$param[1]
  res2 <- res^2
  down <- 1 / ( g^2 + res2 )
  derb <-  - Rfast::eachcol.apply(x, res * down)  ## I deleted the term "2 *"
  derb2 <- crossprod(x, down * x )  ## I deleted the term "2 *"
  be <- be - solve(derb2, derb)
  res <- y - drop( x %*% be )
  res2 <- res^2
  down <- 1 / ( g^2 + res2 )
  g <- sqrt( n / sum(2 * down) )
  lik2 <- n * log(g) + sum( log( down ) )
  i <- 2

  while ( lik2 - lik1 > tol  &  i < maxit ) {
    i <- i + 1
    lik1 <- lik2
    derb <-  - Rfast::eachcol.apply(x, res * down)  ## I deleted the term "2 *"
    derb2 <- crossprod(x, down * x )  ## I deleted the term "2 *"
    be <- be - solve(derb2, derb)
    res <- y - drop( x %*% be )
    res2 <- res^2
    down <- 1 / ( g^2 + res2 )
    g <- sqrt( n / sum(2 * down) )
    lik2 <- n * log(g) + sum( log( down ) )
  }

  est <- NULL
  if ( !is.null(xnew) ) {
    xnew <- model.matrix(~., data = as.data.frame(xnew) )
    est <- drop( xnew %*% be )
  }
  names(be) <- colnames(x)
  list(be = be, sigma = g, iters = i, loglik = lik2 + nlogpi, est = est)
}
