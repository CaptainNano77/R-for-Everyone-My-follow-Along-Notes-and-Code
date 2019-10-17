#########################################################################################################
#                                              CHAPTER 17
#                                      PROBABILITY DISTRIBUTIONS
#########################################################################################################
#                            ````       Normal Distribution: 17.1
#########################################################################################################
# Normal (Gaussian) distribution
# A normal distribution in a variate X with mean mu and variance sigma^2 is a statistic distribution with probability density function
# P(x)=1/(sigmasqrt(2pi))e^(-(x-mu)^2/(2sigma^2)) 
# use 'rnorm' function to draw random numbers from the normal distribution
rnorm(n=10)

rnorm(n=10, mean=100, sd=20)

# the DENSITY (probability of a particular value) for normal dist. is calculated with 'dnorm'
# dnomr is for probablity of a SPECIFIC number occuring
randNorm10 <- rnorm(10)
randNorm10

dnorm(c(-1, 0, 1))

# to visualize, we 1) generate normal random variables, 2) calculate their distributions, 3) plot
randNorm <- rnorm(30000)
randDensity <- dnorm(randNorm)
library(ggplot2)
ggplot(data.frame(x=randNorm, y=randDensity)) +
  aes(x=x, y=y) +
  geom_point() +
  labs(x='Random Normal Variables', y='Density')

# 'pnorm' calculate the distribution of the normal distribution, that is, the cumulative probability that
# a given #, or smaller, occurs. 
# 'pnorm' is for probability of a SPECIFIC number or SMALLER occuring.
pnorm(randNorm10)

pnorm(c(-3, 0, 3))
pnorm(-1)
# to find probability that the variable FALLS BETWEEN TOW POINTS, we must calculate the two probabilities
# and subtract them from each other.
pnorm(1) - pnorm(0)
pnorm(1) - pnorm(-1)
# this probability is represented by the AREA UNDER THE CURVE which is visualized with the following code...
p <- ggplot(data.frame(x=randNorm, y=randDensity)) +
  aes(x=x, y=y) +
  geom_line() +
  labs(x='x', y='Density')
p
# to create a shaded area under the curve...
# generate a sequence of numbers going from far left to -1
neg1Seq <- seq(from=min(randNorm), to=-1, by=.1)
#build a data.frame of that sequence as x
lessThanNeg1 <- data.frame(x=neg1Seq, y=dnorm(neg1seq))
head(lessThanNeg1)

# combine with sequences of far right...
lessThanNeg1 <- rbind(c(min(randNorm), 0),
                      lessThanNeg1, 
                      c(max(lessThanNeg1$x), 0))
# use that shaded region as a polygon
p + geom_polygon(data=lessThanNeg1, aes(x=x, y=y))

#qnorm will show the quantile instead

#########################################################################################################
#                            ````       Binomial Distribution: 17.2
#########################################################################################################
# the number of trials (n), proability of success of a trial (p), mean = np, variance = np(1-p).
# Random # generation: Actually generating the # of successes of independent trials.

# to simulate the # of successes out of 10 trials with a probability of 0.4 of success, we can run rbinom
# with n=1 (only 1 run of each trial) and size=10 (trial size = 10) and prob=0.4. 
rbinom(n=1, size=10, prob=0.4)
# can also use pbinorm and qbinorm for density and quantiles

#########################################################################################################
#                            ````       Poisson Distribution: 17.3
#########################################################################################################
# Used for COUNT data
rpois(n=100, lambda=1)

#           PAGE 239-240 OF CHAPTER 17 HAS A LIST OF ALL DISTRIBUTIONS AND EQUATIONS 
#           FOR THESES AND MANY OTHERS!!!!!









