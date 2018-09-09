#################### WEEK 1 ####################
########## LESSONS ##########

##### working folder
getwd()
setwd("D:/Software Engineering/Coding/R programing/Course 2 - R programming")
dir()


##### read a file
library(readxl)
read_excel("products.xlsx")


##### customized functions
myfunction <- function() {
   x <- rnorm(100)
   mean(x)
}
myfunction()

second_function <- function(x,y){
   x + y 
}
second_function(1,2)


##### see source of R file 
source("Course 2 - R programming.R")


##### vector
x <- 1:20
x
attributes(x)
class(x)
length(x)


##### vectors & lists: vectors - same kind of objects, lists - different kinds of objects
x <- c(0.5, 0.6)
x[2]

y <- c(1.7, "a")
y <- c(FALSE, 2)


##### matrices
m <- matrix(1:6, nrow = 2, ncol = 3)
m
dim(m)
attributes(m)

m2 <- 1:10
m2
dim(m2) <- c(2,5)
m2

x <- 1:3
y <- 10:12
z <- cbind(x,y)
rbind(x,y)
z[2,"y"]


##### factors: are used to represent categorical data 
x <- factor(c("yes","yes","no","yes","no","na"), levels = c("yes","no","na"))
x
y <- unique(x); y
table(x)
unclass(x)


##### missing values
x <- c(1,NaN,NA,3,4)
is.na(x)
is.nan(x)


##### data frames: are used to store tabular data
row.names()
read.table()
read.csv()
data.matrix()

x <- data.frame(foo = 1:4, bar = c(T,T,F,F), name = c("A","B", "C", "D"))
x[1,"name"]
nrow(x)
ncol(x)


##### names attribute 
x <- 1:3
names(x)
names(x) <- c("foo", "bar", "res")
x


##### interfaces to the outside world
con <- url("http://www.jhsph.edu", "r")
x <- readLines(con)
head(x)


##### subsetting - basics
x <- c("a", "b", "c", "c", "d", "a")
x[1]
x[1:4]
x[x > "b"]

u <- x > "b"
x[u]


##### subsetting - lists
x <- list(foo = 1:4, bar = 0.6, baz = "hello")
x[1]; x[[1]]; 
x$bar; x["bar"]
x[c(1,3)]

x <- list(a = list(10,12,14), b = c(3.14, 2.81))
x[[c(2,1)]]


##### subsetting - matrix 
x <- matrix(1:6, 2, 3)
x
x[1,2]
x[1,]


##### subsetting - dataframe 
x <- subset(data_outcome, data_outcome$State == "TX")
x


##### partial matching
x <- list(aardarw = 1:5)
x$a
x[["a"]]
x[["a", exact = FALSE]]


##### subsetting - removing missing value
x <- c(1, 2, NA, 4, NA, 5)
bad <- is.na(x)
z <- x[!bad]; z

y <- c("a", "b", NA, NA, NA, "f")
good <- complete.cases(x,y)
good; x[good]; y[good]


##### vectorized operations 
x <- 1:4; y <- 6:9
x + y; x * y; x / y 
x >= 2; y ==8

x <- matrix (1:4,2,2); y <- matrix(rep(10,4), 2, 2)
x*y
x/y
x %*% y # true matrix multiplication


########## SWIRL ##########
install.packages("swirl")
packageVersion("swirl")
library(swirl)
install_from_swirl("R Programming")
swirl()










#################### WEEK 2 ####################
########## LESSONS ##########

##### if-else 
x <- 5
y <- if(x>3){
   10 
}else {
   0
}


##### for loop 
for (i in 1:10){
   print(i)
}

x <- c("a", "b", "c", "d")
for(i in 1:4){
   print(x[i])
}
for(letter in x){
   print(letter)
}
for(i in seq_along(x)){
   print(x[i])
}

x <- matrix(1:6, 2, 3)
for(i in seq_len(nrow(x))){
   for(j in seq_len(ncol(x))){
      print(x[i,j])
   }
}


##### while loop
count <- 0 
while(count<10){
   print(count)
   count <- count + 1
}


##### repeat, next, break 
x0 <- 1
tol <- 1e-8
repeat {
   x1 <- computeEstimate()
   if(abs(x1-x0) < tol){
      break
   } else {
      x0 <- x1
   }
}
f

for(i in 1:100){
   if(i<20){
      next
   }
   # do something else
}


##### first R program
add2 <- function(x,y){
   x + y 
}

above10 <- function(x){
   use <- x > 10
   x[use]
}
above10(c(1,3,11))

above <- function(x, n = 10){
   use <- x > n
   x[use]
}
above(c(1,3,11),5)

column_mean <- function(x){
   nc <- ncol(x)
   means <- numeric(nc)
   for(i in 1:nc){
      means[i] <- mean(x[,i])
   }
   means
}  
matrix1 <- matrix(1:6, 2, 3)
column_mean(matrix1)


##### functions - part 1
args(paste)


##### scoping rules - symbol binding
# an environment is a collection of (symbol, value) pairs 
search()


##### scoping rules - R scoping rules
make.power <- function(n){
   pow <- function(x){
      x^n
   }
   pow
}
cube <- make.power(3)
square <- make.power(2)
cube(3)
square(3)

ls(environment(cube))
get("n", environment(cube))
get("pow", environment(cube))

ls(environment(square))
get("n", environment(square))
get("pow", environment(square))

y<-10
f <- function(x){
   y <- 2
   y^2 + g(x)
}
g <- function(x){
   x*y
}
f(3)


##### scoping rules - optimization example
##### coding standards



##### dates and times 
x <- as.Date("1970-01-01")
unclass(x)
unclass(as.Date("1970-01-02"))
# weekdays, months, quarters
x <- Sys.time()
x
p <- as.POSIXlt(x)
names(unclass(p))
p$sec; p$min; p$mon; p$wday; p$yday; p$zone; p$gmtoff

datestring <- c("January 10, 2012 10:40", "December 9, 2011 9:10")
x <- strptime(datestring, "%B %d, %Y %H:%M")
class(x)

x <- as.Date("2012-03-01"); y <- as.Date("2012-02-28")
x-y










#################### WEEK 3 ####################
########## LESSONS ##########

##### lapply: functions on total col
x <- list(a = 1:5, b = rnorm(100,1,1))
lapply(x, mean)

x <- 1:4
lapply(x, runif, min = 3, max = 10)

x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2))
lapply(x, function(elt) elt[,1])

x <- list(a = 1:4, b = rnorm(10), c = rnorm(20,1), d = rnorm(100,5))
l <- lapply(x, mean)
s <- sapply(x, mean)
class(s); class(l)


##### apply: quick do statistics on row or col of a matrix
x <- matrix(rnorm(200), 20, 10)
apply(x, 2, mean) # 1 ~ row, 2 ~ column
apply(x, 2, sum)
# rowSums, rowMeans, colSums, colMeans
apply(x, 1, quantile, probs = c(0.25,0.5,0.75))

a <- array(rnorm(2 * 2 * 10), c(2,2,10))
apply(a, c(1,2), mean)
rowMeans(a,dims = 2)


##### mapply
list(rep(1,4), rep(2,3), rep(3,2), rep(4,1))
mapply(rep, 1:4, 4:1)

noise <- function(n, mean, sd){
   rnorm(n, mean, sd)
}
noise(5, 1, 2)
mapply(noise, 1:5, 1:5, 2)
list(noise(1,1,2), noise(2,2,2), noise(3,3,2), noise(4,4,2), noise(5,5,2))


##### tapply: function on group
x <- c(rnorm(10), runif(10), rnorm(10,1))     # runif(r-unif) ~ generate  
f <- gl(3,10)
t <- tapply(x,f,mean)
tapply(x,f,range)
class(t)


##### split: separate groups by second argument
x <- c(rnorm(10), runif(10), rnorm(10,1))
f <- gl(3,10)
s <- split(x,f)
s[1]; s[2]; s[3]
class(s[1])

# more than 1 level
x <- rnorm(10)
f1 <- gl(2,5)
f2 <- gl(5,2)
interaction(f1,f2)
str(split(x, list(f1,f2)))
str(split(x, list(f1,f2), drop = TRUE))


##### debugging tools - dianosing the problem 
log(-1)


##### debugging tools - basic tools 


##### debugging tools - use the tools 
mean(x)
traceback()

lm(y-x)
traceback()
debug(lm)

options(error = recover)
read.csv("nosuchfile")


########## QUIZ ##########
library(datasets)
data(iris)
head(iris)

tapply(iris$Sepal.Length, iris$Species, mean)

sapply(split(mtcars$mpg, mtcars$cyl), mean)
with(mtcars, tapply(mpg, cyl, mean))
tapply(mtcars$mpg, mtcars$cyl, mean)
tapply(mtcars$hp, mtcars$cyl,mean)



#################### WEEK 4 ####################
########## LESSONS ##########

##### str function: structure, compactly display the contents of the list
str(str)
str(lm)

x <- rnorm(100,2,4)
summary(x)
str(x)

f <- gl(40,10)
f
str(f)

library(datasets)
head(airquality)
str(airquality)

m <- matrix(rnorm(100), 10, 10)
m
str(m)

s <- split(airquality, airquality$Month)
str(s)


##### simulation - generating random numbers
# rnorm, dnorm, pnorm, rpois, ppois
# d for density, r for random number generation, 
# p for cummulative distribution, q for quantile function
x <- rnorm(10, 20, 2)
x
summary(x)

# set.seed to make random number generation reproducible
set.seed(1)
rnorm(5)
set.seed(2)
rnorm(5)
set.seed(1)
rnorm(5)
set.seed(2)
rnorm(5)

# poisson distribution
rpois(10, 1)
rpois(10, 2)
rpois(10, 20)

ppois(2, 2) # Pr(x<=2)
ppois(4, 2) # Pr(x<=4)
ppois(6, 2) # PR(x<=6)


##### simulation - simulating a linear model
set.seed(20)
x <- rnorm(100)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e 
summary(y)
par("mar"); par(mar=c(1,1,1,1))
plot(x,y)

set.seed(10)
x <- rbinom(100, 1, 0.5)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e
summary(y)
plot(x,y)

set.seed(1)
x <- rnorm(100)
log.mu <- 0.5 + 0.3 * x 
y <- rpois(100, exp(log.mu))
summary(y)
plot(x,y)


##### simulation - random sampling 
set.seed(1)
sample(1:10, 4)
sample(1:10, 4)
sample(letters, 5)
sample(1:10)
sample(1:10)
sample(1:10, replace = TRUE)


##### R profiler (part 1)
# profiling is examine how much time spent in different parts of a program 

# elapsed time > user time(CPU)
system.time()
system.time(readLines("http://www.jhsph.edu"))

# elapsed time < user time(CPU)
hilbert <- function(n){
   i <- 1:n
   1 / outer(i - 1, i, "+")
}
x <- hilbert(2000)
system.time(svd(x))   

system.time({
   n <- 1000
   r <- numeric(n)
   for(i in 1:n){
      x <- rnorm(n)
      r[i] <- mean(x)
   }
})


##### R profiler (part 2)
# Pprof() and summaryRProf()
# by.all and by.self

########## SWIRL ##########
# looking at the data
object.size(data) # return the size of the object
names(data) # return the variable name of the data frame
head(data) # see the top of the dataset
tail(data) # see the bottom of the dataset
summary(data)
table(data$field) # to see the categorial variable
str(data)

# base graphics 
# lattice, ggplot2 and ggvis


########## QUIZ ##########
set.seed(1)
rpois(5, 2)

set.seed(10)
x <- rep(0:1, each = 5)
e <- rnorm(10, 0, 20)
y <- 0.5 + 2 * x + e
x


##### programming assignment 3
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
str(outcome)
ncol(outcome)
names(outcome)
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])


