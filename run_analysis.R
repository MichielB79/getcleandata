## Create one R script called run_analysis.R that does the following: 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. Creates a second (from data set 4), independent tidy data set with the average of each variable for each activity and each subject.


# Part 1: Create a directory data, if it doesn't exist, and download & unzip the data
  if(!file.exists("data")) {
    message("Directory 'data' created")
    dir.create("data")
  }
  
  if(!file.exists("data/UCI HAR Dataset")) {
    message("Download dataset")
    
    file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(file_url, destfile="./data/data.zip")
    date.downloaded <- date()
    list.files("./data")
    unzip("./data/data.zip", exdir="data")
  }


# Part 2: Read feature and activity labels
  features <- read.table("./data/UCI HAR Dataset/features.txt")
  names(features) <- c('id', 'name')
  
  activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
  names(activity_labels) <- c('id','name')


# Part 3: Read data and assign labels
  training_x <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
  names(training_x) <- features$name
  
  test_x <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
  names(test_x) <- features$name
  
  training_y <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
  names(training_y) <- c('activity')
  
  test_y <- read.table("./data/UCI HAR Dataset/test/y_test.txt")   
  names(test_y) <- c('activity')
    
  training_subject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
  names(training_subject) <- c('subject')
    
  test_subject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
  names(test_subject) <- c('subject')    

  
# Part 4: Merge all data and remove temporary files
  merge_x <- rbind(training_x, test_x)
  merge_y <- rbind(training_y, test_y) 
  merge_subject <- rbind(training_subject, test_subject)
  rm("training_x", "training_y", "test_x","test_y", "training_subject", "test_subject")

  
# Part 5: Extract only the measurements on the mean and standard deviation for each measurement
  merge_x_extract <- merge_x[, !grepl("meanFreq", features$name)]
  features_2 <- features[!grepl("meanFreq", features$name), ]
  merge_x_extract <- merge_x_extract[, grepl("mean|std", features_2$name)]
 
  
# Part 6: Create descriptive activity names and add the names to the data
  merge_y$activity <- activity_labels[merge_y$activity,]$name

  
# Part 7: Create and write a tidy data set, then remove temporary files
  tidy_data_set <- cbind(merge_subject, merge_y, merge_x_extract)
  write.csv(tidy_data_set, file="tidy_data_set.csv")
  rm("merge_x", "merge_y", "merge_x_extract", "merge_subject")

# Part 8: Creates a second, independent tidy data set with the average of each variable for each activity and each subject
  tidy_avg_data_set <- aggregate(tidy_data_set[,3:dim(tidy_data_set)[2]], list(tidy_data_set$activity, tidy_data_set$subject), mean)
  names(tidy_avg_data_set)[1:2] <- c('activity', 'subject')
  write.csv(tidy_avg_data_set, file="tidy_avg_data_set.csv")
  write.table(tidy_avg_data_set, file="tidy_avg_data_set.txt", row.name=FALSE)