# UCI-HAR-Tidy
TOOLBOX MOD-4 PROJECT
Intro
This project processes the UCI Human Activity Recognition Using Smartphones dataset into a clean, tidy form suitable for later statistical analysis. The script merges raw files, extracts relevant measurements, renames variables descriptively, and outputs a summarized dataset with averages per subject and activity.


Packages Overview
We use dplyr, tidyr, data.table, tibble, and utils. These packages simplify data manipulation, grouping, reading large text files, and reshaping datasets. They ensure efficiency and clarity when merging, filtering, labeling, and summarizing large structured data.

## PACKAGES TO MY RECOLLECTION: dplyr, tidyr, data.table, tibble, utils

## END

Item 1 Overview
This section loads and merges the training and test datasets. Using read.table(), all six source files (features, activity, subject) are read into R for both sets. rbind() vertically stacks training and test data to preserve all records. Then cbind() horizontally joins subject, activity, and measurement tables into one combined dataset. Verification through dim() ensures consistency before proceeding.

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


Item 2 Overview
Here, the script narrows the dataset to only the mean and standard deviation measurements. The features.txt file lists all available variables. Using grep("mean\\(\\)|std\\(\\)", features$V2), only mean and std-related features are selected. These indices guide subsetting of complete_data, retaining subject and activity columns along with relevant measurement columns.

## Item 2-Extracts only the measurements on the means and standard deviation for 
## each measurement. 

features <- read.table("UCI HAR Dataset/features.txt")
mean_std <- grep("mean\\(\\)|std\\(\\)", features$V2)
extracted_data <- complete_data[, c(1, 2, mean_std + 2)]
# Verify Extracted Data using dim. 
dim(extracted_data)
## 10299 x 68

## End

Item 3 Overview
This section assigns descriptive names to activities. The activity_labels.txt file provides readable names mapped to numerical codes. The script converts the activity column into a factor using factor() with levels and labels arguments. This transformation replaces integers with descriptive labels such as “WALKING” or “LAYING,” improving interpretability.

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

Item 4 Overview
In this stage, variable names are applied to the dataset for clarity. The script uses names() to assign column names consisting of “subject,” “activity,” and the corresponding feature names from features.txt. This ensures that each measurement column has a descriptive and consistent title directly linked to the original dataset definition.

## Item 4 Appropriately labels the data set with descriptive variable names. 
## Assigns clear, descriptive variable names to all dataset columns as requested.
names(extracted_data) <- c("subject", "activity", features$V2[mean_std])
## Confimation we succeeded. 
head(names(extracted_data))
## Confirmed

## END

Item 5 Overview
This section produces the final tidy dataset. After loading dplyr, the script groups data by subject and activity using group_by(). It then computes the mean for all other variables with summarise_all(mean). The resulting dataset—stored as tidy_data—contains one observation per subject-activity pair, summarizing all mean and standard deviation features.

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







**********
