pollutantmean <- function(directory, pollutant, id = 1:332){
   # go to data directory
   setwd(directory)
   
   for(i in id){
      
      filename <- if(i < 10){
         paste("00", i ,".csv", sep="", collapse = NULL)
      } else if(i >= 10 && i < 100) {
         paste("0", i ,".csv", sep="", collapse = NULL)
      } else {
         paste(i ,".csv", sep="", collapse = NULL)   
      }
      
      if(i == id[1]){
         df <- read.csv(filename)
      }else {
         df <- rbind(df, read.csv(filename))
      }
      
   }
   # return to parent directory
   setwd("..")
   
   filter <- !is.na(df[pollutant])
   means <- mean(df[pollutant][filter])
}

x <- pollutantmean("specdata", "nitrate")
x



getwd()
setwd("..")