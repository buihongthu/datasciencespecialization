### Question 2 -  total emissions from PM2.5 in the Baltimore City, Maryland from 1999 to 2008

# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# sub dataframe of Baltimore City
sdf <- subset(NEI, fips == "24510")

# sum emissions in Baltimore by year 
sum.emis <- with(sdf, tapply(Emissions, year, sum))

# create dataframe of year and emissions in kilotons in Baltimore  
df <- data.frame(year = names(sum.emis), emis = sum.emis/1000)

# barplot 
bar <- barplot(df$emis, names.arg = df$year, 
               main = "Emissions in Baltimore City, Maryland (ktons)", 
               xlab = "Year", 
               ylab = expression("PM"[2.5]*" emissions (ktons)"), 
               space = 0.3)

# add values to bars
text(x = bar, y = df$emis/2, label = format(round(df$emis,2), big.mark =","), pos = 3, cex = 0.75, col = "red")

# copy to png 
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()