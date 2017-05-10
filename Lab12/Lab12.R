### Lab 12



##1. Write a function that simulates this
## stochastic model of population dynamics.
## Your function should take three arguments: 
## (i) r, (ii) k, (iii) the total number of
## generations to simulate, and (iv) the initial 
## value of abundance. As default values of these 
## parameters, I suggest using r = 0.1, 
## k = 100, gens = 100, n_init = 10.

Stochapopdy <- function(r =0.1, k = 100, generations = 100, intit = 10) {
  n <- rep(intit, generations) 
  for(i in 2:generations){
    exp <- n[i -1] + r * n[i - 1] * (k - n[i - 1]) / k 
    real <- rpois(n = 1, exp) 
    n[i] <- real
  }
  return(n)
}

## run the modelll!!
n <- Stochapopdy()
