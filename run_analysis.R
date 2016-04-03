# Clear workspace
rm(list = ls())
# Close all open plots
graphics.off()
# Clear the screen (only in RStudio)
cat("\014")

library(dplyr)

###############################################################
# Measurement data
###############################################################

# Read the measurement data
train <- read.table("train/X_train.txt", header = FALSE)
test <- read.table("test/X_test.txt", header = FALSE)

# Combine the training and test data into one data frame (called total)
total <- rbind(train, test)

###############################################################
# Features data
###############################################################

# Read the futures data
features <- read.table("features.txt", header = FALSE)

# Rename the variables in the "total" data frame to the feature names
colnames(total) <- features[,2]

###############################################################
# Selecting only the measurements on the mean and standard deviation
###############################################################

# Using grep to find the locations of variablenames with mean() or std()
c_meanstd <- grep("mean\\(\\)|std\\(\\)|(activity_name)|(subject)", names(total))

# Overwriting the "total" data frame to only include the columns found using grep
total <- total[,c_meanstd]

###############################################################
# Activity labels
###############################################################

# Read the activity labels for the train and test date
train_labels <- read.table("train/Y_train.txt", header = FALSE)
test_labels <- read.table("test/Y_test.txt", header = FALSE)

# Read the activity labels and the corresponding activity names, creates a "dictionary"
activity_labels_dictionary <- read.table("activity_labels.txt", header = FALSE)

# Translate each of the activity labels in the correct activity name, using the dictionary
for(i in 1:6) {test_labels$V1 <- gsub(activity_labels_dictionary[i,1],activity_labels_dictionary[i,2], test_labels$V1)}
for(i in 1:6) {train_labels$V1 <- gsub(activity_labels_dictionary[i,1],activity_labels_dictionary[i,2], train_labels$V1)}

# Insert the activity name into the "total" data frame
# This gives the appropriately labels to the data set, with descriptive variable names
total["activity_name"]  <- rbind(train_labels, test_labels)

###############################################################
# Subject data
###############################################################

# Read the subject data
subject_train <- read.table("train/subject_train.txt", header = FALSE)
subject_test <- read.table("test/subject_test.txt", header = FALSE)

# Insert the subject into the "total" data frame
total["subject"]  <- rbind(subject_train, subject_test)

###############################################################
# Write output, Part I
###############################################################

# Write "total" data frame to a text file called total_data.txt
write.table(total, "total_data.txt")

###############################################################
# Create data frame with means per subject and activity
###############################################################

# aggregate the means for all combinations of subject and activity
total %>%
aggregate(. ~ subject + activity_name, data = ., FUN = mean) %>%
# write the resulting data frame to a text file called summerized_data.txt
write.table("summerized_data.txt")