## PACKAGES TO MY RECOLLECTION: dplyr, tidyr, data.table, tibble, utils

## Item 1-Merges the training and the test sets to create one data set.

## Check working directory points to the folder with the unzipped data
# --- Ensure getwd() shows the directory containing "UCI HAR Dataset"

getwd()
## Unzip the dataset
unzip("getdata_projectfiles_UCI HAR Dataset.zip")

## Verify working directory contains the zip file
print(getwd())
## Printing the directory shows location; use ....and confirm
file.exists("getdata_projectfiles_UCI HAR Dataset.zip")

## PREPPING
## Confirming training fetrue, activity, and subject data. 
## To store each dataset separately for merging later without overwriting or losing raw data.
train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
## Loads test feature, activity, and subject data. Confirming and prepping. 
test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
## Next-confirm structure with dim to verify matching columns before merging. Matching data dimensions. 
dim(train_x)
dim(test_x)
dim(train_y)
dim(test_y)
dim(subject_train)
dim(subject_test)
## RESULTS- Training and test datasets share identical column structures, 
## confirming compatibility for accurate merging.
## All is good
## Using rbind() to stack training and test data vertically, creating one unified dataset.
## It safely merges rows with identical column structures, preserving all observations for analysis.
merged_x <- rbind(train_x, test_x)
merged_y <- rbind(train_y, test_y)
merged_subject <- rbind(subject_train, subject_test)
## We first merged training and test sets individually, 
## then combined all into one complete dataset for analysis.
complete_data <- cbind(merged_subject, merged_y, merged_x)
head(complete_data)
## dim provided 10299 x 563 
dim(complete_data)

## END Item 1

## Item 2-Extracts only the measurements on the means and standard deviation for 
## each measurement. 

features <- read.table("UCI HAR Dataset/features.txt")
mean_std <- grep("mean\\(\\)|std\\(\\)", features$V2)
extracted_data <- complete_data[, c(1, 2, mean_std + 2)]
# Verify Extracted Data using dim. 
dim(extracted_data)
## 10299 x 68

## End

## Item 3-Uses descriptive activity names to name the activities in the data set
## Activity Names addressed - WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
## Before change
table(extracted_data$V1.1)
## After Change
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
extracted_data$V1.1 <- factor(extracted_data$V1.1, levels = activity_labels$V1, labels = activity_labels$V2)
## Confirming Name Changes
table(extracted_data$V1.1)

## END

## Item 4 Appropriately labels the data set with descriptive variable names. 
## Assigns clear, descriptive variable names to all dataset columns as requested.
names(extracted_data) <- c("subject", "activity", features$V2[mean_std])
## Confimation we succeeded. 
head(names(extracted_data))
## Confirmed

## END

## Item 5-From the data set in step 4, creates a second, independent tidy data 
## set with the average of each variable for each activity and each subject. 
## Creates tidy dataset with averages per subject and activity.
## Dont forget to load dplyr and tidyr
library(dplyr)
tidy_data <- extracted_data %>%
    group_by(subject, activity) %>%
    summarise_all(mean)

## tidy_data
## Make sure tibble is loaded. 
tidy_data
##PROJECT END

