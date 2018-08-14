complete <- function(directory, id = 1:332){
   
   setwd(directory)
   
   df <- data.frame(id = integer(), nobs=integer()) 
   
   for(i in id){
      
      filename <- if(i < 10){
         paste("00", i ,".csv", sep="", collapse = NULL)
      } else if(i >= 10 && i < 100) {
         paste("0", i ,".csv", sep="", collapse = NULL)
      } else {
         paste(i ,".csv", sep="", collapse = NULL)   
      }
      
      df_temp <- read.csv(filename, header=TRUE)
      
      j <- 1 
      count <- 0
      while(j <= nrow(df_temp)){
         
         if( !anyNA(df_temp$sulfate[j]) && !anyNA(df_temp$nitrate[j]) ){
            count <- count + 1
         }
         j <- j + 1
      }
      
      df <- rbind(df, data.frame(id=i,nobs=count))
   }
   
   # point to parent directory
   setwd("..")
   df
}



cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
print(cc$nobs)

cc <- complete("specdata", 54)
print(cc$nobs)

set.seed(42)
cc <- complete("specdata", 332:1)
use <- sample(332, 10)
print(cc[use, "nobs"])