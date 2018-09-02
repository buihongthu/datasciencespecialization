setwd("D:/GitHub/RepData_PeerAssessment2")

# load libraries 
library(plyr)
library(dplyr)
library(data.table)
library(ggplot2)

# read the csv file in bz2 format
# dt <- read.csv("repdata%2Fdata%2FStormData.csv.bz2")
dt <- read.csv(bzfile("repdata%2Fdata%2FStormData.csv.bz2"))[,c(8,23,24,25,26,27,28)]

# cleaning the event type 
event.type <- toupper(dt$EVTYPE)
length(unique(event.type))
event.type <- gsub("[[:punct:]]", " ", event.type)
event.type <- gsub("\\d", "", event.type)
event.type <- gsub(" *$", "", event.type)
event.type <- gsub("^ *", "", event.type)
event.type <- gsub("  *", " ", event.type)
event.type[which(event.type == "")] <- "UNCLASSIFIED"
length(unique(event.type))

# update the data frame
dt$EVTYPE <- event.type



##### Types of events that are most harmful to Population Health
group.event <- group_by(dt, EVTYPE)
group.event.sum <- summarize(group.event, fats = sum(FATALITIES, na.rm = TRUE), 
                             injs = sum(INJURIES, na.rum = TRUE))
# fatals
top.fats <- head(group.event.sum[order(group.event.sum$fats, decreasing = T), ], 10)

g <- ggplot(data = top.fats, aes(reorder(EVTYPE, fats), fats))
g + geom_bar(stat = "identity", color = "black") + 
   coord_flip() + 
   labs(y="Fatalities", x="Events", 
        title="Top 10 Weather Events Cause Highest Fatalities", caption = "Source: ...") + 
   scale_y_continuous(breaks = seq(0, 6000, by = 1000))

# injury 
top.injs <- head(group.event.sum[order(group.event.sum$injs, decreasing = T), ], 10 )

g <- ggplot(data = top.injs, aes(reorder(EVTYPE, injs), injs))
g + geom_bar(stat="identity", color = "black") + 
   coord_flip() + 
   labs(y="Injuries", x="Events", 
        title="Top 10 Weather Events Cause Highest Injuries", caption = "Source: ...") + 
   scale_y_continuous(breaks = seq(0, 100000, by = 10000))





##### Types of events that have the greatest economic consequences
# transform unit
# h -> hundred, k -> thousand, m -> million, b -> billion
unit.tfm <- function(u) {
   if (u %in% c('h', 'H'))
      return(2)
   else if (u %in% c('k', 'K'))
      return(3)
   else if (u %in% c('m', 'M'))
      return(6)
   else if (u %in% c('b', 'B'))
      return(9)
   else if (!is.na(as.numeric(u)))
      return(as.numeric(u))
   else if (u %in% c('', '-', '?', '+'))
      return(0)
   else {
      stop("Invalid value")
   }
}

# create 2 new variables on damages
dt <- mutate(dt, PROPDMGCOST = dt$PROPDMG * (10 ** sapply(dt$PROPDMGEXP, unit.tfm)))
dt <- mutate(dt, CROPDMGCOST = dt$CROPDMG * (10 ** sapply(dt$CROPDMGEXP, unit.tfm)))

# Compute the economic loss by event type
group.event <- group_by(dt, EVTYPE)
group.event.eco <- summarize(group.event, ppt = sum(PROPDMGCOST, na.rm = TRUE), 
                             crp = sum(CROPDMGCOST, na.rm = TRUE), 
                             pac = sum(PROPDMGCOST + CROPDMGCOST), na.rm = TRUE)

# property
top.ppt <- head(group.event.eco[order(group.event.eco$ppt, decreasing = T), ], 10)
# par(mai=c(1,1.5,1,1),mgp=c(3,0,0))

g <- ggplot(data = top.ppt, aes(reorder(EVTYPE, ppt), ppt/10^9))
g + geom_bar(stat="identity", color = "black") + 
   coord_flip() + 
   labs(y="Property Damages", x="Events", 
        title="Top 10 Weather Events Cause Highest Property Damages (in billions)") +
   scale_y_continuous(breaks = seq(0, 70000, by = 10000))

# crop 
top.crp <- head(group.event.eco[order(group.event.eco$crp, decreasing = T), ], 10)

g <- ggplot(data = top.crp, aes(reorder(EVTYPE, crp), crp/10^9))
g + geom_bar(stat="identity", color = "black") + 
   coord_flip() + 
   labs(y="Crop Damages", x="Events", 
        title="Top 10 Weather Events Cause Highest Crop Damages (in billions)") +
   scale_y_continuous(breaks = seq(0, 15, by = 2))

# both 
top.pac <- head(group.event.eco[order(group.event.eco$pac, decreasing = T), ], 10)
g <- ggplot(data = top.pac, aes(reorder(EVTYPE, pac), pac/10^9))
g + geom_bar(stat="identity", color = "black") + 
   coord_flip() + 
   labs(y="Total Damages", x="Events", 
        title="Top 10 Weather Events Cause Highest Property & Crop Damages (in billions)") +
   scale_y_continuous(breaks = seq(0, 70000, by = 10000))

