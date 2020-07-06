#Load required packages
library(dplyr)

# Download data from the web
UrlFile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFolder <- "UCI-HAR-Dataset.zip"
dataset.name <- "UCI HAR Dataset"

if (!file.exists(UrlFile)) {
  download.file(zipFolder, Urlfile, method = "curl")
}
if (!file.exists(dataset.name)) {
  unzip(zipFolder)
}

# 1. Merges the training and the test sets to create one data set.
# Read features and activity labels
features <- read.table("UCI HAR Dataset/features.txt", as.is = TRUE, col.names = c("n", "feature"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

# Read training data 
train.subject <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
train.y <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity code")
train.X <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$feature)

# Read test data
test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
test.y <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity code")
test.X <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$feature)

# Merge all data into one data set
merged.train <- cbind(train.subject, train.y, train.X)
merged.test <- cbind(test.subject, test.y, test.X)
merged.final <- rbind(merged.train, merged.test)

# Assign column names 
colnames(merged.final) <- c("subject", "activity", features$feature)

# Remove unwanted intermediate data
rm(train.subject, train.X, train.y, test.subject, test.X, test.y, merged.train, merged.test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement
required.columns <- grepl("subject|activity|mean|std", colnames(merged.final))

# Get only relevant columns
merged.final <- merged.final[, required.columns]

# 3. Uses descriptive activity names to name the activities in the data set
merged.final$activity <- factor(merged.final$activity, levels = activities$code, labels = activities$activity)
new.colnames <- colnames(merged.final)

# 4. Appropriately labels the data set with descriptive variable names. 
# Remove special characters
new.colnames <- gsub("[()-]", "", new.colnames)
# gsub to make it descriptive
new.colnames <- gsub("mean", "Mean", new.colnames)
new.colnames <- gsub("std", "Standard Deviation", new.colnames)
new.colnames <- gsub("^t", "Time", new.colnames)
new.colnames <- gsub("^f", "Frequency", new.colnames)
new.colnames <- gsub("Acc", "Accelerometer", new.colnames)
new.colnames <- gsub("Gyro", "Gyroscope", new.colnames)
new.colnames <- gsub("Mag", "Magnitude", new.colnames)
new.colnames <- gsub("Freq", "Frequency", new.colnames)

#Assign new column names to dataset
colnames(merged.final) <- new.colnames

#' 5. From the data set in step 4, creates a second, independent tidy data set with the average 
#' of each variable for each activity and each subject.
merged.means <- merged.final %>% 
  group_by(subject, activity) %>%
  summarize_all(list(mean))

# raw
write.table(merged.final, file = "tidy_raw.txt", quote = FALSE, row.names = FALSE)
# mean
write.table(merged.means, file = "tidy_mean.txt", quote = FALSE, row.names = FALSE)
