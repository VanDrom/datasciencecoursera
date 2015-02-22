## Your working directory must be the unzipped UCIHARdataset folder

#In preparation for the merge function to be used later
install.packages("dplyr")
library(dplyr)

##Transformation of the "features.text" names to be used as colomn names
#Elimination of problematic characters for column names (see ReadME)
features = read.table("features.txt")
features$V2 <- gsub(",",".",features$V2)
features$V2 <- gsub("\\(","",features$V2)
features$V2 <- gsub("\\)","",features$V2)
features$V2 <- gsub("-",".",features$V2)
features$V2 <- gsub("BodyBody","Body",features$V2)

#Selection of the means and standard deviations from the features 
features <- features[grepl("mean",features$V2) | grepl("std",features$V2),]
#Elimination of meanFreq, not to be confused with the requested means
#(see ReadME)
features <- features[!grepl("meanFreq",features$V2),]

#Reading the provided dataframes for the test sample
subject.test = read.table("./test/subject_test.txt")
y.test = read.table("./test/y_test.txt")
X.test = read.table("./test/X_test.txt")

#Building the total "test" dataframe, and naming of the first two columns
subject.activity <- cbind(subject.test,y.test)
colnames(subject.activity)<- c("subject","activity")
test.complete <- cbind(subject.activity,X.test)

#Reading the provided dataframes for the training sample
subject.train = read.table("./train/subject_train.txt")
y.train = read.table("./train/y_train.txt")
X.train = read.table("./train/X_train.txt")

#Building of the total "training" dataframe, and naming of the first 
#two columns
subject.activity <- cbind(subject.train,y.train)
colnames(subject.activity)<-c("subject","activity")
train.complete <- cbind(subject.activity,X.train)

#Merging of previous dataframes (test and training)
mergedData = merge(train.complete,test.complete,all=TRUE)

##Tidying mergedData
#Preparation of the tidy dataframe
ncol <- length(features$V1)
subject <- mergedData[,1]
activity <- mergedData[,2]
tidyData <- data.frame(subject,activity)
poscol <- 2

#Building the tidy data, and naming columns
for (i in 1:ncol) { 
            extcol <- features$V1[i] + 2
            poscol <- poscol + 1
            tidyData <- cbind(tidyData,mergedData[,extcol])
            colnames(tidyData)[poscol] <- features$V2[i]
}

##Naming of the activities in column 2 of tidyData
activity.labels = read.table("activity_labels.txt")
for (i in 1:6) {
            conv <- as.character(activity.labels$V2[i])
            tidyData$activity[tidyData$activity == i] <- conv
		   }
#------------------------------------------------------------
#Creation of tidyData2 with means of the selected features,
#in function of subjects and activities

tidyData2 <- aggregate(tidyData[,3:68],list(Subject=tidyData$subject,Activity=tidyData$activity),mean)

#Adding the suffix "_Mean" to column names, since they are now means of features.
#(As a reminder: they were already means, and standard deviations)
  
for (i in 3:68) { 
            a <- c(colnames(tidyData2)[i],"_Mean")                        
            b <- paste(a,collapse="")
            colnames(tidyData2)[i] <- b
}




