# Getting-and-Cleaning-Data-Course-Project

This script reads the "UCI HAR Dataset" and merges the training and test potions of the "X" "y" and "subject" data into a larger, combined dataset. The scipt then remove all columns from the "X" portion that do not contain the patterns "std." or "mean". To clarify the resulting data, the activity labels were converted into descriptive factors and the remaining X columns were renamed to be more readable.

After reading the "feaures_info.txt" file contained in the "UCI HAR Dataset" I decided to make the following substitutions using "sub": -

"fBody"-> "frequency domain body ", x = colnames(tidyX))
"tBody"-> "time domain body "
"Body"-> ""
"tGravity"->  "time domain gravity "
"AccJerk"->  "jerk linear acceleration "
"GyroJerk"->  "jerk angular velocity "
"AccMag"->  "linear acceleration magnitude "
"GyroMag"->  "angular velocity magnitude "
"Mag"->  "magnitude "
"Acc"->  "acceleration "
"Gyro"->  "angular velocity "
".mean"->  "mean "
"Freq"->  "frequency "
".std"->  "standard deviation "
".X"->  "in direction X"
".Y"->  "in direction Y"
".Z"->  "in direction Z"

Finally, using the gropup_by and summarise fucntions contained in "dplyr" I grouped the dataset by activity and subject and returned the mean in a file called 'TidyCodeBook_MAL.txt'.
