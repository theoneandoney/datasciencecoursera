# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
# The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers 
# on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data 
# set as described below, 2) a link to a Github repository with your script for performing the analysis, 
# and 3) a code book that describes the variables, the data, and any transformations or work that you 
# performed to clean up the data called CodeBook.md. You should also include a README.md in the repo 
# with your scripts. This repo explains how all of the scripts work and how they are connected.

# One of the most exciting areas in all of data science right now is wearable computing - see for example 
# this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced 
# algorithms to attract new users. The data linked to from the course website represent data collected 
# from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the 
# site where the data was obtained:

# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

# Here are the data for the project:

#  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

# You should create one R script called run_analysis.R that does the following. 

# - Merges the training and the test sets to create one data set.
# - Extracts only the measurements on the mean and standard deviation for each measurement. 
# - Uses descriptive activity names to name the activities in the data set
# - Appropriately labels the data set with descriptive variable names. 
# - From the data set in step 4, creates a second, independent tidy data set with the average of 
#    each variable for each activity and each subject.

library(data.table)
pth <- getwd()

# ## only do this once for setup, then unzip
# fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download.file(fileUrl, destfile = "./data.zip", method="curl")
# dateDownloaded <- date()



activityLabels <- fread(file.path(pth, "data/UCI HAR Dataset/activity_labels.txt"), 
                        col.names = c("classLabels", "activityName"))
features <- fread(file.path(pth, "data/UCI HAR Dataset/features.txt"),
                        col.names = c("index", "featureNames"))

# only keep means and standard deviations
keep <- grep("(mean|std)\\(\\)", features[,featureNames])
measurements <- features[keep, featureNames]
measurements <- gsub('[()]', '', measurements)

# load datasets, starting with train
train <- fread(file.path(pth, "data/UCI HAR Dataset/train/X_train.txt"))
train <- train[,keep, with = FALSE]
data.table::setnames(train, colnames(train), measurements)
trainActivities <- fread(file.path(pth, "data/UCI HAR Dataset/train/Y_train.txt"), col.names = c("Activity"))
trainSubjects <- fread(file.path(pth, "data/UCI HAR Dataset/train/subject_train.txt"), col.names = c("SubjectNum"))
train <- cbind(trainSubjects, trainActivities, train)

# next load test dataset
test <- fread(file.path(pth, "data/UCI HAR Dataset/test/X_test.txt"))
test <- test[,keep, with = FALSE]
data.table::setnames(test, colnames(test), measurements)
testActivities <- fread(file.path(pth, "data/UCI HAR Dataset/test/Y_test.txt"), col.names = c("Activity"))
testSubjects <- fread(file.path(pth, "data/UCI HAR Dataset/test/subject_test.txt"), col.names = c("SubjectNum"))
test <- cbind(testSubjects, testActivities, test)

# merge datasets, improve labels
merged <- rbind(train, test)
merged[["Activity"]] <- factor(merged[, Activity], 
                                levels = activityLabels[["classLabels"]], 
                                labels = activityLabels[["activityName"]])

merged[["SubjectNum"]] <- as.factor(merged[, SubjectNum])
merged <- reshape2::melt(data = merged, id = c("SubjectNum", "Activity"))
merged <- reshape2::dcast(data = merged, SubjectNum + Activity ~ variable, fun.aggregate = mean)

data.table::fwrite(x = merged, file = "tidy_data.txt")