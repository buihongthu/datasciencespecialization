# set working folder
setwd("D:/Software Engineering/Coding/DataScience/Course 4 - Exploratory Data Analysis/Course 4 - Assignments/Course Project 2")

# download data files only one times for all of plots
data_file <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",data_file)
file <- unzip(data_file)
unlink(data_file)

# fips: A five-digit number (represented as a string) indicating the U.S. county
# SCC: The name of the source as indicated by a digit string (see source code classification table)
# Pollutant: A string indicating the pollutant
# Emissions: Amount of PM2.5 emitted, in tons
# type: The type of source (point, non-point, on-road, or non-road)
# year: The year of emissions recorded

# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



### Question 1 - total emissions from PM2.5 decreased in the United States from 1999 to 2008
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





### Question 2 -  total emissions from PM2.5 in the Baltimore City, Maryland from 1999 to 2008
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




### Question 3 - emissions by type in the Baltimore City, Maryland from 1999 to 2008

# prepare libraries 
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



### Question 4 - Across the United States, emissions from coal combustion-related sources in 1999-2008
# SCCs list of coal combustion 
SCC$EI.Sector <- as.character(SCC$EI.Sector)
coal_logic <- grepl("COAL", toupper(SCC$EI.Sector))
coal <- subset(SCC, coal_logic)
coal_scc <- unique(coal$SCC)

# subset of NEI on coal combustion 
coal_df <- subset(NEI, SCC %in% coal_scc)

# sum coal emissions by years 
sum.emis <- with(coal_df, tapply(Emissions, year, sum))

# create dataframe of year and coal emissions in kilotons
df <- data.frame(year = names(sum.emis), emis = sum.emis/1000)

# barplot
bar <- barplot(df$emis, names.arg = df$year, 
               main = "Emissions From Coal Combustion-Related Sources (ktons)", 
               xlab = "Year", 
               ylab = expression("PM"[2.5]*" emissions (ktons)"), 
               space = 0.3)

# add values to bars
text(x = bar, y = df$emis/2, label = format(round(df$emis,2), big.mark =","), pos = 3, cex = 0.75, col = "blue")

# copy to png 
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()




### Question 5 - Emissions from motor vehicle sources from 1999-2008 in Baltimore City
# SCCs list of motor vehicle sources  
SCC$EI.Sector <- as.character(SCC$EI.Sector)
mobile_logic <- grepl("VEHICLES", toupper(SCC$EI.Sector))
mobile <- subset(SCC, mobile_logic)
mobile_scc <- unique(mobile$SCC)

# data of Baltimore & emissions from motor vehicle sources
mb_df <- subset(NEI, fips == "24510" & SCC %in% mobile_scc)

# sum emissions by years in Baltimore
sum.emis <- with(mb_df, tapply(Emissions, year, sum))

# create dataframe of year and emissions from motor vehicle sources in Baltimore
df <- data.frame(year = names(sum.emis), emis = sum.emis)

# barplot
bar <- barplot(df$emis, names.arg = df$year, 
               main = "Motor Vehicle Emissions in Baltimore (tons)", 
               xlab = "Year", 
               ylab = expression("PM"[2.5]*" emissions (tons)"), 
               space = 0.3)

# add values to bars
text(x = bar, y = df$emis/3, label = format(round(df$emis,0), big.mark =","), pos = 3, cex = 0.75, col = "blue")

# copy to png 
dev.copy(png, file = "plot5.png", width = 480, height = 480)
dev.off()





### Question 6 - Emissions from motor vehicle sources from 1999-2008 in Baltimore City & Los Angeles County
# SCCs list of motor vehicle sources  
SCC$EI.Sector <- as.character(SCC$EI.Sector)
mobile_logic <- grepl("VEHICLES", toupper(SCC$EI.Sector))
mobile <- subset(SCC, mobile_logic)
mobile_scc <- unique(mobile$SCC)

# data of (Bal, Los) & motor vehicle sources 
mb_df <- subset(NEI, (fips == "24510" | fips == "06037") & SCC %in% mobile_scc)

# sum emissions from motor vehicle sources on fips and years 
groups <- group_by(mb_df, fips, year = as.character(year))
sum.emis <- summarize(groups, emis = sum(Emissions))

# add an variable 'city' of Baltimore & Los Angeles to dataframe sum.emis
sum.emis$city <- ifelse(sum.emis$fips == "24510", "Baltimore", "Los Angeles")

#ggplot 
g <- ggplot(sum.emis, aes(year, emis,label = round(emis,0)))
# add components
g + geom_bar(stat="identity") + facet_grid(. ~ city) + 
    geom_text(aes(label=format(round(emis,0), big.mark =",")), vjust=-0.3, color="blue", size=3) + 
    labs(x = "Year", y = expression("PM"[2.5]*" emissions (tons)")) + 
    ggtitle("Motor Vehicle Emissions in Baltimore and Los Angeles (tons)")

# copy to png 
dev.copy(png, file = "plot6.png", width = 480, height = 480)
dev.off()
