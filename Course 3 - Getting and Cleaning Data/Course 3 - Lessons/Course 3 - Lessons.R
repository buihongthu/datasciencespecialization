#################### WEEK 1 ####################
########## LESSONS ##########
setwd("D:/Software Engineering/Coding/DataScience/Course 3 - Getting and Cleaning Data/Course 3 - Lessons")

##### obtaining data motivation 
# raw data -> processing data -> tidy data -> data analysis -> data communication

##### components of tidy data 

##### downloading files 
# check for and creating directory 
if(!file.exists("data")){
   dir.create("data")
}
   
# getting data from the internet 
# download.file()
fileURL <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accesstype=DOWNLOAD"
download.file(fileURL, destfile = "./data/cameras.csv", method = "curl")
list.files("./data")

##### read csv files 
# read.table(), read.csv(), read.csv2()
cameraData <- read.table("./data/cameras.csv", sep = ",", header = TRUE)
head(cameraData)

cameraData <- read.csv("./data/cameras.csv")
head(cameraData)


##### read excel files 
#fileURL <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accesstype=DOWNLOAD"
#download.file(fileURL, destfile = "./data/cameras.xlsx", method = "curl")
list.files("./data")

install.packages("xlsx")
library(xlsx)
cameraData <- read.xlsx("./data/cameras.xlsx", sheetIndex = 1, header = TRUE)
head(cameraData)


##### read xml files 
# install.packages("XML")
library(xml)
fileURL <- "http://www.w3schools.com/xml/simple.xml"
download.file(fileUrl, destfile = "./data/simple.xml")
doc <- xmlTreeParse("./data/simple.xml", useInternalNodes = TRUE)
rootNode <- xmlRoot(doc)

xmlName(rootNode)
names(rootNode)
rootNode[[1]][[2]]

xmlSApply(rootNode, xmlValue)

xpathSApply(rootNode, "//name", xmlValue)
xpathSApply(rootNode, "//price", xmlValue)

# other xml file
fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
download.file(fileUrl, destfile = "./data/scores.xml")
doc <- htmlTreeParse("./data/scores.xml",useInternal=TRUE)
scores <- xpathSApply(doc,"//li[@class='score']",xmlValue)
teams <- xpathSApply(doc,"//li[@class='team-name']",xmlValue)
scores
teams


##### reading JSON
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
jsonData$owner$login

# write data frames to JSON
myjson <- toJSON(iris, pretty=TRUE)
cat(myjson)

# convert back to data frame
iris2 <- fromJSON(myjson)
head(iris2)


##### the data.table package
library(data.table)
DF = data.frame(x = rnorm(9), y = rep(c("a", "b", "c"), each = 3), z = rnorm(9))
head(DF, 3)

DT = data.table(x = rnorm(9), y = rep(c("a", "b", "c"), each = 3), z = rnorm(9))
head(DT, 3)

# view tables in memory
tables()

# subset data.table
DT
DT[2, ]
DT[DT$y == "a", ]
DT[c(2,3)]  # subset the rows 2,3 
DT[, c(2,3)]  # subset the columns 2,3

# calculating values for variables with expressions 
DT[, list(mean(x), sum(z))]
DT[, table(y)]
DT[, w:= z^2]  # add new column z
DT

# multiple operations
DT[, m:= {tmp <- (x + z); log2(tmp + 5)}]

# plyr like operations
DT[, a:= x > 0]
DT[, b:= mean(x+w), by = a]

#.N
set.seed(123)
DT <- data.table(x = sample(letters[1:3], 1E5, TRUE))
DT[, .N, by = x]

# keys for subset 
DT <- data.table( x = rep(c("a", "b", "c"), each = 100), y = rnorm(300))
setkey(DT, x)
DT['a']

# joins 
DT1 <- data.table(x=c('a', 'a', 'b', 'dt1'), y=1:4)
DT2 <- data.table(x=c('a', 'b', 'dt2'), z=5:7)
setkey(DT1, x); setkey(DT2, x)
merge(DT1, DT2)

# fast reading
big_df <- data.frame(x=rnorm(1E6), y=rnorm(1E6))
file <- tempfile()
write.table(big_df, file=file, row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)
system.time(fread(file))

system.time(read.table(file, header=TRUE, sep="\t"))



########## QUIZ ########## 
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL, destfile = "./data/housing.csv", method = "curl")
list.files("./data")

housing_data <- read.csv("./data/housing.csv")
head(housing_data)


data <- read.xlsx("./data/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", rows = c(18:23), cols = c(7:15))










#################### WEEK 2 ####################
########## LESSONS ##########
###### reading from mySQL 
install.packages("RMySQL")
library(RMySQL)
ucscDb <- dbConnect(MySQL(),user="genome", host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb,"show databases;")
dbDisconnect(ucscDb)
result

# list all tables 
hg19 <- dbConnect(MySQL(), user = "genome", db = "hg19", host = "genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5]

# list fields in tables 
dbListFields(hg19, "affyU133Plus2")
dbGetQuery(hg19, "select count(*) from affyU133Plus2")

# read from the table 
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)

# select a specific subset 
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query); 
affyMis$misMatches
quantile(affyMis$misMatches)
affyMisSmall <- fetch(query, n = 10)
dbClearResult(query)
affyMisSmall$misMatches
dim(affyMisSmall)


##### reading from HDF5
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(rhdf5)
created = h5createFile("example.h5")
created = h5createGroup("example.h5", "foo")
created = h5createGroup("example.h5", "bar")
created = h5createGroup("example.h5", "foo/foobaa")
created
h5ls("example.h5")

#write to groups
A = matrix(1:10,nr=5,nc=2)
h5write(A, "example.h5","foo/A")

B = array(seq(0.1,2.0,by=0.1),dim=c(5,2,2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5","foo/foobaa/B")
h5ls("example.h5")

# write a dataset 
df = data.frame(1L:5L,seq(0,1,length.out=5),
  c("ab","cde","fghi","a","s"), stringsAsFactors=FALSE)
h5write(df, "example.h5","df")
h5ls("example.h5")

# read data
readA = h5read("example.h5","foo/A")
readB = h5read("example.h5","foo/foobaa/B")
readdf= h5read("example.h5","df")
readA

# write and read chunk
h5write(c(12,13,14),"example.h5","foo/A",index=list(1:3,1))
h5read("example.h5","foo/A")


##### reading from The Web
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode

# parse with XML
library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes=T)
xpathSApply(html, "//title", xmlValue)
xpathSApply(html, "//td[@id='col-citedby']", xmlValue)

# get from the httr package
library(httr); html2 = GET(url)
content2 = content(html2,as="text")
parsedHtml = htmlParse(content2,asText=TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)

# access website with password
pg1 = get("http://httpbin.org/basic-auth/user/passwd", authenticate("user","passwd"))
pg1
name(pg1)

# using handles 
google = handle("http://google.com")
pg1 = GET(handle=google,path="/")
pg2 = GET(handle=google,path="search")


##### reading from APIs
# accessing twitter 
myapp = oauth_app("twitter", key="yourConsumerKeyHere",secret="yourConsumerSecretHere")
sig = sign_oauth1.0(myapp, token = "yourTokenHere", token_secret = "yourTokenSecretHere")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)

# convert to json object 
json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]


##### reading from other sources
# load data from Minitab, S, SAS, SPSS, Stata, Systat
# read.arff (Weka)
# read.dta (Stata)
# read.mtp (Minitab)
# read.octave (Octave)
# read.spss (SPSS)
# read.xport (SAS)


#################### WEEK 3 ####################
########## LESSONS ##########
##### subseting and sorting
## subsetting 
set.seed(13435)
X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
X <- X[sample(1:5),]; X$var2[c(1,3)] = NA
X
X[,1]
X[,"var1"]
X[1:2,"var2"]
X[(X$var1 <= 3 & X$var3 > 11),]
X[(X$var1 <= 3 | X$var3 > 15),]
# dealing with missing data
X[which(X$var2 > 8),]

## sorting 
sort(X$var1)
sort(X$var1,decreasing=TRUE)
sort(X$var2,na.last=TRUE)

## ordering
X[order(X$var1),]
X[order(X$var1,X$var3),]

# ordering with plyr
library(plyr)
arrange(X,var1)
arrange(X,desc(var1))

# add columns 
X$var4 <- rnorm(5)
X
Y <- cbind(X,rnorm(5))
Y


##### summarizing data 
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/restaurants.csv",method="curl")
restData <- read.csv("./data/restaurants.csv")
head(restData, n = 3)
tail(restData, n = 8)
summary(restData)
str(restData)
quantile(restData$councilDistrict, na.rm = TRUE)
quantile(restData$councilDistrict, probs = c(0.5, 0.75, 0.9))
table(restData$zipCode, useNA = "ifany")
table(restData$councilDistrict, restData$zipCode)

# check for missing value 
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0)

# row and column sums 
colSums(is.na(restData))
all(colSums(is.na(restData)) == 0)

# values with specific characteristics 
table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212", "21213"))

# subset with zipCode equal 2 values
restData[restData$zipCode %in% c("21212", "21213"), ]

#cross tabs 
data("UCBAdmissions")
DF = as.data.frame(UCBAdmissions)
head(DF)
summary(DF)
xt <- xtabs(Freq ~ Gender + Admit, data = DF)
xt

warpbreaks$replicate <- rep(1:9, len = 54)
xt <- xtabs(breaks ~ ., data = warpbreaks)
xt

# flat table 
ftable(xt)

# size of a data set 
fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData), units = "Mb")


##### create new variables 
# getting the data from the web
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/restaurants.csv",method="curl")
restData <- read.csv("./data/restaurants.csv")

# create sequences
s1 <- seq(1, 10, by=2) ; s1
s2 <- seq(1,10,length=3); s2
x <- c(1,3,8,25,100); seq(along = x)

# subset variable 
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)

# create logical variable 
restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong,restData$zipCode < 0)

# create categorical variables 
restData$zipGroups = cut(restData$zipCode, breaks=quantile(restData$zipCode))
table(restData$zipGroups)

library(Hmisc)
restData$zipGroups = cut2(restData$zipCode,g=4)
table(restData$zipGroups)

# create factor variable 
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)

# level of factor variable
yesno <- sample(c("yes","no"), size = 10, replace = TRUE)
yesnofac <- factor(yesno,levels=c("yes","no"))
yesnofac
relevel(yesnofac, ref="no")

# cutting produces factor variable 
install.packages("Hmisc")
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g = 4)
table(restData$zipGroups)

# using mutate function  
library(Hmisc)
library(plyr)
restData2 = mutate(restData,zipGroups=cut2(zipCode,g=4))
table(restData2$zipGroups)

## common transforms 
# abs(x) absolute value
# sqrt(x) square root
# ceiling(x) ceiling(3.475) is 4
# floor(x) floor(3.475) is 3
# round(x,digits=n) round(3.475,digits=2) is 3.48
# signif(x,digits=n) signif(3.475,digits=2) is 3.5
# cos(x), sin(x) etc.
# log(x) natural logarithm
# log2(x), log10(x) other common logs
# exp(x) exponentiating x


##### reshaping data 
install.packages("reshape2")
library(reshape2)
head(mtcars)

# melting data frames
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars,id.vars=c("carname","gear","cyl"), measure.vars = c("mpg","hp"))
head(carMelt, n = 3)
tail(carMelt, n = 3)

# casting data frame 
cylData <- dcast(carMelt, cyl ~ variable)
cylData

cylData <- dcast(carMelt, cyl ~ variable, mean)
cylData

# averaging values 
head(InsectSprays)
tapply(InsectSprays$count, InsectSprays$spray, sum)

# split data by spray values 
spIns =  split(InsectSprays$count,InsectSprays$spray)
spIns

# lapply 
sprCount = lapply(spIns,sum)
sprCount

# combine 
unlist(sprCount)
sapply(spIns,sum)

# plyr package
library("plyr")
ddply(InsectSprays,.(spray),summarize,sum=sum(count))

# create new variable 
spraySums <- ddply(InsectSprays,.(spray),summarize,sum=ave(count,FUN=sum))
dim(spraySums)


##### managing data frames with dplyr
# arrange, filter, select, mutate, rename, summary
install.packages("dplyr")
library(dplyr)
options(width = 105)
chicago <- readRDS("./data/chicago.rds")
dim(chicago)
str(chicago)
names(chicago)
head(select(chicago, city:dptp))
head(select(chicago, -(city:dptp)))

i <- match("city", names(chicago))
j <- match("dptp", names(chicago))
head(chicago[, -(i:j)])

chic.f <- filter(chicago, pm25tmean2 > 30)
head(chic.f)
chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80)
head(chic.f)

# arrange: order 
chicago <- arrange(chicago, date)
head(chicago)
tail(chicago)
chicago <- arrange(chicago, desc(date))

# rename
chicago <- rename(chicago, pm25 = pm25tmean2, dewpoint = dptp)
names(chicago)

# mutate
chicago <- mutate(chicago, pm25detrend = pm25 - mean(pm25, na.rm = TRUE))
head(select(chicago, pm25, pm25detrend))
chicago <- mutate(chicago, tempcat = factor(1 * (tmpd > 80), labels = c("cold", "hot")))
hotcold <- group_by(chicago, tempcat)
head(hotcold)

# summarize 
summarize(hotcold, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))

chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)
years <- group_by(chicago, year)
summarize(years, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))

chicago %>% mutate(month = as.POSIXlt(date)$mon + 1) %>% 
   group_by(month) %>% 
   summarize(pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))


##### merging data 
if(!file.exists("./data")){dir.create("./data")}
fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1,destfile="./data/reviews.csv",method="curl")
download.file(fileUrl2,destfile="./data/solutions.csv",method="curl")
reviews = read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")

head(reviews,2)
head(solutions,2)
names(reviews)
names(solutions)

mergedData = merge(reviews,solutions,by.x="solution_id",by.y="id",all=TRUE)
head(mergedData)

intersect(names(solutions),names(reviews))
mergedData2 = merge(reviews, solutions, all=TRUE)
head(mergedData2)

# or join join in plyr package  
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
arrange(join(df1,df2),id)


df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
df3 = data.frame(id=sample(1:10),z=rnorm(10))
dfList = list(df1,df2,df3)
join_all(dfList)



#################### WEEK 4 ####################
########## LESSONS ##########
##### editing text variables 
# download.file()
fileURL <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accesstype=DOWNLOAD"
download.file(fileURL, destfile = "./data/cameras.csv", method = "curl")
list.files("./data")
cameraData <- read.csv("./data/cameras.csv")
names(cameraData)
tolower(names(cameraData))

grep("Alameda", cameraData$intersection, value = TRUE)
grep("JeffStreet", cameraData$intersection)
length(grep("JeffStreet", cameraData$intersection))

library(stringr)
substr("Jeffrey Leek", 1, 7)
paste("Jeffrey", "Leek")
paste0("Jeffrey", "Leek")
str_trim("Jeff    ")

##### regular expression



##### working with dates 
# POSIXct, POSIXlt
x = c("1jan1960", "2jan1960", "31mar1960", "30jun1960"); 
z = as.Date(x, "%d%b%Y")
z
z[1] - z[2]
as.numeric(z[1] - z[2])

d2 <- z[1]
weekdays(d2)
months(d2)
julian(d2)

install.packages("lubridate")
library(lubridate)
ymd("20140108")
mdy("08/04/2013")
dmy("04-08-2014")
ymd_hms("2011-08-03 10:15:03")

ymd_hms("2011-08-03 10:15:03", tz = "Pacific/Auckland")
?Sys.timezone


##### data resources 


