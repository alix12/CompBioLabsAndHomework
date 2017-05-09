## Lab 11: Generating Pseudo-Random Numbers and Samples


## A. the Binomial Distribution
##    Appropriate when you want to describe the outcome of an "either or" process.
##    e.g. for some number of chances, the binomial distribution describes the number of times that one outcome (or its alternative) is expected.
##    one out come is commonly known as the "success"
##    can use to describe things such as (i) the number of heads obtained when flipping a coin
##    (ii) the number of people for whom a vaccination will be effective
##    (iii) or the number of students who will graduate within four years in a group of first year students.
##    key features of these examples:
###     (i) each outcome must be independent of all other outcomes (e.g., each coin flip is independent of the others; each student's success is independent of the other students'), 
###     (ii) there is some probability, p, of "success" in each example, and this same probability applies to all individuals (the definition of "success" can be arbitrary), and 
###     (iii) there is some known, fixed, integer number of chances/individuals (i.e., the number of coin flips or the number of students).

## for R, use rbinom(n, size, prob) where  n = simulate instance, size = number of trials, prob = the probability of outcome.


## A1. Try the commands rbinom(n = 8, size = 10, prob = 0.5) # simulating 10 coin flips (8 times) and rbinom(n = 1, size = 10, prob = 0.5) # simulating 10 coin flips (once)

rbinom(n = 1, size = 10, prob = 0.5) # simulating 10 coin flips (once)

## outcome: 3 (got tails three times out of ten with the .5 probability)

rbinom(n = 8, size = 10, prob = 0.5) # simulating 10 coin flips (8 times)

## outcome: 6, 7, 5, 3, 3, 5, 6, 4

### For the next three problems, suppose the probability of getting the flu is 40% if you don't get the vaccine, and 15% if you do get the vaccine

## A2. In an R script, write a line of code that would simulate the number of people who get the flu in a sample of 20 vaccinated people

rbinom(n = 1, size = 20, prob = 0.15)
## result = 2
## two people still got the flu

## A3.  In the same R script, write a line of code that would simulate the number of people who get the flu in a sample of 20 unvaccinated people.
rbinom(n = 1, size = 20, prob = 0.4)
## result = 6 people got the flu

## A4. write a line of code that would create 30 replicates of the scenario described in A2, replicates of A3, and make frequency histograms of the outcomes of each.
## from A2
freqA2 <- rbinom(n = 30, size = 20, prob = 0.15)
hist(freqA2, xlab = "Number of Individuals with the flu", ylab = "Freq of the number of individuals with the flu")
## from A3
freqA3 <- rbinom(n = 30, size = 20, prob = 0.4)
hist(freqA3, xlab = "Number of Individuals with the flu", ylab = "Freq of the number of individuals with the flu")
## Comparing these two histograms, does anything surprise you about them?
## I'm not sure what I should be expecting, however, the first one isn't very normally distributed, while the second one is. That could be that the number of successes is greater... Not sure.



## A5. if you have a pop of N = 500, with a fixed size in each generation, and generations are non-overlapping, suppose that individuals are haploid, and that at a given (focal) locas
##      there are two alleles currently in the population. At some initial time point, one allele is present in 275 (55%) of the individuals, and thus the other allele is present in 45% of the individuals.
##      Let's call the more common allele a and the less common one allele b. Assuming that the two alleles are neutral, simulate going forward one generation time.
##      What is the frequency of the a allele in the next generation?
rbinom(n = 1, size = 500, prob = 0.55)
## n = 1 because only simulating next generation (fixed population of 500)
## Size = 500, because that is the fixed population size.
## prob = 0.55 because 55% of the population is expexted to have allele a
## result = 251

## A6. using information from A5, start from the same initial conditions, but go forward 1000 generations
Freq_Allele_a <- rep(275, 1000)
Generation <- 1000
pop_size <- 500

for (i in 1:Generation) {
  Allele_a[i+1] <- rbinom(n = 1, size = pop_size, prob = (Allele_a[i]/pop_size))
}
Allele_a

## A7. plot results from A6.
plot(Allele_a, type = "l", ylab = "Frequency of Allele a", xlab = "Generation")

## A8. Write additional code to create 100 replicates
## of the simulation in A6. Using the results from your
## 100 replicates, write code to (i) plot 10 replicates
## on one figure, (ii) determine how many replicates 
## ended with the a allele fixed, (iii) determine how
## many replicates ended with the b allele fixed, and
## (iv) determine how many replicates ended with both
## alleles still present in the population.

model_rep <- matrix(NA, 1000, 100)
model_rep[,1] <- 275

for (j in 1:100) {
  for (i in 1:(Generation-1)) {
    model_rep[j, i+1] <- rbinom(n = 1, size = pop_size, prob = (model_rep[j, i]/pop_size))
  }
}






