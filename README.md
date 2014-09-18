---
title: "ReadMe"
author: "Ronen"
date: "Thursday, September 18, 2014"
output: html_document
---
##Data
The data was collected during experiments that have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

the figure below show the different pieces of data and how they fit together.
![alt text](https://coursera-forum-screenshots.s3.amazonaws.com/ab/a2776024af11e4a69d5576f8bc8459/Slide2.png)

##Purpose
Prepare the data for analysis, by running different transformations, that in principle will glue together all the different data pieces as shown in the figure below, and afterward run a simple analysis that calculate the mean for each measurement per subject and activity.

##Transformation
###1. Merges the training and the test data to create one dataset.
According to the ReadMe file, training data is stored in 'train/X_train.txt' and test data in 'test/X_test.txt'. 
The files were read into separate data frames. Because the variable names are given in a separate file, it is safe to believe that the file doesn't have a header, in addition the column separator is not given, hence the separator parameter was left empty letting read.table() identify it automatically.

Before trying to merge the two files, the files were verified using the dim() function, to have the same number of columns. 

As expected the two files have the same number of columns and different number of rows.

The rbind() function was used to vertically merge the two data frames together.


###2. Extracts only the measurements on the mean and standard deviation for each measurement.
In order to select the columns that correspond to the above criteria the variable names were appended into the merged data.frame, the features text file was read and the second column representing the variable name was selected and assigned into a variable which was converted into a character vector.
This character vector was assigned to the column names using the names() function.

to extract variables that measure the mean and standard deviation, it is safe to assume that these variables has either mean() or std() keyword contained in the column name.
To select these columns the following Regular Expression was defined and assigned to the matches parameter of the select() function, that extract the relevant measurements

Regular Expression: "-(mean|std)[()]"


###3. Uses descriptive activity names to name the activities in the data set
The activity data from the training dataset was read into a data frame “trainActivty” and merged into the train data frame.
the activity data from the test dataset was read into a data frame “testActivity” and merged into the test data frame.
the two data frames were merged into the existing “merge” data frame, using the rbind().
the activity code was copied into a new column using the transform() function, to prepare for the update of the activity name without losing the activity code. a series of 6 gsub() calls were made in order to decode the activity code into a descriptive name.


###4. Appropriately labels the data set with descriptive variable names.
The features text file was read and the second column representing the variable name was selected and assigned into a variable which was converted into a character vector.
This character vector was assigned to the column names using the names() function.
a second call to the names() funcation was made to update the title of the two newly added columns “ActivityCode” and “ActivtyName”.


###5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
The subject information of the training data was read into the “trainSubject” data frame .
the subject information of the test data was read into the “testSubject” data frame.
the two datasets were merged using the rbind() function into the “subject” data frame.
then the “subject” data frame was merged into the “merge” data frame.
the subject variable column name was updated to “subject” using the names() function.
now the dataset is prepared for analysis. first the data was grouped by 
activity and subject, and afterwards using the summarize_each() from the latest version of dplyr package the average for each variable was calculated.
please note that the number of rows in tidy data frame correspond to the number of subject (30) multiply by number of activities (6) which results in 180 rows.
the number of columns is 480 and is less compare to the original data set since the summarize_each() function collapse identical variables.

