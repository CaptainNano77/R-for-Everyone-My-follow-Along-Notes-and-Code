#########################################################################################################
#                            ````                 CHAPTER 18
#                                               BASIC STATISTICS
#########################################################################################################
#                                             Summary Statistics: 18.1
#########################################################################################################
# mean
grades <- c(95, 72, 87, 66, 92, 80, 74, 77)

mean(grades)
sd(grades)
# if there were NA values we could add na.rm() to this...
grades2 <- grades
grades2[3] <- NA
grades2
grades
mean(grades2)
mean(grades2, na.rm=TRUE)
sd(grades2, na.rm=TRUE)

#We can also weight the mean...
weight <- c(1/16, 1/8, 1/8, 1/8, 1/16, 1/8, 1/8, 1/8)
weighted.mean(x=grades, y=weight)

#variance
var(grades)

# Standard deviation
# square root of the variance 
sqrt(var(grades))
sd(grades)
sd(grades2)
sd(grades2, na.rm=TRUE)

# min, max, median.
min(grades)
max(grades)
median(grades)
median(grades2, na.rm=TRUE)

# SUMMARY:  'summary()' will give us all of these stats and automatically remove any NAs
summary(grades)
summary(grades2)

# we can also calculate the quantiles individually...
quantile(grades, probs=c(.75, .95))
quantile(grades, probs=c(.25, .5, .75))
quantile(grades2, probs=c(.75, .95), na.rm=TRUE)

#########################################################################################################
#                                     Correlation and Covariance: 18.2
#########################################################################################################
# When dealing with more than one variable, we need to test their relationship with each other. 
library(ggplot2)

head(economics)
cor(economics$pce, economics$psavert)

# correlation plot with GGally
# NOTE!: ggally causes problems with 'reshape2' so instead of loading GGally library, call it with :: operator.
GGally::ggpairs(economics[, c(2,4:6)])

# ggpairs shows the ACTUAL DATA but not the actual CORRELATION
# for this, we need to build a heatmap

#package for melting the data
library(reshape2)
# exta plotting features
library(scales)
# build correlation matrix
econCor <- cor(economics[, c(2, 4:6)])
econCor
# melt the datainto the long format
econMelt <- melt(econCor, varnames=c('x', 'y'), value.name='Correlation')
econMelt
# order it according to the correlation instea
econMelt <- econMelt[order(econMelt$Correlation), ]
econMelt

# now we can plot it (heatmap) using ggplot2
ggplot(econMelt, aes(x=x, y=y))+
  geom_tile(aes(fill=Correlation))+
  scale_fill_gradient2(low=muted('red'), mid='white',
                       high='steelblue',
                       guide=guide_colorbar(ticks=FALSE, barheight=10),
                       limits=c(-1, 1))+
                         theme_minimal()+
                         labs(x=NULL, y=NULL)

# correlation does not mean causation
install.packages('RXKCD')
library(RXKCD)
getXKCD(which='552')

#########################################################################################################
#                                                T-Tests: 18.3
#########################################################################################################
head(tips)

unique(tips$sex)
unique(tips$day)

#                                              One-Sample T-Test
# Measuring a single sample
t.test(tips$tip, alternative='two.sided', mu=2.50)

# plot
randT <-rt(30000, df=NROW(tips)-1)
tipTest <- t.test(tips$tip, alternative='two.sided', mu=2.50)

library(ggplot2)
ggplot(data.frame(x=randT)) +
  geom_density(aes(x=x), fill='grey', color='grey') +
  geom_vline(xintercept=tipTest$statistic) +
  geom_vline(xintercept=mean(randT) + c(-2, 2) * sd(randT), linetype=2)

#next we conduct a one-sided t-test
t.test(tips$tip, alternative='greater', mu=2.50)

#                                           Two-Sample T-test
# More often, we want a t-test to compare 2 samples. So, we'll compare how male and female diners tip.
# Before running the t-test, we first need to check the variance of each sample. 
# A traditional t-test requires both samples have the same (equal) variance. 

# calculating variance of each sample (sex)
aggregate(tip ~ sex, data=tips, var)
# now test for normality of tip distribution...
shapiro.test(tips$tip)
shapiro.test(tips$tip[tips$sex == 'Female'])
shapiro.test(tips$tip[tips$sex == 'Male'])
# all the tsts fail so inspect visually
ggplot(tips, aes(x=tip, fill=sex))+
  geom_histogram(binwidth=.5, alpha=1/2)

ansari.test(tip ~ sex, tips)
# this indicates that the variances are equal, meaning we can use the standard two-sample t-test

t.test(tip ~ sex, data=tips, var.equal=TRUE)
# according to the test, the results were NOT significant and we should conclude that femal and male diners tip equally

# a simple way to prove this is to see if the 2 means are within 2 standard deviations of each other...
library(plyr)
tipSummary <- ddply(tips, 'sex', summarize,
                    tip.mean=mean(tip), tip.sd=sd(tip),
                    Lower=tip.mean - 2*tip.sd/sqrt(NROW(tip)),
                    Upper=tip.mean + 2*tip.sd/sqrt(NROW(tip)))
tipSummary

ggplot(tipSummary, aes(x=tip.mean, y=sex)) +
  geom_point() +
  geom_errorbarh(aes(xmin=Lower, xmax=Upper), height=0.2)

#                                           Paired Two-Sample T-Test
#
# For testing paired data (for example measurements on twins, before and after treatment, or father/son comparisons)
# a PAIRED t-test should be used.
install.packages('UsingR')
data(father.son, package='UsingR')
head(father.son)

t.test(father.son$fheight, father.son$sheight, paired=TRUE)
# this test shows that we should reject the null hypothesis and conclude that fathers and sons have different heights.

#########################################################################################################
#                                               ANOVA: 18.4
#########################################################################################################
#
# After comparing 2 groups, the logical next step is comparing MULTIPLE groups
# This is rarely used but here it is..
tipAnova <- aov(tip ~ day -1, tips)

tipIntercept <- aov(tip ~ day, tips)
tipAnova$coefficients
summary(tipAnova)
