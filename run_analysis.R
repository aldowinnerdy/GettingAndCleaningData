run_analysis <- function() {
    ## Loading library
    library(dplyr)
    
    ## Reading the data sets
    subject_train <- read.table('UCI HAR Dataset/train/subject_train.txt')
    y_train <- read.table('UCI HAR Dataset/train/y_train.txt')
    X_train <- read.table('UCI HAR Dataset/train/X_train.txt')
    
    subject_test <- read.table('UCI HAR Dataset/test/subject_test.txt')
    y_test <- read.table('UCI HAR Dataset/test/y_test.txt')
    X_test <- read.table('UCI HAR Dataset/test/X_test.txt')
    
    features <- read.table('UCI HAR Dataset/features.txt')
    act_label <- read.table('UCI HAR Dataset/activity_labels.txt')
    
    ## Merging the data sets
    data_set <- rbind((cbind(subject_train, y_train, X_train)), (cbind(subject_test, y_test, X_test)))
    names(data_set)[1:2] <- c('subject', 'activity')
    
    ## Selecting required mean and standard deviation measurements
    req_index <- grep('(mean[(])|(std[(])', features$V2)
    req_set <- select(data_set, c(1,2, req_index+2))
    
    ## Naming the activity
    for(i in 1:length(req_set$activity)) {
        for(j in 1:6) {
            if(req_set[i,2] == j) {req_set[i,2] <- as.character(act_label$V2[j])}
        }
    }
    
    ## Naming the variables
    req_names <- as.character(features$V2[req_index])
    req_names <- sub('[(][)]', '', req_names)
    req_names <- gsub('-', '', req_names)
    names(req_set)[3:68] <- req_names
    
    ## Create another tidy data set
    req_set <- group_by(req_set, subject, activity)
    tidy_data <- summarize_at(req_set, 3:68, mean)
    
    tidy_data
}