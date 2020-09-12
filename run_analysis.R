run_analysis <- function(){
    
    ## Step 0: Read in the data sets required
    width <- fwf_widths(replicate(561, 16))
    x_test <- read_fwf("./data/test/X_test.txt", width)
    x_train <- read_fwf("./data/train/X_train.txt", width)
    y_test <- read.delim("./data/test/y_test.txt", header=FALSE)
    y_train <- read.delim("./data/train/y_train.txt", header=FALSE)
    test_subj <- read.delim("./data/test/subject_test.txt", header=FALSE)
    train_subj <- read.delim("./data/train/subject_train.txt", header=FALSE)
    
    
    ## Step 1: Merges test and train data to create one data set
    test <- cbind(y_test, test_subj, x_test)
    train <- cbind(y_train, train_subj, x_train)
    merge <- rbind(test, train)
    
    
    ## Step 4: Use appropriate labels for the data set
    features <- read.delim("./data/features.txt", header=FALSE, sep=" ")[,2]
    colnames(merge) <- c("activity", "subject", features)
    
    
    ## Step 2: Extract only the measurements for mean and standard deviation
    index <- grep("(mean|std)", features)
    index <- index + 2
    filt <- arrange(merge[,c(1:2,index)], activity, subject)
    
    
    ## Step 3: Use descriptive activity names
    acts <- read.delim("./data/activity_labels.txt", header=FALSE, sep=" ")
    ax <- filt$activity
    
    for(i in 1:6){
        ax[which(ax==acts[i,1])] <- acts[i,2]}
    filt$activity <- ax
    
    
    ## Step 5: Creates a second data set with the average of each variable.
    avg <- filt
    split <- avg %>% group_by(activity, subject) %>% 
        dplyr::summarise(across(1:(ncol(avg)-2), mean))
    write.table(split, "AvgTestTrainData.txt", sep="\t", row.names=FALSE)
}