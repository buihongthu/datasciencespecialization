### 0. preparation for the data cleaning  
# call libraries
library(dplyr)
library(plyr)
library(reshape2)

# download row data 
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file(fileURL, "rowdata.zip", method="curl")

# unzip row data 
unzip("rowdata.zip") 

# read predefined data 
acs <- read.table("UCI HAR Dataset/activity_labels.txt")
fes <- read.table("UCI HAR Dataset/features.txt")

# read train data 
str <- read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE)
xtr <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE)
ytr <- read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE)

# read test data
ste <- read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)
xte <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)
yte <- read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE)


### 1. merges the training and the test sets to create one data set 
trn <- cbind(str, ytr, xtr)
tst <- cbind(ste, yte, xte)
dat <- rbind(trn, tst)
colnames(dat) <- c("subject", "activity", as.character(fes[, 2]))


### 2. extracts only the measurements on the mean and standard deviation - 79
idx <- grep("subject|activity|mean|std", colnames(dat))
dat.msd <- dat[,idx]


### 3. Uses descriptive activity names to name the activities in the data set
colnames(acs) <- c("activity", "activityName")
dat.msd <- join(dat.msd, acs, by = "activity", match = "first")  
dat.msd <- select(dat.msd, subject, activityName, 3:82)


### 4. appropriately labels the data set with descriptive variable names
# remove special characters
names(dat.msd) <- gsub("\\(|\\)", "", names(dat.msd), perl  = TRUE)

# descriptive names
names(dat.msd) <- gsub("Acc", "Acceleration", names(dat.msd))
names(dat.msd) <- gsub("BodyBody", "Body", names(dat.msd))
names(dat.msd) <- gsub("mean", "Mean", names(dat.msd))
names(dat.msd) <- gsub("std", "Std", names(dat.msd))
names(dat.msd) <- gsub("Freq", "Frequency", names(dat.msd))
names(dat.msd) <- gsub("Mag", "Magnitude", names(dat.msd))
names(dat.msd) <- gsub("^t", "Time", names(dat.msd))
names(dat.msd) <- gsub("^f", "Frequency", names(dat.msd))
 

### 5. tidy data set with the average of each variable for each activity and each subject
# group and average 
dat.msd.melted <- melt(dat.msd, id = c("subject", "activityName"))
dat.msd.mean <- dcast(dat.msd.melted, subject + activityName ~ variable, mean)

# write to txt file 
write.table(dat.msd.mean, file="tidy_data.txt", row.name = FALSE)
