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

# convert the variable 'globar active power' to numeric
sub_data$Global_active_power <- as.numeric(as.character(sub_data$Global_active_power))

# plot 
plot(sub_data$dt, sub_data$Global_active_power, 
     xlab = "", ylab = "Global Active Power (kilowatts)",  type = "n")
lines(sub_data$dt, sub_data$Global_active_power) 

# copy to png 
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()