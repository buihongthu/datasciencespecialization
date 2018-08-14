# Assign value to variable 
a <- c("one","two","three")
b <- c("red", "white", "red", NA)
c <- 4+3 
d = as.integer(3) 
e <- "Character example"
f <- sprintf("%s has %d dollars", "Sam", 100) 
g <- c(1,2,3,5,7)
h <- c(a,c)

# Show data
a[2]
b[3]

# Print values
print(a) 
cat(b) 

# Class
class(g)

# Length of vector
length(a)

# Matrix 
A = matrix( c(2, 4, 3, 1, 5, 7), nrow=2, ncol=3, byrow = TRUE) 
A 

# List
# a list is a generic vector containing other objects
x = list(a,b,c) 
x[2]

# Data frame
# data frame is used for storing data tables 
d1 = c(2, 3, 5) 
d2 = c("aa", "bb", "cc") 
d3 = c(TRUE, FALSE, TRUE) 
df = data.frame(n, s, b) 
df

# Excel files
# import data
library(readxl)
products = read_excel("D:/Software Engineering/Coding/R programing/products.xlsx")
products
class(products)

# Distribution
pnorm(84, mean=72, sd=15.2, lower.tail=FALSE) 



### Graphic
x <- rnorm(50)
y <- rnorm(x)
plot(x,y)


### Time series 
# Kings
kings = scan("D:/Software Engineering/Coding/R programing/kings.txt")
ts.kings = ts(kings)
plot.ts(ts.kings)


### Quit RStudio 
q()