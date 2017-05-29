## Output

* run_analysis.R - contains the code for the assignment 
* tidyset.txt - contains the output of summarized data set with write.table() command

## Process
Start by reading text files in the folder into respective variables. The following variables are created: 
Column names are assigned colnames(activities) = c('activity_id','activity'); colnames(subject_train) = "sub_id"; colnames(x_train) = features[,2]; colnames(y_train) = "activity_id"; colnames(subject_test) = "sub_id"; colnames(x_test) = features[,2]; colnames(y_test) = "activity_id";

#1. Merges the training and the test sets to create one data set.

Use cbind and rbind to create merged dataset.

#2. Extracts only the measurements on the mean and standard deviation for each measurement.

identify all columns which contain either mean or std in their name add them to a new dataset called subset1

#3. Uses descriptive activity names to name the activities in the data set

Use levels to change activity IDs to activity names

#4. Appropriately labels the data set with descriptive variable names.

Part of this was achieved when we provide column names to the dataset. For additional updates, we try to remove dog characters and convert some shot names to full names.

#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. use group_by and summarize to create a shortened dataset.

## Variables created

#### for loading datasets
* features 
* activities
* x_test 
* y_test 
* subject_test
* x_train 
* y_train 
* subject_train

#### for merging datasets
* training_data_set
* test_data_set
* merge_set

#### creating subsets
* subset1
* tidyset
