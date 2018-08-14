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

# convert the variables to numeric type
sub_data$Global_active_power <- as.numeric(as.character(sub_data$Global_active_power))
sub_data$Voltage <- as.numeric(as.character(sub_data$Voltage))
sub_data$Sub_metering_1 <- as.numeric(as.character(sub_data$Sub_metering_1))
sub_data$Sub_metering_2 <- as.numeric(as.character(sub_data$Sub_metering_2))
sub_data$Sub_metering_3 <- as.numeric(as.character(sub_data$Sub_metering_3))
sub_data$Global_reactive_power <- as.numeric(as.character(sub_data$Global_reactive_power))

# prepare for 4 graphs 
par(mfrow=c(2,2))

# 1st graph 
plot(sub_data$dt, sub_data$Global_active_power, 
     xlab = "", ylab = "Global Active Power",  type = "n")
lines(sub_data$dt, sub_data$Global_active_power)

# 2nd grahp
plot(sub_data$dt, sub_data$Voltage, 
     xlab = "datetime", ylab = "Voltage",  type = "n")
lines(sub_data$dt, sub_data$Voltage)

# 3rd graph
plot(sub_data$dt , sub_data$Sub_metering_1, xlab = "", ylab = "Energy sub metering",  
     ylim = c(0,40), type = "n")
lines(sub_data$dt, sub_data$Sub_metering_1) 
lines(sub_data$dt, sub_data$Sub_metering_2, col = "red") 
lines(sub_data$dt, sub_data$Sub_metering_3, col = "blue") 

legend("topright", col = c("black", "blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), 
       bty = "n", lwd = 1, cex = 0.7)

# 4th graph  
plot(sub_data$dt, sub_data$Global_reactive_power, 
     xlab = "datetime", ylab = "Global_reactive_power",  type = "n")
lines(sub_data$dt, sub_data$Global_reactive_power)

# copy to png 
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()
