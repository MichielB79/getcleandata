# Introduction

For the Getting and Cleaning Data course the assignment is to create a R script called run_analysis.R.
The goal is to prepare tidy data that can be used for later analysis. This repository contains the R file I created, along with the readme file and a codebook.

A full description is available at the site where the data was obtained: 

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones> 

Here are the data for the project: 

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

The file has to do the following:
 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Description of the script

The script `run_analysis.R` will do the following procedures:

1. Creates a directory 'data', if it doesn't exist, and download & unzip the data
2. Reads feature and activity labels
3. Reads data and assign labels
4. Merge all data (training and test sets) and remove temporary files
5. Extract only the measurements on the mean and standard deviation for each measurement
6. Create descriptive activity names and add the names to the data
7. Create and write a tidy data set, then remove temporary files
8. Creates a second, independent tidy data set with the average of each variable for each activity and each subject

### How to use the script

1. First set the working directory where you want to create the tidy data sets
2. Save the script in the working directory and run the script in R `source("run_analysis.R")`
3. Three datasets will be created in the working directory: 
  - `tidy_data_set.csv`
  - `tidy_avg_data_set.csv`
  - `tidy_avg_data_set.txt`

### Reference
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012