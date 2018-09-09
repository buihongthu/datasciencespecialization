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
# lower.tail = TRUE is all the left, lower.tail = FALSE is on the right extreme
pnorm(1.96, lower.tail = TRUE)
qnorm(0.025, lower.tail = FALSE)

