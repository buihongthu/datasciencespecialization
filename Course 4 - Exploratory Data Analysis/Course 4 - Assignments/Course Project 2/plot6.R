### Question 6 - Emissions from motor vehicle sources from 1999-2008 in Baltimore City & Los Angeles County

# load libraries 
library(dplyr)
library(ggplot2)

# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

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