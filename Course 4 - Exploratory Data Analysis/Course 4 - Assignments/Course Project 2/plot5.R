### Question 5 - Emissions from motor vehicle sources from 1999-2008 in Baltimore City

# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

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