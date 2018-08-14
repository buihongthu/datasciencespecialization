source("complete.R")

corr <- function(directory, threshold = 0){
   df = complete(directory)
   setwd(directory)
   indexes <- df$nobs > threshold
   df_data <- data.frame(Date=as.Date(character()),
                         sulfate=numeric(), 
                         nitrate=numeric(), 
                         ID=integer())
   corr <- vector('numeric')
   for(i in 1: nrow(df)){
      if(indexes[i] == TRUE){
         # add data for correlation
         filename <- if(i < 10){
            paste("00", i ,".csv", sep="", collapse = NULL)
         } else if(i >= 10 && i < 100) {
            paste("0", i ,".csv", sep="", collapse = NULL)
         } else {
            paste(i ,".csv", sep="", collapse = NULL)   
         }
         
         df_data <- read.csv(filename)
         df_exp_data <- df_data[complete.cases(df_data), ]
         corr <- append(corr, cor(df_exp_data$sulfate, df_exp_data$nitrate))
      }
   }   
   setwd("..")
   corr
}

cr <- corr("specdata")                
cr <- sort(cr)                
set.seed(868)                
out <- round(cr[sample(length(cr), 5)], 4)
print(out)

cr <- corr("specdata", 129)                
cr <- sort(cr)                
n <- length(cr)                
set.seed(197)                
out <- c(n, round(cr[sample(n, 5)], 4))
print(out)

cr <- corr("specdata", 2000)                
n <- length(cr)                
cr <- corr("specdata", 1000)                
cr <- sort(cr)
print(c(n, round(cr, 4)))
