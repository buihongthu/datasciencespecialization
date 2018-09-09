#################### WEEK 1 ####################

########## LESSONS ##########
# about probability & Expected Values

##### probability   
x <- c(-0.5, 0, 1, 1, 1.5)
y <- c(0, 0, 2, 0, 0)
plot(x, y, lwd = 3, frame = FALSE, type = "l")
pbeta(0.75, 2, 1)
qbeta(0.5, 2, 1)



#################### WEEK 2 ####################
##### variability
nosim <- 1000
n <- 10 
sd(apply(matrix(runif(nosim * n), nosim), 1, mean))

1/sqrt(12 * n)


##### distribution 
### Bernoulli distribution

### Poison distribution
pbinom(2, size = 500, prob = 0.01)
ppois(2, lambda = 500 * 0.01)


##### QUIZ
qnorm(0.95,1100, 75/10)
pbinom(4, size=5, prob=0.5, lower.tail = FALSE) 

p <- 0.5
n <- 5
quantile <- 3 # 4 or 5 out of 5, with lower
probPercentage1 <- round(pbinom(quantile, size=n, prob=p, lower.tail = FALSE) * 100)
probPercentage1

ppois(10, 5 * 3)


#################### WEEK 3 ####################
##### 
install.packages("UsingR")
library(UsingR)
data(father.son)
t.test(father.son$sheight - father.son$fheight)

##### P value 
# p-value 
pt(2.5, 15, lower.tail = FALSE)   # t = 2.5, df = 15
# when p value is really small, ~ 0.01, we can say either the null hypothesis is true and 
# we've seen an exceptionally large T statistic, or the nyll hypothesis is false. 

choose(8,7) * 0.5^8 + choose(8,8) * 0.5^8
pbinom(6, size = 8, prob = 0.5)
pbinom(6, size = 8, prob = 0.5, lower.tail = FALSE)

# p value for normal distribution 
# lower.tail = TRUE is all the left, lower.tail = FALSE is on the right extreme / upper tail 
pnorm(1.96, lower.tail = TRUE)
qnorm(0.025, lower.tail = FALSE)

# p value for poisson distribution 
ppois(5, 5, lower.tail = FALSE)

?ppois



##### QUIZ
# question 1
1100 + qt(c(.025, .975), df = 9 - 1) * 30 / sqrt(9)

n2 <- 9
mean2 <- -2
sd2 <- 2*sqrt(n2)/qt(0.975,n2-1) #is 95% with 2.5% on both sides of the range
sd2

# question 4
quantile<- 0.975 
# is 95% with 2.5% on both sides of the range
n_y <- 10 # nights new system
n_x <- 10 # nights old system
var_y <- 0.60 # variance new (sqrt of ??)
var_x <- 0.68 # variance old (sqrt of ??)
mean_y <- 3# average hours new system
mean_x <- 5# average hours old system
# calculate pooled standard deviation
mean_p <- sqrt(((n_x - 1) * var_x + (n_y - 1) * var_y)/(n_x + n_y - 2))
confidenceInterval <- mean_y - mean_x + c(-1, 1) * qt(quantile, df=n_y+n_x-2) * mean_p * (1 / n_x + 1 / n_y)^.5
round(confidenceInterval,2)

# 


#################### WEEK 4 ####################
##### power 
z <- qnorm(1 - alpha)

##### bootstrapping
# methods of using the existing samples to construct a new set of samples (length of bootstrap) with 
# each of new value is the average of existing values
library(UsingR)
data(father.son)
x <- father.son$sheight
n <- length(x)
B <- 10000
resamples <- matrix(sample(x, n * B, replace = TRUE), B, n)
resampledMedians <- apply(resamples, 1, median)

str(resamples)
str(resampledMedians)

sd(x)
sd(resampledMedians)

# plot 
g <- ggplot(data.frame(medians = resampledMedians), aes(x = medians))
g <- g + geom_histogram(color = "black", fill = "lightblue", binwidth = 0.05)
g



##### permutation test 
