# GettingAndCleaningData

This function starts from reading the following data:
1. subject_train : Subject performing the activities (70% of total)
2. y_train       : Activity code number (70% of total)
3. X_train       : Experimental observations (70% of total)
4. subject_test  : Subject performing the activities (30% of total)
5. y_test        : Activity code number (30% of total)
6. X_test        : Experimental observations (30% of total)

# Merging the data
Using the first block of the code, the 6 data tables were merged into one big table
code used: cbind and rbind

# Selecting the required data
Using 'features.txt', only variables with mean() and std() were selected
code used: grep and select(dplyr)

# Naming the activity
Using 'activity_labels.txt', we translate the code numbers to the readable activity names 
code used: for loop and if clause

# Naming the variables
Using 'features.txt', the column names of the data set were renamed, without the special characters
code used: sub, gsub, and names

# Creating tidy data set
Since we have multiple observations for the same subject and activity, the average of those observations is taken.
The result is a tidy data set where 1 row represents the experimental results of 1 subject in 1 activity.
code used: group_by(dplyr) and summarize_at (dplyr)
