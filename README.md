# datascience-coursera-getting-cleaning-data
Getting and cleaning data course from data science specialziation JHU and Courera.


## Requirements
You should create one R script called `run_analysis.R` that does the following. 

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## About the project

The main script is `run_analysis.R` which loads `UCI-HAR-Dataset` from the `data` directory and selects
a subset of the features, namely the ones that are summaries of the signals of the statistics mean and standard deviation.
After the selection of these features a summarization of these statistics is done on a grouped by `activity` and `subject` basis.

The output file is located at `out/summary_dataset.txt`.

The file `codebook.md` is a datacatalog of the dataset.