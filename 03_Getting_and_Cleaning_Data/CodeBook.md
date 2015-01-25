# CodeBook for Getting and Cleaning Data Course Project 

## Libraries / Requirements

You need to install dplyr library. To do it, you have to execute the next command

    install_packages('dplyr')
    
To load the library, you need to execute the next command

    library(dplyr)

## Input Dataset
    
You have to download and unzip the dataset for the project in the same folder that source code is installed. You can find the dataset at [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Description of the Original Dataset

The dataset is related with a set of experiments that have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

For more detail about original datasets, vars, and other information, you could check the  following [link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Results

Results of analysis will be stored in the same folder with the names: **dataset_tidy.txt** and **dataset_tidy_mean.txt** for steps 4 and 5 of the analysis.

### Tidy Dataset

**Name File**: dataset_tidy.txt

It includes 68 observations of the original dataset related with measurements with mean and standard desviation. The name of the header has been change, removing the caracters ( and ). It also replaces the caracter "-" to "_" to let you access columns by column name.

To create the final tidy dataset, we merge the dataset from subject, replace the id of activity by its name and merge with the measurements.

All column names are in lowercase.

### Mean Tidy Dataset

**Name File**: dataset_tidy_mean.txt

It includes the same 68 observations but the values are the mean of the measurements by subject and activity.

