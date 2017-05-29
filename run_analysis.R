setwd("C:/Users/nksehdev/Desktop/UCI HAR Dataset")
features     = read.table('./features.txt',header=FALSE); 
activities = read.table('./activity_labels.txt',header=FALSE, stringsAsFactors = FALSE); 


x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")

x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")

# give column names
colnames(activities)  = c('activity_id','activity');
colnames(subject_train)  = "sub_id";
colnames(x_train)        = features[,2]; 
colnames(y_train)        = "activity_id";
colnames(subject_test) = "sub_id";
colnames(x_test)       = features[,2]; 
colnames(y_test)       = "activity_id";

#1. Merges the training and the test sets to create one data set.
training_data_set <- cbind(subject_train, y_train, x_train)
test_data_set <- cbind(subject_test, y_test, x_test)
merge_set <- rbind(training_data_set, test_data_set)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
merge_cols <-colnames(merge_set)
subset1 = merge_set[(grepl("activity..",merge_cols) | grepl("sub..",merge_cols) | grepl("-mean..",merge_cols) & !grepl("-meanFreq..",merge_cols) & !grepl("mean..-",merge_cols) | grepl("-std..",merge_cols) & !grepl("-std()..-",merge_cols))==TRUE]

#3. Uses descriptive activity names to name the activities in the data set
levels(subset1$activity_id) <-activities$activity

#4. Appropriately labels the data set with descriptive variable names.
subset1 <- subset1 %>% setNames(gsub("\\.", "", names(.)))
subset1 <- subset1 %>% setNames(gsub("\\()","", names(.)))
subset1 <- subset1 %>% setNames(gsub("std\\.\\.", "Std", names(.)))
subset1 <- subset1 %>% setNames(gsub("mean\\.\\.", "Mean", names(.)))
subset1 <- subset1 %>% setNames(gsub("^f", "Frequency", names(.)))
subset1 <- subset1 %>% setNames(gsub("^t", "Time", names(.)))
subset1 <- subset1 %>% setNames(gsub("Mag", "Magnitude", names(.)))
subset1 <- subset1 %>% setNames(gsub("[Gg]yro","Gyro", names(.)))
subset1 <- subset1 %>% setNames(gsub("Acc", "Accelerometer", names(.)))
subset1 <- subset1 %>% setNames(gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body", names(.)))

#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyset <- subset1 %>% group_by(sub_id, activity_id)
tidyset <- summary %>% summarize_each(funs(mean))
