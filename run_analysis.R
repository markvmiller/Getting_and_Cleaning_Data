getwd()
setwd('C:/Users/Mark/Documents/R/coursera/Getting and Cleaning Data/UCI HAR Dataset')
list.files()

y.test <- read.table("./test/Y_test.txt")
x.test <- read.table("./test/X_test.txt")
subject.test<-read.table("./test/subject_test.txt")

y.train <- read.table("./train/Y_train.txt")
x.train <- read.table("./train/X_train.txt")
subject.train<-read.table("./train/subject_train.txt")

#1. join data parts together
labels.combined <- rbind(y.train,y.test) 
data.combined <- rbind(x.train,x.test) 
subjects.combined <- rbind(subject.train,subject.test)


#2 extract mean and standard deviation for each measurement
features <- read.table("./features.txt")
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
data.combined.subset <- data.combined[,meanStdIndices]
names(data.combined.subset) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) #This names the columns and removes the "()" from the variable names
names(data.combined.subset) <- gsub("mean", "Mean", names(data.combined.subset)) #This capitalizes the mean
names(data.combined.subset) <- gsub("std", "Std", names(data.combined.subset)) #likewise, for S.D.
names(data.combined.subset) <- gsub("-", "", names(data.combined.subset)) #This removes the "-" in column names 

#3 Uses descriptive activity names to name the activities in the dataset
activity.labels <- read.table("./activity_labels.txt")
activity.labels[, 2] <- tolower(gsub("_", "", activity.labels[, 2])) #convert to lower case
substr(activity.labels[2, 2], 8, 8) <- toupper(substr(activity.labels[2, 2], 8, 8)) #capitalizes second word of second row in data
substr(activity.labels[3, 2], 8, 8) <- toupper(substr(activity.labels[3, 2], 8, 8)) #capitalizes second word of third row in data
activityLabel <- activity.labels[labels.combined[, 1], 2] #create a vector, where each row has the label from activity.labels corresponding to the value within labels.combined
labels.combined[, 1] <- activityLabel
names(labels.combined) <- "activity"

#4 Appropriately labels the data set with descriptive activity names
names(subjects.combined) <- "subject"
allData <- cbind(subjects.combined, labels.combined, data.combined.subset)
write.table(allData, "./merged_data.txt") # write out the 1st dataset

#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
library(plyr)
allData2<-aggregate(. ~subject + activity, allData, mean) #take the mean by activity and subject
allData2<-allData2[order(allData2$subject,allData2$activity),] #sort rows by subject and activity
write.table(allData2, file = "./merged_data_tidy_version.txt",row.name=FALSE)