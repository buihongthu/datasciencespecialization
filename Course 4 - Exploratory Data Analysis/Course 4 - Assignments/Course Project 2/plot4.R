### Question 4 - Across the United States, emissions from coal combustion-related sources in 1999-2008

# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

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