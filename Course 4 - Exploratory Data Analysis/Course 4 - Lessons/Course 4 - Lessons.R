#################### WEEK 1 ####################
########## LESSONS ##########
##### graphs - principles of analytic graphics 
# principal 1: show comparisons
# principal 2: show causality, mechanism, explanation, systematic structure
# principal 3: show mutivariate data 
# principal 4: integration of evidence - words, numbers, images, diagrams; don't let the tool drive the analysis; 
#              as information rich as possible; the strength of the evidence
# principal 5: describe and document the evidence - with appropriate labels, scales, sources, etc; 
#              a data graphic should tell a complete story that is credible
# principal 6: content is king - what the best way to present


##### graphs - exploratory graphs
# graphs, why? 
# 1. understand the data/dataset; 
# 2. find patterns; 
# 3. suggest modeling strategies; 
# 4. debug analyses; 
# 5. communicate results

# simple summaries of data - one dimension 
# 1. five-number summary
# 2. boxplots
# 3. histograms
# 4. density plot 
# 5. barplot

# simple summaries of data - two dimensions
# lattice/ggplot2
# scatterplots 


##### plotting - plotting systems in R  
# 3 core plotting systems: base plotting system, lattice system, 
# 1. base plotting system 
dev.off()
library(datasets)
data(cars)
#par("mar"); par(mar=c(1,1,1,1))
with(cars, plot(speed, dist))

# 2. lattice system 
library(lattice)
state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4,1))

# 3. ggplot2 
library(ggplot2)
data(mpg)
qplot(displ, hwy, data = mpg)


##### plotting - base plotting system
library(datasets)
with(airquality, plot(Wind, Ozone))
title(main = "Ozone and Wind in New York city") ## Add a title

# color
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in the New York city"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))

# add legend
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in the New York city", type = "n"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = "red"))
legend("topright", pch = 1, col = c("blue", "red"), legend = c("May", "Other Months"))

# regression line 
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in the New York city", pch = 20))
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd = 2)

# multiple base plots
par(mfrow = c(1,2))  # 
with(airquality, {
   plot(Wind, Ozone, main = "Ozone and Wind")
   plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
})

par(mfrow = c(1,3), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(airquality, {
   plot(Wind, Ozone, main = "Ozone and Wind")
   plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
   plot(Temp, Ozone, main = "Ozone and Temporature")
   mtext("Ozone and Weather in New York City", outer = TRUE)
})


##### plotting - base plotting demontration 
# mar, pch, 
par(mfrow = c(1,1))  
x <- rnorm(100)
hist(x)
y <- rnorm(100)
plot(x,y)
par(mar = c(2, 2, 2, 2))
plot(x,y)
par(mar = c(4, 4, 2, 2))
plot(x, y, pch = 20)
plot(x, y, pch = 19)
plot(x, y, pch = 2)
plot(x, y, pch = 3)
example(points)

# draw by adding each of elements
x <- rnorm(100)
y <- rnorm(100)
plot(x, y, pch = 20)
title("Scatterplot")
text(-2, -2, "Lable")
legend("topleft", legend = "Data")
legend("topleft", legend = "Data", pch = 20)
fit <- lm(y ~ x)
abline(fit)
abline(fit, lwd = 3)
abline(fit, lwd = 3, col = "blue")

# by more arguments
plot(x, y, xlab = "Weight", ylab = "Height", main = "Scatterplot", pch = 20)
legend("topright", legend = "Data", pch = 20)
fit <- lm(y ~ x)
abline(fit, lwd = 3, col = "red")
# two graphs in a col
z <- rpois(100, 2)
par(mfrow = c(2, 1))
plot(x, y, pch = 20)
plot(x, z, pch = 19)
par("mar")
par(mar = c(2, 2, 1, 1))
plot(x, y, pch = 20)
plot(x, z, pch = 19)
# two graphs in a row
par(mfrow = c(1, 2))
plot(x, y, pch = 20)
plot(x, z, pch = 19)

# categories
par(mfrow = c(1,1))
x <- rnorm(100)
y <- x + rnorm(100)
g <- gl(2, 50)
g <- gl(2, 50, labels = c("Male", "Female"))
g
str(g)
plot(x, y)

plot(x, y, type = "n")
points(x[g == "Male"], y[g == "Male"], col = "green", pch = 3)  # first 50 points are male
points(x[g == "Female"], y[g == "Female"], col = "blue") # final 50 points are female
points(x[g == "Female"], y[g == "Female"], col = "blue", pch = 19)


##### graphics devices in R
# vector device: pdf, svg, win.metafile, postscript
# bitmap device: png, jpeg, tiff, bmp 

library(datasets)
with(faithful, plot(eruptions, waiting))
title(main = "Old Faithful Geyser data")

# send a graph to pdf file
setwd("D:/GitHub/Coursera/Course 4 - Exploratory Data Analysis/Course 4 - Lessons")
pdf(file = "myplot.pdf")
with(faithful, plot(eruptions, waiting))
title(main = "Old Faithful Geyser data")
dev.off()  # explicitly close graphics device, very important 

# multiple open graphics devices
#dev.cur(), dev.set(<integer>)

# copy plots 
library(datasets)
with(faithful, plot(eruptions, waiting))
title(main = "Old Faithful Geyser data")
dev.copy(png, file = "geyserplot.png")
#dev.copy2pdf("geyserplot.pdf", out.type = "pdf")
dev.off()



########## SWIRL ##########
### principals of analytic graphs  
# Simpson's paradox
# exploratory graphs are the initial step in an investigation
# quantile()

### graphics devices in R 




#################### WEEK 2 ####################
########## LESSONS ##########
##### lattice plotting system
# xyplot, bwplot, histogram, stripplot, dotplot, splom, levelplot & contourplot
# xyplot for creating scatterplots, bwplot for box-and-whiskers plots or boxplots
library(lattice)
library(datasets)

# simple scatterplot
xyplot(Ozone ~ Wind, data = airquality)

# convert month to a factor variable 
airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5,1))

# lattice behavior - it saves graphs to trellis object
p <- xyplot(Ozone ~ Wind, data = airquality)  # Nothing happens
print(p)  # plot appear

# lattice panel functions
set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f * x + rnorm(100, sd = 0.5)
f <- factor(f, labels = c("Group1", "Group2"))
xyplot(y ~ x | f, layout = c(2, 1)) # plot with 2 panels


# custom panel function 
xyplot(y ~ x| f, panel = function(x, y, ...){
   panel.xyplot(x, y, ...)
   panel.abline(h = median(y), lty = 2)   # dash line for lty = 2
})

xyplot(y ~ x| f, panel = function(x, y, ...){
   panel.xyplot(x, y, ...)
   panel.lmline(x, y, col = 2)   #  regression line
})


##### ggplot2 plotting system
# ggplot2.org
# qplot(), ggplot()
# basic components: data frame, aesthetic mappings, geoms, facets, stats, scales, coordinate system
# (1) plot the data  (2) overlay a summary  (3) metadata and annotation
library(ggplot2)
str(mpg)
qplot(displ, hwy, data = mpg, color = drv)
qplot(displ, hwy, data = mpg, geom = c("point", "smooth"))
#histogram
qplot(hwy, data = mpg, fill = drv)
#facet
qplot(displ, hwy, data = mpg, facets = .~drv)
qplot(hwy, data = mpg, facets = drv~., binwidth = 2)

# maacs data
setwd("D:/GitHub/DataScience/Course 4 - Exploratory Data Analysis/Course 4 - Lessons")
load(file = "maacs.rda")
str(maacs)
qplot(log(eno), data = maacs)
qplot(log(eno), data = maacs, fill = mopos)
qplot(log(eno), data = maacs, geom = "density")
qplot(log(eno), data = maacs, geom = "density", color = mopos)

# scatterplots eNo & PM25
qplot(log(pm25), log(eno), data = maacs)
qplot(log(pm25), log(eno), data = maacs, shape = mopos)
qplot(log(pm25), log(eno), data = maacs, color = mopos)
qplot(log(pm25), log(eno), data = maacs, color = mopos) + geom_smooth(method = "lm")
qplot(log(pm25), log(eno), data = maacs, facets = .~ mopos) + geom_smooth(method = "lm")

# more ~ dseudo
qplot(log(pm25), NocturnalSympt, data = maacs, facets = . ~ bmicat, geom = c("point", "smooth"), 
      method = "lm")

g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
p <- g + geom_point() + geom_smooth()
p <- g + geom_point() + geom_smooth(method = "lm")
p <- g + geom_point() + geom_smooth(method = "lm") + facets_grid(. ~ bmicat)

# annotation: xlab(), ylab(), labs(), ggtitle(), theme(), theme_gray(), theme_bw()
# modifying aesthetics 
g + geom_point(color = "steelblue", size = 4, alpha = 1/2)
g + geom_point(aes(color = bmicat), size = 4, alpha = 1/2)

# modifying labels 
g + geom_point(aes(color = bmicat)) + labs(title = "MAACS Cohort") + 
   labs(x = "log", y = "Nocturnal Symptoms")

# customizing the smooth
g + geom_point(aes(color = bmicat), size = 2, alpha = 1/2) + 
   geom_smooth(size = 4, linetype = 3, method = lm, se = FALSE)

# change the theme
g + geom_point(aes(color = bmicat)) + theme_bw(base_family = "Times")


# axis limit 
testdat <- data.frame(x = 1:100, y = rnorm(100))
testdat[50, 2] <- 100
plot(testdat$x, testdat$y, type = "l", ylim = c(-3,3))
g <- ggplot(testdat, aes(x = x, y = y))
g + geom_line() + ylim(-3, 3 )  # remove the outlier
g + geom_line() + coord_cartesian(ylim = c(-3, 3))  # include the outlier

## final plot 
# setup ggplot with data frame
g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
# add layers
g  + geom_point(alpha = 1/3)
   + facet_wrap(bmicat ~ no2dec, nrow = 2, ncol = 4)
   + geom_smooth(method = "lm", se = FALSE, col = "steelblue")
   + theme_bw(base_family = "Avenir", base_size = 10)
   + labs(x = expression("log" * PM[2.5]))
   + labs(y = "Noctural Symptoms")
   + labs(title = "MAACS Cohort")
 



########## SWIRL ##########


##### colors
pal <- colorRamp(c("red", "blue"))
pal(0)   # 0 -> 1 (RGB: red green blue)


##### ggplot2 
# ggplot2 plots are composed of aesthetics (attributes such as size, shape, color) 
# and geoms (points, lines, and bars)

## qplot - quick plot 
# scatterplot
qplot(displ, hwy, data = mpg, color = drv, geom = c("point", "smooth"))

# box plot 
qplot(drv, hwy, data = mpg, geom = "boxplot")

# histogram
qplot(hwy, data = mpg, fill = drv)

## ggplot
g <- ggplot(mpg, aes(displ, hwy))
g + geom_point()
g + geom_point() + geom_smooth()
g + geom_point() + geom_smooth(method = "lm")
g + geom_point() + geom_smooth(method = "lm") + facet_grid(. ~ drv)
g + geom_point() + geom_smooth(method = "lm") + facet_grid(. ~ drv) + ggtitle("Swirl Rules!")

g + geom_point(color = "pink", size = 4, alpha = 1/2)
g + geom_point(size = 4, alpha = 1/2, aes(color = drv))
g + geom_point(aes(color = drv)) + labs(title = "Swirl Rules!") + labs(x = "Displacement", y = "Hwy Mileage")
g + geom_point(aes(color = drv), size = 2, alpha = 1/2) + geom_smooth(size = 4, linetype = 3, method = "lm", se = FALSE)

g + geom_point(aes(color = drv)) + theme_bw(base_family = "Times")

# axes limit
g <- ggplot(testdat, aes(x = myx, y = myy))
g + geom_line()
g + geom_line() + ylim(-3, 3)
g + geom_line() + coord_cartesian(ylim = c(-3, 3))

# cars 
g <- ggplot(mpg, aes(x = displ, y = hwy, color = factor(year)))
g + geom_point()
g + geom_point() + facet_grid(drv~cyl, margins = TRUE)  # margins is for totals
g + geom_point() + facet_grid(drv~cyl, margins = TRUE) + geom_smooth(method = "lm", se = FALSE, size = 2, color = "black")
g + geom_point() + facet_grid(drv~cyl, margins = TRUE) + geom_smooth(method = "lm", se = FALSE, size = 2, color = "black") + labs(x = "Displacement", y = "Highway Mileage", title = "Swirl Rules!")


## extras
qplot(carat, price, data = diamonds, color = cut) + geom_smooth(method = "lm")


########## QUIZ ##########

library(nlme)
library(lattice)
xyplot(weight ~ Time | Diet, BodyWeight)


library(lattice)
library(datasets)
data(airquality)
p <- xyplot(Ozone ~ Wind | factor(Month), data = airquality)
class(p)
xyplot(Ozone ~ Wind | factor(Month), data = airquality)


install.packages("ggplot2movies")
library(ggplot2)
library(ggplot2movies)
g <- ggplot(movies, aes(votes, rating))
print(g)








#################### WEEK 3 ####################
########## LESSONS ##########
##### hierarchical clustering 
# clustering organizes things that are close into groups
set.seed(1234)
par(mar = c(0, 0, 0, 0))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1,2,1), each = 4), sd = 0.2)

#plot 
plot(x, y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))

#cluster
dataFrame <- data.frame(x = x, y = y)
distxy <- dist(dataFrame)
hClustering <- hclust(distxy)
plot(hClustering)


##### k-means clustering & 
kmeansObj <- kmeans(dataFrame, centers = 3)
names(kmeansObj)
kmeansObj$cluster
par(mar = rep(0.2, 4))
plot(x, y, col = kmeansObj$cluster, pch = 19, cex = 2)
points(kmeansObj$centers, col = 1:3, pch = 3, cex = 3, lwd = 3)

# heatmap 
set.seed(1234)
dataMatrix <- as.matrix(dataFrame)[sample(1:12), ]
kmeansObj2 <- kmeans(dataMatrix, centers = 3)
par(mfrow = c(1,2), mar = c(2, 4, 0.1, 0.1))
image(t(dataMatrix)[, nrow(dataMatrix):1], yaxt = "n")
image(t(dataMatrix)[, order(kmeansObj2$cluster)], yaxt = "n")


##### dimention reduction 


##### working with color 



########## SWIRL ##########







#################### WEEK 4 ####################
########## CASE STUDY ##########
setwd("D:/GitHub/DataScience/Course 4 - Exploratory Data Analysis/Course 4 - Lessons")
# 1998
pm0 <- read.table("RD_501_88101_1999-0.txt", comment.char = "#", header = FALSE, sep = "|", na.strings = "")
dim(pm0)
head(pm0)
cnames <- readLines("RD_501_88101_1999-0.txt", 1)
cnames
cnames <- strsplit(cnames, "|", fixed = TRUE)
cnames 
names(pm0) <- make.names(cnames[[1]])
x0 <- pm0$Sample.Value 
class(x0)
str(x0)
summary(x0)
mean(is.na(x0))
# 2012
pm1 <- read.table("RD_501_88101_2012-0.txt", comment.char = "#", header = FALSE, sep = "|", na.strings = "")
dim(pm1)
names(pm1) <- make.names(cnames[[1]])
head(pm1)
x1 <- pm1$Sample.Value
str(x1)
mean(is.na(x1))

summary(x1)
summary(x0)

boxplot(x0, x1)
boxplot(log10(x0), log10(x1))

# negative value 
negative <- x1 < 0 
str(negative)
sum(negative, na.rm = TRUE)
mean(negative, na.rm = TRUE)

dates <- pm1$Date
str(dates)
dates <- as.Date(as.character(dates), "%Y%m%d")
hist(dates, "month")
hist(dates[negative], "month")

# sites
site0 <- unique(subset(pm0, State.Code == 36, c(County.Code, Site.ID)))
site1 <- unique(subset(pm1, State.Code == 36, c(County.Code, Site.ID)))
head(site0)
site0 <- paste(site0[, 1], site0[, 2], sep = ".")
site1 <- paste(site1[, 1], site1[, 2], sep = ".")
str(site0)
str(site1)

both <- intersect(site0, site1)
both
pm0$county.site <- with(pm0, paste(County.Code, Site.ID, sep = "."))
pm1$county.site <- with(pm1, paste(County.Code, Site.ID, sep = "."))
cnt0 <- subset(pm0, State.Code == 36 & county.site %in% both)
cnt1 <- subset(pm1, State.Code == 36 & county.site %in% both)
head(cnt0)
split(cnt0, cnt0$county.site)
sapply(split(cnt0, cnt0$county.site), nrow)
sapply(split(cnt1, cnt1$county.site), nrow)
pm1sub <- subset(pm1, State.Code == 36 & County.Code == 63 & Site.ID == 2008)
pm0sub <- subset(pm0, State.Code == 36 & County.Code == 63 & Site.ID == 2008)
dim(pm1sub); dim(pm0sub)

dates1 <- pm1sub$Date
x1sub <- pm1sub$Sample.Value
plot(dates1, x1sub)
dates1 <- as.Date(as.character(dates1), "%Y%m%d")
plot(dates1, x1sub)

dates0 <- pm0sub$Date
dates0 <- as.Date(as.character(dates0), "%Y%m%d")
x0sub <- pm0sub$Sample.Value
plot(dates0, x0sub)
par(mfrow = c(1, 2), mar = c(4, 4, 2, 1))
plot(dates0, x0sub, pch = 20)
abline(h = median(x0sub, na.rm = T))
plot(dates1, x1sub, pch = 20)
abline(h = median(x1sub, na.rm = T))

range(x0sub, x1sub, na.rm = T)
rng <- range(x0sub, x1sub, na.rm = T)
plot(dates0, x0sub, pch = 20, ylim = rng)
abline(h = median(x0sub, na.rm = T))
plot(dates1, x1sub, pch = 20, ylim = rng)
abline(h = median(x1sub, na.rm = T))

# explore changes in each state
mn0 <- with(pm0, tapply(Sample.Value, State.Code, mean, na.rm = T))
str(mn0)
summary(mn0)
mn1 <- with(pm1, tapply(Sample.Value, State.Code, mean, na.rm = T))
summary(mn1)

d0 <- data.frame(state = names(mn0), mean = mn0)
d1 <- data.frame(state = names(mn1), mean = mn1)

mrg <- merge(d0, d1, by = "state")
dim(mrg)
head(mrg)

# plot the states
par(mfrow = c(1,1))
with(mrg, plot(rep(1999, 52), mrg[, 2], xlim = c(1998, 2013)))
with(mrg, points(rep(2012, 52), mrg[, 3]))
segments(rep(1999, 52), mrg[, 2], rep(2012, 52), mrg[, 3])

