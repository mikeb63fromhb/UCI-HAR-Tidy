##CODEBOOK

## VARIABLES 
## train_x – Training set features loaded from sensor data file.

## train_y – Activity IDs corresponding to each training record.

## subject_train – Subject identifiers for each training observation.

## test_x – Test set features loaded for evaluation.

## test_y – Activity IDs for the test observations.

## subject_test – Subject identifiers for test records.

## merged_x – Combined training and test feature measurements.

## merged_y – Combined training and test activity identifiers.

## merged_subject – Combined subject identifiers from train and test sets.

## complete_data – Unified dataset containing all subjects, activities, features.

## features – List of all feature names from features.txt.

## mean_std – Indexes selecting mean and standard deviation features.

## extracted_data – Subset with only mean and std variables.

## activity_labels – Table mapping activity codes to descriptive names.

## tidy_data – Final summarized tidy dataset grouped by subject, activity.



## TRANSFORMATIONS

## Read training and test data files using read.table().

## Merged datasets vertically with rbind() and horizontally with cbind().

## Extracted only mean and standard deviation features using grep().

## Applied descriptive activity names with factor().

## Assigned readable variable names from features.txt using names().

## Grouped by subject and activity with group_by().

## Summarized averages for all variables using summarise_all(mean).

## Exported final tidy dataset using write.table().
