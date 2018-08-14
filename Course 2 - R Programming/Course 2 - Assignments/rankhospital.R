setwd("D:/GitHub/Coursera/Course 2 - R Programming/Course 2 - Practise")
data_outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
fields <- names(data_outcome)
states <- unique(data_outcome[, 7])

check_state <- function(state){
   if(state %in% states)
   {
      return(TRUE)
   }
   return(FALSE)
}

check_outcome <- function(value){
   value <- gsub(" ",".", value)
   for(i in 1:length(fields)){
      if(grepl( toupper(value),  toupper(fields[i]))){
         return(TRUE)
      }
   }
   return(FALSE)
}

rankhospital <- function(state, outcome, num = "best") {
   
   # check state is valid 
   if(check_state(state) == FALSE){
      cat(paste("Error in best(\"", state, "\", \"", outcome, "\") : invalid state"))
      return("")
   }      
   
   # check outcome is valid
   if(check_outcome(outcome) == FALSE){
      cat(paste("Error in best(\"", state, "\", \"", outcome, "\") : invalid outcome"))
      return("")
   }
   ## Return hospital name in that state with the given rank
   ## 30-day death rate
   
   state_data_outcome <- subset(data_outcome, data_outcome$State == state)
   rates <- if(toupper(outcome) == "HEART ATTACK"){
      state_data_outcome[, 11]
   }else if(toupper(outcome) == "HEART FAILURE"){
      state_data_outcome[, 17]
   }else if(toupper(outcome) == "PNEUMONIA"){
      state_data_outcome[, 23]   
   }
   rates <- as.numeric(rates)
   
   dat <- data.frame(state_data_outcome, rates)
   # 
   # #print(data$Hospital.Name)
   order.scores <- order(dat$rates, dat$Hospital.Name)
   # print(order.scores)
   dat$rank <- NA
   dat$rank[order.scores] <- 1:nrow(dat)
    
   newdata <- dat[order(dat$rank),]
   subdata <- data.frame(newdata$State, newdata$rank, newdata$Hospital.Name, newdata$rates)
   subdata <- subdata[complete.cases(subdata), ]
   
   #write.csv(subdata, "md.csv")
   if(num == "best"){
      return(subdata[1, "newdata.Hospital.Name"])
   }else if(num == "worst"){
      return (subdata[nrow(subdata), "newdata.Hospital.Name"])
   }
   else if(num > nrow(subdata))
      return ("NA")
   else {
      subdata[num, "newdata.Hospital.Name"]
   }
}

b <- rankhospital("NC", "heart attack", "worst")
b

c <- rankhospital("WA", "heart attack", 7)
c

d <- rankhospital("TX", "pneumonia", 10)
d

e <- rankhospital("NY", "heart attack", 7)
e



