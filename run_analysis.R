############################################
# Run Analysis.R  does the following: 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


runAlalysys <- function() 
{
#.... First lets create our lookup vectors

#... This will map the activity ID to the activity description
activityFile <- read.table("activity_labels.txt", header=FALSE, sep=" ")
activityMap <- as.list(setNames(activityFile$V1, activityFile$V2))

#... Now lets read the features and extact only those column indexes that match the "mean" or "std" pattern
#    that way, we'll be able to dynamically retrieve the proper column names even of the "feature" file gets 
#    re-arranged

#... Read the features.txt that maps the column indexes to the data labels
featureFile <- read.table("features.txt", header=FALSE, sep=" ")
featureMap <-  as.list(setNames(featureFile$V1, featureFile$V2))


#... We'll need to extract only required (mean and std) column indexes from this mess.
#    Hence, the RegEx search pattern. 
ptn <- "(?:mean|std)"
validFeatureColumnIndexes <- subset(featureFile, grepl(ptn, featureFile$V2, perl=T))

#### Test Data
#...Get test data, eliminate unnecessary columns and combine it with Subject and Activity
##...Read subjects (ids of people performing the test)
dataTypePrefix <-  "Test"

testSubjects <- read.csv("./test/subject_test_BIG.txt", header=FALSE)
colnames(testSubjects) <- c(paste(dataTypePrefix,"Subjects",sep=""))

#...Read Activities (type of activity, such as Walking, Seating, etc)
testActivities <- read.csv("./test/y_test_BIG.txt",header=FALSE)
colnames(testActivities) <- c(paste(dataTypePrefix,"Activities",sep=""))

#...read the main data
testData <- read.table("./test/X_test_BIG.txt", header=FALSE )
#...eliminate irrelevant columns (leave only columns with names "mean" and "std")
testData <- subset(testData,select=validFeatureColumnIndexes$V1)

#... Set the readable column names
colnames(testData) <- validFeatureColumnIndexes$V2

#... Now we should merge features, subjects, actions and data together into a uniform data frame
mergedTestDataSet <- data.frame(testSubjects,testActivities,testData)

######### TRain Data

dataTypePrefix <-  "Train"

trainSubjects <- read.csv("./train/subject_train_BIG.txt", header=FALSE)
colnames(trainSubjects) <- c(paste(dataTypePrefix,"Subjects",sep=""))

#...Read Activities (type of activity, such as Walking, Seating, etc)
trainActivities <- read.csv("./train/y_train_BIG.txt",header=FALSE)
colnames(trainActivities) <- c(paste(dataTypePrefix,"Activities",sep=""))

#...read the main data
trainData <- read.table("./train/X_train_BIG.txt", header=FALSE )
#...eliminate irrelevant columns (leave only columns with names "mean" and "std")
trainData <- subset(trainData,select=validFeatureColumnIndexes$V1)

#... Set the readable column names
colnames(trainData) <- validFeatureColumnIndexes$V2

#... Now we should merge features, subjects, actions and data together into a uniform data frame
mergedTrainDataSet <- data.frame(trainSubjects,trainActivities,trainData)

#...Get train data, eliminate unnecessary columns and combine it with Subject and Activity
#mergedTrainData <- mergeActivitySubject("Train","./train/subject_train.txt","./train/y_train.txt","./train/X_train.txt" )


#..now merge test and trainig data
result <- merge(mergedTestDataSet, mergedTrainDataSet, by.x=c("TestActivities"), by.y=c("TrainActivities"))
#apply
aggdata <-aggregate(result, by=list(result$TestActivities, result$TestSubjects), FUN=mean, na.rm=TRUE)
#tidySet <- tapply(orderedSubset$Hospital.Name, orderedSubset$State
write.table(aggdata,"./aggregate.txt", sep=" ")
}