library(dplyr)

# Checks if the data has already been downloaded
if(!file.exists("data.zip")){
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(url,"data.zip")
    unzip("data.zip")
}

if(!exists("test") & !exists("train")){
    test <- read.table("UCI HAR Dataset/test/X_test.txt")
    train <- read.table("UCI HAR Dataset/train/X_train.txt")
}
varNames <- read.table("UCI HAR Dataset/features.txt")

# Appropriately labels the data set with descriptive variable names.
names(train) <- varNames$V2
names(test) <- varNames$V2

# Add activity type to the dataset
test$ActivityLabel <- read.table("UCI HAR Dataset/test/Y_test.txt")$V1
train$ActivityLabel <- read.table("UCI HAR Dataset/train/Y_train.txt")$V1
test$Subject <- read.table("UCI HAR Dataset/test/subject_test.txt")$V1
train$Subject <- read.table("UCI HAR Dataset/train/subject_train.txt")$V1

# Merges the training and the test sets to create one data set.
fulldata <- bind_rows(test,train)
rm(test,train)

# Extracts only the measurements on the mean and standard deviation for each measurement.
fulldata <- fulldata[,grep("mean[^F]|std|Activity|Subject",names(fulldata))]
names(fulldata) <- gsub("-"," ",names(fulldata))

# Uses descriptive activity names to name the activities in the data set
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
fulldata <- merge(fulldata,activityLabels,by.x="ActivityLabel",by.y="V1")
fulldata <- fulldata %>% rename(Activity = V2)
fulldata$ActivityLabel <- NULL #no longer needed

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
summarizedData <- fulldata %>% group_by(Subject,Activity) %>% summarize_each(funs(mean))
 
