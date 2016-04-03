# Codebook

## Original data
The original data was obtained from [this location] on the 4th of March 2016.

## Transformed data
The original data is combined and transformed to create two data sets: total_data.txt and summerized_data.txt.

##### total_data.txt
The orginal data consists of multiple files. These files were merged to get one data set that includes the training and test data, the activity labes, the subject labels, and descriptive variable names. The data was filtered to only include the variables that were the mean or the standard deviaton for each measurement.

##### summerized_data.txt
From the data in total_data.txt, a second independent tidy data is created. This set contains the average of each variable for each activity and each subject.

## Combinations and transformations
All transformation and combinations to the original data are applied using the "run_analysis.R" file. In this file the following is done:

* Load the measurement data into memory
* Select only the columns with mean() or std() in their name
* Add the activity labels
* Rename the activity labes to a more descriptive name
* Write the data to a text file
* Take the averages for each combination of activity and subject and write it to a text file

More details can be found in the "run_analysis.R" file, which has numerous comments on the exact working.

[this location]: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>