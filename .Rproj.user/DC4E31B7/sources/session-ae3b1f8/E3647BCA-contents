cauchy.regs <- function(y, x, tol = 1e-07, maxit = 100) {

  n <- dim(x)[1]  ;    p <- dim(x)[2]
  X <- cbind(1, numeric(n) )
  nlogpi <-  - n * log(pi)
  mod <- Rfast::cauchy.mle(y)
  lik0 <- mod$loglik
  be0 <- c(mod$par[1], 0)
  g0 <- mod$param[2]
  res0 <- y - mod$param[1]
  res2 <- res0^2
  down0 <- 1 / ( g0^2 + res2 )
  result <- matrix(nrow = p, ncol = 4)
  colnames(result) <- c("constant", "slope", "scale", "loglik")
  derb0 <-  - Rfast::eachcol.apply(x, res0 * down0)
  com <-  - sum(res0 * down0)

  for ( j in 1:p ) {
    X[, 2] <- x[, j]
    lik1 <- lik0
    derb <- c( com, derb0[j] )
    derb2 <- crossprod(X, down0 * X)
    be <- be0 - solve(derb2, derb)
    res <- y - drop( X %*% be )
    res2 <- res^2
    down <- 1 / ( g0^2 + res2 )
    g <- sqrt( n / sum(2 * down) )
    lik2 <- n * log(g) + sum( log( down ) )
    i <- 2

    while ( lik2 - lik1 > tol  &  i < maxit ) {
      i <- i + 1
      lik1 <- lik2
      derb <-  - Rfast::eachcol.apply(X, res * down)
      derb2 <- crossprod(X, down * X)
      be <- be - solve(derb2, derb)
      res <- y - drop( X %*% be )
      res2 <- res^2
      down <- 1 / ( g^2 + res2 )
      g <- sqrt( n / sum(2 * down) )
      lik2 <- n * log(g) + sum( log( down ) )
    }
    result[j, ] <- c(be, g, lik2)

  }

  result[, 4] <- result[, 4] + nlogpi
  result

}
