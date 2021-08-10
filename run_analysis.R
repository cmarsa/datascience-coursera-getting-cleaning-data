# run_analysis.R
# load libraries
library(tidyverse)
library(janitor)

# load labels
activity_labels <- read.table("data/UCI-HAR-Dataset/activity_labels.txt")
activity_labels[ , 2] <- as.character(activity_labels[,2])
feature_labels <- read.table("data/UCI-HAR-Dataset/features.txt")
feature_labels[ , 2] <- as.character(features[,2])

# filter feature labels to get just std-dev and mean statistics
feature_labels <- filter(feature_labels, str_detect(V2, 'mean|std'))

# load and bind training data
train_X <- read.table("data/UCI-HAR-Dataset/train/X_train.txt")[, feature_labels$V1]
train_y <- read.table('data/UCI-HAR-Dataset/train/y_train.txt')
train_subject <- read.table("data/UCI-HAR-Dataset/train/subject_train.txt")
train_data <- cbind(train_subject, train_y, train_X)

# load and bind test data
test_X <- read.table("data/UCI-HAR-Dataset/test/X_test.txt")[, feature_labels$V1]
test_y <- read.table('data/UCI-HAR-Dataset/test/y_test.txt')
test_subject <- read.table("data/UCI-HAR-Dataset/test/subject_test.txt")
test_data <- cbind(test_subject, test_y, test_X)

# stack train and test data
complete <- rbind(train_data, test_data)
colnames(complete) <- c("subject", "activity", feature_labels$V2) |>
    make_clean_names()

# group by activity and subject and get mean
# from every statistic
summarized <- group_by(complete, activity, subject) |>
    summarize_all(mean)

# create directory out if not existd
if (!dir.exists('out')) {
    dir.create('out')
}
# write output dataset and the column names of the dataset
write.table(summarized, "out/summary_dataset.txt", row.names = FALSE, quote = FALSE)
write.table(colnames(summarized), "out/column_names.txt", row.names = FALSE, quote = FALSE)

