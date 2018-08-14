### Question 3 - emissions by type in the Baltimore City, Maryland from 1999 to 2008

# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# load libraries 
library(dplyr)
library(ggplot2)

# sub dataframe of Baltimore City
sdf <- subset(NEI, fips == "24510")

# sum emissions in Baltimore by years & types
groups <- group_by(sdf, type, year = as.character(year))
sum.emis <- summarize(groups, emis = sum(Emissions))

# ggplot
g <- ggplot(sum.emis, aes(year, emis, label = round(emis,0)))

# add components
g + geom_bar(stat="identity") + facet_grid(. ~ type) + 
   geom_text(aes(label=format(round(emis,0), big.mark =",")), vjust=-0.3, color="blue", size=3) + 
   labs(y = expression("PM"[2.5]*" emissions (tons)")) + 
   ggtitle("Emissions in Baltimore City by Source Types (tons)")

# copy to png 
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()
