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

Weeks <- rep(0,8)
for( i in seq(1,8) ) {
  Weeks <- 10 + (5 * i) - (2.68 * i)
  print(Weeks)
}

### Answer: Tim will have $28.56 in 8 weeks

### Question THREE
### Starting with a population of 2000 individuals
### The population shrinks by 5% each year
### What is the population size each year for the next seven years?
### Equation: 2000 - ((2000 * 0.05) * t)  
init_pop <- 2000
Population <- rep(0,7)
for( i in seq(0,7)) {
  Population <- 2000 - ((init_pop * 0.05) * i)
  print(Population)
}

### ANSWER
###0 2000
###1 1900
###2 1800
###3 1700
###4 1600
###5 1500
###6 1400
###7 1300

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

fib_seq <- rep(1,20)

for( i in 2:20) {
  fib_seq[i+1] <- fib_seq[i-1] + fib_seq[i]
}
fib_seq

















