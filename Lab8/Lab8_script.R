# Lab 8: Documentation and Metadata



### 1. Complete the markdown tutorial: done!


### 2. Rewrite ther README so that it is a better at describing the Repository: done!


### 3.From last weeks problem number 2 (you can copy and paste it): 

pop_mod  <- function(initsize=10, generations=10, r=.02, K=1000){ ## defaults
  abundance <- rep(initsize, generations)  ## empty container
  for(i in 2:length(abundance)){          
    abundance[i] = abundance[i-1] + ( r * abundance[i-1] * (K - abundance[i-1])/K ) ## equation
  }
  plot(abundance, xlab="Generations", ylab = "Abundance", main = "Population Model" ) #plot the results 
  return(abundance) #return the data
  write.csv(abundance, file = "growthModel_Version"
}
