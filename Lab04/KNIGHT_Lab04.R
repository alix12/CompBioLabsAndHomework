### Lab 4
### FOR LOOP LAB

####### PART 1 #################

### Question ONE
### write a for loop that prints the word hi 10 times

for( i in seq(1,10) ){
  print("hi")
}

### Question TWO
### Tim has $10 in his piggy bank. Each week his parents give him $5. 
### He also buys two packs of gum costing $1.34 each (2.68)
### How much money will tim have in 8 weeks? 
### Write a loop that prints to the console
### equation: Y = 10 + 5i -2.68i
## start value
init_piggy <- 10
allowance <- 5
gum <- 1.34

Weeks <- rep(0,8)
for( i in seq(1,8) ) {
  Weeks[i] <- init_piggy + (allowance * i) - ((2*gum) * i)
}
Weeks[8]

### Answer: Tim will have $28.56 in 8 weeks

### Question THREE
### Starting with a population of 2000 individuals
### The population shrinks by 5% each year
### What is the population size each year for the next seven years?
### Equation: (2000 * .95 * t)  
init_pop <- 2000
decline <- 0.95
years <- 7

for( i in 1:years ) {
  Population <- (init_pop * decline)
  print(Population)
  init_pop <- Population
}

### ANSWERs
### 1900
### 1805
### 1714.75
### 1629.012
### 1547.562
### 1470.184
### 1396.675 


### Question FOUR
### discrete-time logistic qrowth equation:
### n[t] = n[t-1] + (r * n[t-1] * (K - n[t-1]) / K)
### n[t] = abundance at time t
### n[t-1] = abundance at time 1 before t
### r = intrinisc growth rate
### K = environmental carrying capacity
### Right now is time 1, t=1
### If n[1] = 2500
### K = 10000
### r = 0.8
### What do you predict for the value of n[12]?


ABUN <- rep(2500,12)
K <- 10000
r <- 0.8

for( i in seq(2,12) ) {
  ABUN[i] <- ABUN[i-1] + (r * (ABUN[i-1])) * ((K - (ABUN[i-1])) / K)
  print(ABUN[i])
}

#######  PART 2 ##############

### Question 1
### 1a. rep 0 18 times
numbers <- rep(0,18)

### 1b. make a for loop that stores 3 times the ith value
for( i in seq(1,18) ) {
  numbers[i] <- i * 3
}
numbers

### 1c.make a new vector of zeros
numbers <- rep(0,18)
### then make the first entry have the value of 1
numbers[1] <- 1
numbers

### 1d. write a for loop that contains the value 1 + 2 * previous entry

for (i in seq(2,18) ) {
  numbers[i] <- 1 + (2 * numbers[i-1])
}
numbers

### Question 2 fibonacci!!!
### make a vector of the first 20 numbers in the fibonacci seq by using a for loop
### equation: value = i-1 + i-2

length_of_fib <- 20
### compatible with whatever lenght of fibonacci sequence for the rest of the code
fib_seq <- rep(1,length_of_fib)

for( i in 2:(length(fib_seq) - 1)) {
  fib_seq[i+1] <- fib_seq[i-1] + fib_seq[i]
}
fib_seq

### Question 3
## Redo question 4 from part 1 :

## but this time store all the data. Make two vectors:
## ("time" - stores the time steps (1-12) and "abundance" 
## - stores the data on pop abundances predicted from the equation) 
## then make a plot of the results.(time, abundances)

Time <- rep(1, 12)
Abundance <-  rep(2500,12)

K <- 10000
r <- 0.8

for( i in seq(2,12) ) {
  Time[i] <- i
  Abundance[i] <- Abundance[i-1] + (r * (Abundance[i-1])) * ((K - (Abundance[i-1])) / K)
  
}
Abundance

plot(Time, Abundance)


### Question 4: CO2!
## make sure you have the .csv and the metadata files!
## Read through the data!! (also make sure to set the directory)

##4a. 
setwd("~/Comp Bio/CompBioLabsAndHomework/Lab04")
carbon <- read.csv("CO2_data_cut_paste.csv")
##4b.
### For each of the quantities, except for year, calculate 
### the % change from year i-1 to year i across all years
### Your results should be stored in a new data frame or matrix.
### to do this efficiently, you may find that you need to use nested for loops

head(carbon)

## assign variables to vectors
Total_carbon <- carbon$Total
gas <- carbon$Gas
liquids <- carbon$Liquids
solids <- carbon$Solids
cement <- carbon$CementProduction
gas_flare <- carbon$gas_flare
per_cap <- carbon$PerCapita

### for total emissions, want a forloop to look like this
delta_total <- rep(0, length(carbon$Year))
for( i in 2:length(carbon$Year)){
  delta_total[i] <- (Total_carbon[i] / Total_carbon[i-1]) * 100
}

### what if i do this for each column head...
carbon_change <- rep(NA, length(carbon$Year))
for (i in 2:length(colnames(carbon))) {
  delta_carbon <- carbon[,i]
  for (j in 2:length(delta_carbon)) {
    carbon_change[j] <- (delta_carbon[j] - delta_carbon[j-1]) * 100
  }
}
carbon_change





##4c. use write.csv() to save your new data frame
### to a file named "YearlyPercentChangesInCO2.csv"





