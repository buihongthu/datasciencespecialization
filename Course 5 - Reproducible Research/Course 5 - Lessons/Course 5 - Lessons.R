#################### WEEK 1 ####################
########## LESSONS ##########
setwd("D:/GitHub/datasciencespecialization/Course 5 - Reproducible Research/Course 5 - Lessons")

##### concepts and ideas

##### structure of a data analysis 
# steps in a data analysis:  
# define the question,
# define the ideal data set, 
# determine what data you can access 
# obtain the data
# clean the data
# exploratory data analysis:                 summaries, missing data, plots, clustering 
# statistical prediction/modeling:           informed by the results of the exploratory analysis
# interpret results:                         describes, correlate with, leads to/causes, predict 
# challenge results 
# synthesize/write up results 
# create reproducible code 

# ideal data set depends goals: 
# descriptive
# exploratory
# inferential 
# predictive 
# causal 
# mechanistic 

# cleaned data set 
install.packages("kernlab")
library(kernlab)
data(spam)
str(spam[, 1:5])

# performa a subsampling 
set.seed(3435)
trainIndicator <- rbinom(4601, size = 1, prob = 0.5)
table(trainIndicator)
trainSpam <- spam[trainIndicator == 1, ]
testSpam <- spam[trainIndicator == 0, ]

### explore data sets
dim(spam); dim(trainSpam); dim(testSpam)
names(trainSpam)
head(trainSpam)
table(trainSpam$type)
plot(trainSpam$capitalAve ~ trainSpam$type)
plot(log10(trainSpam$capitalAve + 1) ~ trainSpam$type)
plot(log10(trainSpam[, 1:4] + 1))
hCluster <- hclust(dist(t(log10(trainSpam[, 1:55] + 1))))
plot(hCluster)

### statistical prediction/modeling 
trainSpam$numType <- as.numeric(trainSpam$type) - 1
costFunction <- function(x, y) sum(x != (y > 0.5))
cvError <- rep(NA, 55)
library(boot)
for(i in 1:55){
   lmFormula <- reformulate(names(trainSpam)[i], response = "numType")
   glmFit <- glm(lmFormula, family = "binomial", data = trainSpam)
   cvError[i] <- cv.glm(trainSpam, glmFit, costFunction, 2)$delta[2]
}
#which predictor has minimum cross-validated error?
names(trainSpam)[which.min(cvError)]

### get a measure of uncertainty
# use the best model from the group
predictionModel <- glm(numType ~ charDollar, family = "binomial", data = trainSpam)

# get prediction on the test set 
predictionTest <- predict(predictionModel, testSpam)
predictedSpam <- rep("nonspam", dim(testSpam)[1])

# class as 'spam' for those with prob > 0.5
predictedSpam[predictionModel$fitted > 0.5] <- "spam"

# classification tables 
table(predictedSpam, testSpam$type)

### interpret results 
# give an explanation
# interpret coefficients
# interpret measures of uncertainty

### challenge results 
# challenge all steps: question, data source, processing, analysis, conclusions
# challenge measures of uncertainty 
# challenge choices of terms to include in models 
# think of potential alternative analyses 

### synthesize/ write-up results 
# lead with questions. 
# summarize the analyses into the story
# don't include everything, but what are needed for the story, or to address the challenge
# order analyses according to the story, rather than chronologically


##### organizing the analysis  







#################### WEEK 2 ####################
########## LESSONS ##########
#install.packages("xtable")




#################### WEEK 3 ####################
########## LESSONS ##########

##### evidence-based data analysis 





#################### WEEK 4 ####################
########## LESSONS ##########
# human readable <> machine readable 
