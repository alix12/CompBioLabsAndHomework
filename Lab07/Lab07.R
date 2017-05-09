### Lab 7
### Writing your own functions!!!

## Problem 1
## The Return of the Fibonacci Sequence

## Write a for loop  write a function that returns a vector of the first n Fibonacci
## numbers, where n is any integer >= 3. Your function should take two arguments:
## the user's desired value of n and the user's desired starting number 
## (either 0 or 1 as explained in the quote  in the lab).


## s = start value
## l = length of vector of fibonacci numbers
## n = storage

Fib_seq <- function(s = 0, l = 10){
  n <- rep(NA, l)
  if (s > 1 || s < 0 ) {
    print("Error, s must equal 0 or 1")
  } else {
    n[1] <- s
    n[2] <- 1
    
    if (l == 2) {
      return(n[1:2])
    } else if (l==1){
      return(n[1])
    }else {
      for( i in 3:length(n) ) {
        n[i] <- n[i-1] + n[i-2]
      }
      return(n)
    }
  }  
}
  


## Problem 2
## recall: n[t] = n[t-1] + ( r * n[t-1] * (K - n[t-1])/K )
## Write a function that implements this model. The function should do the following:
  
## a. Take parameters as arguments (inputs). This includes the following as parameters: 
##  initial population size (n[1]), total number of generations, r, K.
## b. have default values for each of the arguments
## c. iterate the model
## d. make a plot with axes properly labeled.
## e. return the abundance data.

pop_mod <- function(n, t, r, K,) {
  for (t in vector) {
    
  }
  abundance = n[t-1] + ( r * n[t-1] * (K - n[t-1])/K )
  
  plot()
  return(abundance)
}

## Problem 3 - social networks
#chat with Chelsea :D

## adjacency matrix
X <- matrix( c(0, 1, 1, 1, 0, 0, 1, 0, 0), nrow=3, ncol=3)


Matrix2Pairwise <- function(X){
  NotZero <- which(X != 0)      ## find all non-zeros in matrix
  Pairwise <- matrix(data=1, nrow=length(NotZero), ncol=3) ## make a new container
  colnames(Pairwise) <- c("Row", "Column", "Value")   ## Add column names
  k <- 1
  for(i in 1:ncol(X)){   
    for(j in 1:nrow(X)){  
      if(X[j, i] != 0){    ## if value is not zero add to pairwise matrix
        Pairwise[k,"Column"] <- i  
        Pairwise[k,"Row"] <- j     
        Pairwise[k,"Value"] <- X[j, i] 
        k <- k+1
      }
    }
    
  }
  
  return(Pairwise) 
}

Y <- Matrix2Pairwise(X)
Y

Pairwise2Matrix <- function(Y){
  New_X <- matrix(data=1, nrow=max(Y[,1]) , ncol=max(Y[,2]))
  
  
  return(New_X)
}


