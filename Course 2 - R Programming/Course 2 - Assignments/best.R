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

best <- function(state, outcome){
   
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
   
   # return hospital name in that state with lowest 30-day death rate
   state_data_outcome <- subset(data_outcome, data_outcome$State == state)
   rates <- if(toupper(outcome) == "HEART ATTACK"){
      state_data_outcome[, 11]
   }else if(toupper(outcome) == "HEART FAILURE"){
      state_data_outcome[, 17]
   }else if(toupper(outcome) == "PNEUMONIA"){
      state_data_outcome[, 23]   
   }
   rates <- as.numeric(rates)
   index <- which.min(rates)
   state_data_outcome[index, 2]
}



a <- best("AK", "pneumonia")
a


