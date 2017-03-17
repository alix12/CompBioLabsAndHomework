KNIGHT_LAB05

## PART I

## Question 1
## Create a vector named x and assign a numeric value to it.
x <- 12
## Next write an if-else statement that checks if the value is greater than 5
## Code should also print if  the value is greater than five

if ( x > 5 ) {
  cat("X is greater than 5")
}

## Question 2

## 2a. Import the file Vector1.csv
setwd("~/Comp Bio/Sandbox/CompBio_on_git/Labs/Lab05")

Vector1 <- read.csv("Vector1.csv")

## 2b. using a for loop, write a code that checks each value in the imported data and replaces every negative value with NA

for( i in 1:length(Vector1$x) ) {
  if( Vector1[i, 1] < 0 ) {
    Vector1[i, 1] <- NA
  }
}
head(Vector1)

## R sees vector1 as a data frame, need to specify that we are looking at row i and column 1

## 2c. now create a new vector of data that has all the values from vector1 that fall inbetween the range 50 and 100
## 50 < x < 100 


newvec <- which(Vector1 > 50 & Vector1 < 100)
newervec <- Vector1[newvec,1]

## Question 3
## Import the data on CO2 from last week's lab
CO2 <- read.csv("CO2_data_cut_paste.csv")

## 3a. What was the first year for which data on "Gas" emissions were non-zero?
## view the data
head(CO2)
## Create a vector using which that contains all the values of gas in the data frame that contain gas values greater than 0
vec <- which(CO2$Gas > 0)
## look at what the string of indicies you made is, to make sure you know
str(vec)
## Make a new storage vector containing all the values of what the indicies indicate 
new_vec <- head(CO2[vec,1]) ### [vec, 1] since we only want values of the years
## Make sure you know what type of container it is in
str(new_vec)
## Now print the first value in your new vector
new_vec[1]
## row 135, column 1 (year 1885)


###### PART II ######## Loops + Conditoinals + Biology
## Lotka-Volterra predator prey model in descrete time
## model
## n[t] <- n[t-1] + (r * n[t-1]) - (a * n[t-1] * p[t-1])
## p[t] <- p[t-1] + (k * a * n[t-1] * p[t-1]) - (m * p[t-1])

## n[t] = abundance of prey at time t
## (r * n[t-1])
## r is the intrinsic growth rate
## (a * n[t-1] * p[t-1])
## a is the attack rate of predators on prey

## p[t] = abundancec of predators at time t
## (k * a * n[t-1])
## k is conversion constant representing the conversion of consumed prey into biomass of predators
## (m * p[t-1])
## m is the mortality rate of the predators (constant)

## Write a code that calculates abundances of predators and prey over time according to this model, using the following parameter values
totalGenerations <- 500
initPrey <- 100     # initial prey abundance
initPred <- 10      # initial predator abundance
a <- 0.01       # attack rate
r <- 0.2        # growth rate of prey
m <- 0.05       # mortality rate of predators
k <- 0.1        # conversion constant of prey into predators

## Create a 'time' vector, and make two additional vectors to store results in
## one for values of n over time, and one for values of p
time <- seq(1, totalGenerations)
n <- rep(initPrey, totalGenerations)
p <- rep(initPred, totalGenerations)
## Write a loop that impliments the calculations

for( t in 2:length(time) ) {
  n[t] <- n[t-1] + (r * n[t-1]) - (a * n[t-1] * p[t-1])
  p[t] <- p[t-1] + (k * a * n[t-1] * p[t-1]) - (m * p[t-1])
}
head(n)
head(p)


## add some if statements to check for negative numbers for each generation
## A negative value of prey abundance should be set to zero

for( t in 2:length(time) ) {
  n[t] <- n[t-1] + (r * n[t-1]) - (a * n[t-1] * p[t-1])
  p[t] <- p[t-1] + (k * a * n[t-1] * p[t-1]) - (m * p[t-1])
  if( n[t] < 0 )
  n[t] <- 0
  if( p[t] < 0 )
  p[t] <- 0
}

plot(p,n)

plot(time, n)
lines(time, p)
