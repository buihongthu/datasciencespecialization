setwd("D:/GitHub/Coursera/Course 2 - R Programming/Course 2 - Practise")
source("rankhospital.R")

data_outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
states <- unique(data_outcome[, 7])
states <- sort(states)

rankall <- function(outcome, num = "best") {
   ## Check that state and outcome are valid
   df <- data.frame(Hospital.Name=character(),
                         State=character())
   ## For each state, find the hospital of the given rank
   for(i in states)
   {
      df <- rbind(df, data.frame(rankhospital(i, outcome, num), i))
   }
   
   ## Return a data frame with the hospital names and the (abbreviated) state name
   df
}


head(rankall("heart attack", 20), 10)
tail(rankall("pneumonia", "worst"), 3)
tail(rankall("heart failure"), 10)

r <- rankall("heart attack", 4)
as.character(subset(r, i == "HI")$hospital)

r <- rankall("pneumonia", "worst")
r

s <- rankall("heart failure", 10)
s