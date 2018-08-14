### Question 1 - total emissions from PM2.5 decreased in the United States from 1999 to 2008

# download data files only one times for all of plots
data_file <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",data_file)
file <- unzip(data_file)
unlink(data_file)

# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# sum emissions by years
sum.emis <- with(NEI, tapply(Emissions, year, sum)); 

# create dataframe of years and emissions in kilotons
df <- data.frame(year = names(sum.emis), emis = sum.emis/1000)

# barplot
bar <- barplot(df$emis, names.arg = df$year, 
               main = "Total Emissions in The US (ktons)", 
               xlab = "Year", 
               ylab = expression("PM"[2.5]*" emissions (ktons)"), 
               space = 0.3)

# add values to bars
text(x = bar, y = df$emis/2, label = format(round(df$emis,2), big.mark =","), pos = 3, cex = 0.75, col = "blue")

# copy to png 
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()