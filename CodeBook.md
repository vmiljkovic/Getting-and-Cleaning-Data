Course Project Code Book

- Merges the training and test sets to create one data set, merge train/X_train.txt with test/X_test.txt, 
the result is a 10299x561 data frame has Number of Rows: 10299 and Number of Columns: 561, 
merge train/subject_train.txt with test/subject_test.txt, the result is a 10299x1 data frame, 
and merge train/y_train.txt with test/y_test.txt, the result is 10299x1 data frame.

- Reads features.txt and extracts the measurements on the mean and standard deviation for each measurement. 
The result is a 10299x66 data frame, because 66 out of 561 attributes are measurements on the mean and standard deviation.

- Reads activity_labels.txt and applies descriptive activity names to name the activities in the data set

- The script also appropriately labels the data set with descriptive names: all feature names 
and activity names are converted to lower case, underscores and brackets are removed. 
Then, we merge the 10299x66 data frame containing features with 10299x1 data frames containing activity labels and subject IDs. 
The result is saved as final_data.txt, a 10299x68 data frame such that the first column contains subject IDs, 
the second column activity names, and the last 66 columns are measurements. Subject IDs are integers between 1 and 30. 
The names of the features are taken from features.txt file.

- Finally, the script creates a 2nd, independent tidy data set with the average of each measurement for each activity 
and each subject. The result is saved as final_data_averages.txt, a 180x68 data frame (30 unique subjects x 6 activities = 180 rows), 
the first column contains subject IDs, the second column contains activity names (see below), 
and then the averages for each of the 66 attributes are in columns 3...68.
