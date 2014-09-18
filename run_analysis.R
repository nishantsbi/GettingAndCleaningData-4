library(dplyr)
--------------------------------------------------------------------------
# 1. Merges the training and the test data to create one data set.
--------------------------------------------------------------------------
  # read training data
      train <- read.table("train/X_train.txt", header=FALSE)
  # read test data  
      test  <- read.table("test/X_test.txt", header=FALSE)
  # merge the two datasets
      merge <- rbind(train, test)

---------------------------------------------------------------------------
# 2.Extracts only the measurements on the mean and standard deviation for each measurement.
---------------------------------------------------------------------------
  # read features.txt
      features <- read.table("features.txt",stringsAsFactors=FALSE)
      features <- as.vector(features[,2])
  # update column names
      names(merge) <- features
  # define the necessary  regular expression     
      regex <- c("-(mean|std)[()]") 
  # extract the relevant variables 
      measurements <- select(merge, matches(regex))

--------------------------------------------------------------------------
# 3.Uses descriptive activity names to name the activities in the data set
--------------------------------------------------------------------------
  # read train activity data    
      trainActivity <- read.table("train/y_train.txt", header=FALSE)
  # merge train data with activity codes
      train <- cbind(train, trainActivity)
  # read test activity data
      testActivity <- read.table("test/y_test.txt", header=FALSE)
  # merge test data with activity codes
      test <- cbind(test, testActivity)
  # merge train and test data sets
      merge <- rbind (train,test)
  # add column ActivityName and copy to it the activity code
      merge <- transform(merge, ActivityName=merge[[562]] )
  # update activity names
      merge$ActivityName <- gsub("1", "WALKING", merge$ActivityName)
      merge$ActivityName <- gsub("2", "WALKING_UPSTAIRS", merge$ActivityName)
      merge$ActivityName <- gsub("3", "WALKING_DOWNSTAIRS", merge$ActivityName)
      merge$ActivityName <- gsub("4", "SITTING", merge$ActivityName)
      merge$ActivityName <- gsub("5", "STANDING", merge$ActivityName)
      merge$ActivityName <- gsub("6", "LAYING", merge$ActivityName)

----------------------------------------------------------------------          
# 4.Appropriately labels the data set with descriptive variable names.
----------------------------------------------------------------------
  # read features.txt
     features <- read.table("features.txt",stringsAsFactors=FALSE)
     features <- as.vector(features[,2])
  # update column names    
     names(merge) <- c(features,c("ActivityCode","ActivityName"))

----------------------------------------------------------------------------
# 5.From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
----------------------------------------------------------------------------
  # read train subject data    
      trainSubject <- read.table("train/subject_train.txt", header=FALSE) 
  # read test subject data
      testSubject <- read.table("test/subject_test.txt", header=FALSE)
  # merge train and test subjects data
      subject <- rbind(trainSubject, testSubject)
  # combine merged data set and subject data
      merge <- cbind (merge,subject)
  # update the subject column name    
      names(merge)[564] <- "Subject"
  # summarize a tidy data set
      tidy <- merge %>% 
      group_by(ActivityCode, ActivityName, Subject) %>% 
      summarise_each(funs(mean))
  # write tidy data to a text file
      write.table(tidy, file="tidy.csv", sep=",", row.names = FALSE, col.names = TRUE)
