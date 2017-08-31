#Here I am loading the feature data and the activity labels which are very useful for understanding the dataset.
FeatureData <- read.delim("UCI HAR Dataset/features.txt", header = FALSE, sep = " ")
ActivityLabels <- read.delim("UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = " ")


#"1. Merges the training and the test sets to create one data set."

#I then begin to merge the training and test data. Here I am starting with the X data and creating a file called X_merged.
X_train <- read.table(file = "UCI HAR Dataset/train/X_train.txt", col.names = FeatureData[,2])
X_test <- read.table(file = "UCI HAR Dataset/test/X_test.txt", col.names = FeatureData[,2])
X_merged <- rbind(X_train, X_test)
rm(X_train, X_test)

#Then I merge the Y data and make it into a factor type.
y_train <- read.table(file = "UCI HAR Dataset/train/y_train.txt", col.names = 'Activity')
y_test <- read.table(file = "UCI HAR Dataset/test/y_test.txt", col.names = 'Activity')
y_merged <- rbind(y_train, y_test)
rm(y_train, y_test)
y_merged$Activity <- as.factor(y_merged$Activity)

#and finally I merge the subject data
subject_train <- read.table(file = "UCI HAR Dataset/train/subject_train.txt", col.names = 'Subject')
subject_test <- read.table(file = "UCI HAR Dataset/test/subject_test.txt", col.names = 'Subject')
subject_merged <- rbind(subject_train, subject_test)
rm(subject_train, subject_test)

#2. 'Extracts only the measurements on the mean and standard deviation for each measurement.'

#After this, I identify the features which mention "mean" or "std" in them. I then create a new variable which only contains data refering to the mean and stardard deviation.
ColumnsToUse <- grep("std|mean", FeatureData[,2])
tidyX <- X_merged[,ColumnsToUse]

#"3. Uses descriptive activity names to name the activities in the data set"

#Here I'm making the activity labels a bit clearer, so we see the character label and not the numeric key.
y_merged$Activity <- factor(x = y_merged$Activity, labels = ActivityLabels$V2)

#"4. Appropriately labels the data set with descriptive variable names."

#Here, I'm trying to make the X columnnames a bit more descriptive. I read the "feaures_info.txt" file contained in the "UCI HAR Dataset" and decided to make the following subsitutions: -

tidyXcols <- sub(pattern = "fBody", replacement = "frequency domain body ", x = colnames(tidyX))
tidyXcols <- sub(pattern = "tBody", replacement = "time domain body ", x = tidyXcols)
tidyXcols <- sub(pattern = "Body", replacement = "", x = tidyXcols)
tidyXcols <- sub(pattern = "tGravity", replacement = "time domain gravity ", x = tidyXcols)
tidyXcols <- sub(pattern = "AccJerk", replacement = "jerk linear acceleration ", x = tidyXcols)
tidyXcols <- sub(pattern = "GyroJerk", replacement = "jerk angular velocity ", x = tidyXcols)
tidyXcols <- sub(pattern = "AccMag", replacement = "linear acceleration magnitude ", x = tidyXcols)
tidyXcols <- sub(pattern = "GyroMag", replacement = "angular velocity magnitude ", x = tidyXcols)
tidyXcols <- sub(pattern = "Mag", replacement = "magnitude ", x = tidyXcols)
tidyXcols <- sub(pattern = "Acc", replacement = "acceleration ", x = tidyXcols)
tidyXcols <- sub(pattern = "Gyro", replacement = "angular velocity ", x = tidyXcols)
tidyXcols <- sub(pattern = ".mean", replacement = "mean ", x = tidyXcols)
tidyXcols <- sub(pattern = "Freq", replacement = "frequency ", x = tidyXcols)
tidyXcols <- sub(pattern = ".std", replacement = "standard deviation ", x = tidyXcols)
tidyXcols <- sub(pattern = "\\..", replacement = "", x = tidyXcols)
tidyXcols <- sub(pattern = ".X", replacement = "in direction X", x = tidyXcols)
tidyXcols <- sub(pattern = ".Y", replacement = "in direction Y", x = tidyXcols)
tidyXcols <- sub(pattern = ".Z", replacement = "in direction Z", x = tidyXcols)
colnames(tidyX) <- tidyXcols

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidy_dataset <- cbind(tidyX, y_merged, subject_merged)


library(dplyr)

TidyCodeBook <- tidy_dataset %>% group_by(Subject) %>% group_by(Activity, add = TRUE) %>% summarise_all(mean)
write.table(TidyCodeBook, row.names = FALSE, file = 'TidyCodeBook_MAL.txt')


