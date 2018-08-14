# download data file, for all of 4 plots
data_file <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",data_file)
file <- unzip(data_file)
unlink(data_file)

# read data 
total_data <- read.table("household_power_consumption.txt", header = TRUE, sep=";")

# subset for only two-day data
sub_data <- subset(total_data, 
                   as.Date(as.character(total_data$Date), format="%d/%m/%Y") == as.Date("2007-02-01") |
                      as.Date(as.character(total_data$Date), format="%d/%m/%Y") == as.Date("2007-02-02")
)

# convert the variable 'globar active power' to numeric
sub_data$Global_active_power <- as.numeric(as.character(sub_data$Global_active_power))

# plot
hist(sub_data$Global_active_power, col = "red", 
     main = "Global Active Power", xlab = "Global Active Power(kilowatts)")

# copy to png 
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()