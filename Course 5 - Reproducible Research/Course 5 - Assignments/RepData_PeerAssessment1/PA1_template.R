setwd("D:/GitHub/RepData_PeerAssessment1")
# unzip("activity.zip")

# 1. code for reading in the dataset and/or processing the data
df <- read.csv("activity.csv", header = TRUE, sep = ",")

library(lubridate)
df$date <- ymd(df$date)

library(dplyr)
dates <- group_by(df, date)
steps.sum.date <- summarize(dates, steps = sum(steps, na.rm = TRUE))


# 2. histogram of total number of steps taken each day
hist(steps.sum.date$steps, breaks = 5, main = "Total steps per day", xlab = "Steps")


# 3. mean and median number of steps taken each day
mean(steps.sum.date$steps)
median(steps.sum.date$steps)


# 4. time series plot of the average number of steps taken
itvs <- group_by(df, interval)
steps.avg.itv <- summarize(itvs, steps= mean(steps, na.rm = TRUE))
plot(steps.avg.itv$interval, steps.avg.itv$steps, type="l", 
     main = "Average number of steps taken during intervals", 
     xlab = "5-minute interval", ylab = "Average number of steps")


# 5. the 5-minute interval that, on average, contains the maximum number of steps
max_steps <- steps.avg.itv[which.max(steps.avg.itv$steps),]


# 6. code to describe and show a strategy for imputing missing data
# mean steps of date
itv.mean <- function(itv){
   steps.avg.itv[steps.avg.itv$interval == itv,"steps"]
}

# create a new dataset that is equal to the original dataset but with the missing data filled in.
dff <- df
for (i in 1:nrow(dff)) {
   if (is.na(dff[i,"steps"])) {
      dff[i,"steps"] <- ceiling(itv.mean(dff[i,"interval"]))
   }
}


# 7. histogram of the total number of steps taken each day after missing values are imputed
# group dataset by date
dates <- group_by(dff, date)

# sum of steps by dates
steps.sum.date <- summarize(dates, steps = sum(steps, na.rm = TRUE))

# histogram 
hist(steps.sum.date$steps, breaks = 5, main = "Total steps per day", xlab = "Steps")


# 8. panel plot comparing the average number of steps taken per 5-minute interval across weekdays and weekends
# create new variable of weekday
dff$weekday <- factor(weekdays(dff$date)) # weekdays

# create new variable of isweekend
dff <- mutate(dff, isweekend = factor(weekday %in% c("Saturday", "Sunday"), levels = c(TRUE, FALSE), labels = c("weekends","weekdays")))

# sum of steps on interval separated by date type
steps.itv.date_type = aggregate(steps ~ interval + isweekend, dff, mean)

# draw two graphs separated by date type 
library(ggplot2)
g <- ggplot(steps.itv.date_type, aes(interval, steps))
g +  facet_grid(. ~ isweekend) + geom_line(linetype = "solid")

#geom_point(size = 0.2) +
# 9. all of the R code needed to reproduce the results (numbers, plots, etc.) in the report
