# ---- Load Required Packages ----
library(fmcmc)  
library(MASS)   
library(coda)   
library(Sim.DiffProc)   



# ---- Data Preparation ----
setwd("./Codes/")
load("polysemous_data.Rdata")  



# ---- Core Functions ----
# Define a function to compute the logarithm of the conditional probability density function
log_cond_pdf <- function(xt1, xt2, x1, x2, dt, drift_vec, diff_vec){
  Q <- diag(c(drift_vec[1] * x2 * (1 - drift_vec[2]), 
              drift_vec[1] * x1 * (drift_vec[2] - 1))) 
  diff <- c(diff_vec, -diff_vec)
  Sigma <- diag(diff)
  dt <- 2
  mu <- xt1 + t(Q) %*% xt1 * dt
  Var <- dt * Sigma %*% t(Sigma)
  k <- length(xt1)
  if (sum(log(svd(Var)$d)) == -Inf) {
    log.f.xt2.xt1 <- -1e+10
  } else {
    log.f.xt2.xt1 <- (-k/2 * log(2*pi) - 0.5*sum(log(svd(Var)$d)) -
                        0.5*(t(xt2 - mu) %*% ginv(Var) %*% (xt2 - mu)))
  }
  return(log.f.xt2.xt1)
}


# Define a function to compute the loss for parameter estimation
loss <- function(par){
  drift_vec <- par[1:2]
  diff_vec <- par[3]
  dat <- as.matrix(result$df)
  time_diff <- diff(dat[,1])
  
  # Likelihood computation
  log_lik <- sum(sapply(1:(length(time_diff)-1), function(i) {
    log_cond_pdf(xt1 = dat[i, -1], 
                 xt2 = dat[i+1, -1],
                 x1 = dat[i, 2], 
                 x2 = dat[i, 3],
                 dt = time_diff[i],
                 drift_vec, diff_vec)
  }))
  
  # Prior: Uniform(0, 100) for drift parameters
  loss <- log_lik + sum(dunif(drift_vec, max = 100, min = 0, log = T))
  return(loss)
}



# ---- MCMC Setup ----
result <- polysemous_data$entertain
set.seed(123)

# 1. Initialize MCMC chain
sde_mcmc <- MCMC(fun = loss, initial = rep(0.01,3), nsteps = 20000, kernel = kernel_ram())

# 2. Compute posterior log-density
sde_lp <- apply(sde_mcmc, 1, loss)

# 3. Convergence diagnostics (Geweke test)
geweke_test <- geweke.diag(tail(sde_lp, 2000))

# 4. Posterior mean estimation
sde_params <- colMeans(tail(sde_mcmc, 2000))



# ---- SDE Solutions ----
set.seed(123)
mod1d <- snssde1d(
  drift = expression(sde_params[1] * x * (1 - x - sde_params[2] * (1 - x))),
  diffusion = expression(sde_params[3]),
  x0 = result$df[1, 2],
  M = 10000,
  t0 = result$df[, 'year'][1],
  T = result$df[, 'year'][nrow(result$df)],
  Dt = 2,
  N = nrow(result$df) - 1,
  method = 'euler'
)
