# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to 
# prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions 
# related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github 
# repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, 
# and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a 
# README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  
# 
# One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
#   
#   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
# 
# Here are the data for the project: 
#   
#   
# 
# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.

install.packages("dplyr")
library(dplyr)

#
# 1.- Merges the training and the test sets to create one data set.
#

# Function to get the merged dataset from two files with a prefix and a specific folder format (for this exercise the 
# dataset in in working folder)
mergeDatasets <- function(prefixName, basePath = ".") {
  df1 <- read.table(paste(basePath,"train", paste0(prefixName,"_train.txt"),sep='/'))
  df2 <- read.table(paste(basePath,"test", paste0(prefixName, "_test.txt"),sep='/'))
  rbind(df1,df2)
}

# Get datasets for "X", "y" and "subject"
dataset_X <- mergeDatasets("X")
dataset_Y <- mergeDatasets("y")
dataset_Subject <- mergeDatasets("subject")

#
# 2.- Extracts only the measurements on the mean and standard deviation for each measurement. 
#

# Read features file
dfFeatures <- read.table("features.txt", stringsAsFactors=FALSE)

# Find indexes to mean and standard deviation
indices_of_mean_and_sd <- grep("-mean\\(\\)|-std\\(\\)", dfFeatures[, 2])

# Get names of measurements
names_of_measurements <- dfFeatures[indices_of_mean_and_sd, 2]

# Remove () expresion to avoid problems to access by name
names_of_measurements <- tolower(gsub("\\(|\\)", "", names_of_measurements))
names_of_measurements <- gsub("-", "_", names_of_measurements)
  
# Select columns and assing name columns
dataset_X <- dataset_X[, indices_of_mean_and_sd]
names(dataset_X) <- names_of_measurements

#
# 3.- Uses descriptive activity names to name the activities in the data set
#

# Read Activities file
df_Activities <- read.table("activity_labels.txt")

# convert to lowcase and remove underscore character
df_Activities[, 2] = tolower(as.character(df_Activities[, 2]))

# Replace column values with activity name and name of column
dataset_Y[,1] = df_Activities[dataset_Y[,1], 2]
names(dataset_Y) <- c("activity")

#
# 4.- Appropriately labels the data set with descriptive variable names. 
#

# Assing name of Subjects and create the combined dataset
names(dataset_Subject) <- "subject"
dataset_tidy <- cbind(dataset_Subject, dataset_Y, dataset_X)

# Write in filesystem
write.table(dataset_tidy, "dataset_tidy.txt")

#
# 5.- From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.
#
resultMean <- dataset_tidy %>% arrange(subject, activity) %>% group_by(subject, activity) %>% summarise_each(funs(mean))
write.table(resultMean, "dataset_tidy_mean.txt", row.name=FALSE)