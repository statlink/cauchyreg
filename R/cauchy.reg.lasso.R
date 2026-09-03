cauchy.reg.lasso <- function(y, x, lambda = NULL, nlambda = 100, tol = 1e-07, maxit = 100, xnew = NULL) {

  dm <- dim(x)
  n <- dm[1]   ;   p <- dm[2]
  mod <- Rfast::cauchy.mle(y)
  nam <- colnames(x)
  if ( !is.null(nam) ) {
    nam <- c("Intercept", nam)
  } else  nam <- c( "Intercept", paste("X", 1:p, sep = "") )

  be <- c( mod$par[1], numeric(p) )
  g <- mod$param[2]
  m <- Rfast::colmeans(x)
  s <- Rfast::colVars(x, std = TRUE)
  x <- t( ( t(x) - m ) / s )
  x_full <- cbind(1, x)
  res <- y - drop(x_full %*% be)
  res2 <- res^2
  down <- 1 / (g^2 + res2)
  if ( is.null(lambda) )  {
    lmax <- max( abs( crossprod(x, y) ) ) / n
    lambda <- seq(lmax, 0, length = nlambda)
  }
  B <- matrix(nrow = p + 1, ncol = length(lambda) )
  rownames(B) <- nam

  B[, 1] <- be
  for ( i in 2:nlambda ) {
    mod <- try( .path(B[, i - 1], y, x, x_full, n, down, lambda[i], maxit, tol), silent = TRUE )
    if ( identical( class(mod), "try-error" ) ) {
      break
    } else  {
      B[, i] <- mod$be
      down <- mod$down
    }
  }
  norm <- Rfast::colsums( abs(B[-1, ]) )

  d <- diff(norm)
  ep <- which( d == 0 )
  if ( length(ep) > 0 ) {
    B <- B[, -ep]
    norm <- norm[-ep]
    lambda <- lambda[-ep]
  }

  est <- NULL
  if ( !is.null(xnew) ) {
    xnew <- as.matrix(xnew)
    if ( dim(xnew)[2] == 1 )  xnew <- t(xnew)
    est <- matrix( nrow = dim(xnew)[1], ncol = dim(B)[2] )
    xnew <- t( ( t(xnew) - m ) / s )
    xnew <- cbind(1, xnew)
    for ( i in 1:dim(B)[2] )  est[, i] <- drop(xnew %*% B[, i])
  }

  list(B = B, est = est, lambda = lambda, norm = norm)
}


.path <- function(be, y, x, x_full, n, down, lambda, maxit, tol) {
  converged <- FALSE
  iters <- 1
  while ( iters < maxit && !converged ) {
    iters <- iters + 1
    be_old <- be
    fit <- glmnet::glmnet(x, y, weights = down, lambda = lambda,
                   intercept = TRUE, standardize = FALSE)
    be <- as.vector( coef(fit) )
    res <- y - drop(x_full %*% be)
    res2 <- res^2
    down <- 1 / (g^2 + res2)   # Weights based on OLD sigma
    g <- sqrt( n / sum(2 * down) )  # YOUR EXACT FORMULA
    down <- 1 / (g^2 + res2)
    beta_change <- sqrt( sum((be - be_old)^2) )
    beta_norm <- sqrt( sum(be_old^2) ) + 1  # +1 prevents division by zero
    if ( beta_change / beta_norm < tol )  converged <- TRUE
  }
  list(be = be, down = down)
}
