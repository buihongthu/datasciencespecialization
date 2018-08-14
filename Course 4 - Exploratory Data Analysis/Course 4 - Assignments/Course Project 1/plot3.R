# read data 
total_data <- read.table("household_power_consumption.txt", header = TRUE, sep=";")

# subset for only two-day data
sub_data <- subset(total_data, 
                   as.Date(as.character(total_data$Date), format="%d/%m/%Y") == as.Date("2007-02-01") |
                      as.Date(as.character(total_data$Date), format="%d/%m/%Y") == as.Date("2007-02-02")
)

# concatenate date and time
dt <- strptime(paste(sub_data$Date, sub_data$Time), "%d/%m/%Y %H:%M:%S")
sub_data <- data.frame(sub_data, dt)

# convert the variable 'sub_metering 1, 2, 3' to numeric
sub_data$Sub_metering_1 <- as.numeric(as.character(sub_data$Sub_metering_1))
sub_data$Sub_metering_2 <- as.numeric(as.character(sub_data$Sub_metering_2))
sub_data$Sub_metering_3 <- as.numeric(as.character(sub_data$Sub_metering_3))

# plot
plot(sub_data$dt , sub_data$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
lines(sub_data$dt, sub_data$Sub_metering_1) 
lines(sub_data$dt, sub_data$Sub_metering_2, col = "red") 
lines(sub_data$dt, sub_data$Sub_metering_3, col = "blue") 

# legends
legend("topright", col = c("black", "blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), 
       lwd = 1, cex = 0.8)

# copy to png 
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()
