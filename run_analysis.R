##  1. Download the data 
library(data.table)
fileUrl = 'archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI HAR Dataset.zip'
if (!file.exists('.UCI HAR Dataset.zip')) {
        download.file(fileUrl,'./UCI HAR Dataset.zip', mode = 'wb')
        unzip("UCI HAR Dataset.zip", exdir = './')
}
##  2. Load the data into the variable names (features) and 2 data frames (train and test)
features <- read.csv('./UCI HAR Dataset/features.txt', header=FALSE, sep = ' ')
features <- as.character(features[,2])

data_train_x <- read.table('./UCI HAR Dataset/train/X_train.txt')
data_train_y <- read.csv('./UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')
data_train_subject <- read.csv('./UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')
data_train <-  data.frame(data_train_subject, data_train_y, data_train_x)
names(data_train) <- c(c('subject', 'activity'), features)

data_test_x <- read.table('./UCI HAR Dataset/test/X_test.txt')
data_test_y <- read.csv('./UCI HAR Dataset/test/y_test.txt', header=FALSE, sep=' ')
data_test_subject <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header=FALSE, sep=' ')
data_test <- data.frame(data_test_subject, data_test_y, data_test_x)
names(data_test) <- c(c('subject', 'activity'), features)

##  3.  Merge the two data frames together

data_comb <- rbind(data_train, data_test)

##  4.  Extract the mean and standard deviation for each measurement and store in new data frame

extract_col <- grep('mean|std', features)
data_mean_std <- data_comb[,c(1,2,extract_col + 2)]

##  5.  Apply the activity names from the activity labels text file to the activity column

activity_names <- read.table('./UCI HAR Dataset/activity_labels.txt', header=FALSE)
activity_names <- as.character(activity_names[,2])
data_mean_std$activity <- activity_names[data_mean_std$activity]

##  6.  Apply more descriptive variable names to the data frame

df_names_new <- names(data_mean_std)
df_names_new <- gsub("[(][)]", "", df_names_new)
df_names_new <- gsub("^t", "Time_", df_names_new)
df_names_new <- gsub("^f", "Frequency_", df_names_new)
df_names_new <- gsub("Acc", "Accelerometer", df_names_new)
df_names_new <- gsub("Gyro", "Gyroscope", df_names_new)
df_names_new <- gsub("Mag", "Magnitude", df_names_new)
df_names_new <- gsub("-mean-", "_Mean_", df_names_new)
df_names_new <- gsub("-std-", "_StandardDeviation_", df_names_new)
df_names_new <- gsub("-", "_", df_names_new)
names(data_mean_std) <- df_names_new

##  7.  Create a second tidy dataset from the data_mean_std data frame

data_tidy <- aggregate(data_mean_std[,3:81], 
          by = list(activity = data_mean_std$activity, subject = data_mean_std$subject),FUN = mean)
write.table(x=data_tidy, file = "data_tidy.txt", row.names = FALSE)

