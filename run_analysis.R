
# 1. Merges the training and the test sets to create one data set.

X_train <- read.table("./train/X_train.txt")
X_test <- read.table("./test/X_test.txt")
X_data <- rbind(X_train, X_test)

subject_train <- read.table("./train/subject_train.txt")
subject_test <- read.table("./test/subject_test.txt")
subject_data <- rbind(subject_train, subject_test)

y_train <- read.table("./train/y_train.txt")
y_test <- read.table("./test/y_test.txt")
y_data <- rbind(y_train, y_test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

features <- read.table("./features.txt")
validIndex <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X_data <- X_data[, validIndex]
names(X_data) <- features[validIndex, 2]
names(X_data) <- gsub("\\(|\\)", "", names(X_data))
names(X_data) <- tolower(names(X_data))

# 3. Uses descriptive activity names to name the activities in the data set

activity_labels <- read.table("activity_labels.txt")
activity_labels[, 2] = gsub("_", "", tolower(as.character(activity_labels[, 2])))
y_data[,1] = activity_labels[y_data[,1], 2]
names(y_data) <- "activity"

# 4. Appropriately labels the data set with descriptive variable names.

names(subject_data) <- "subject"
cleaned <- cbind(subject_data, y_data, X_data)
write.table(cleaned, "final_data.txt")

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

uniqueSubjects = unique(subject_data)[,1]
numSubjects = length(unique(subject_data)[,1])
numActivities = length(activity_labels[,1])
numCols = dim(cleaned)[2]
result = cleaned[1:(numSubjects*numActivities), ]

row = 1
for (s in 1:numSubjects) {
        for (a in 1:numActivities) {
                result[row, 1] = uniqueSubjects[s]
                result[row, 2] = activity_labels[a, 2]
                temp <- cleaned[cleaned$subject == s & cleaned$activity == activity_labels[a, 2], ]
                result[row, 3:numCols] <- colMeans(temp[, 3:numCols])
                row = row + 1
        }
}
write.table(result, "final_data_averages.txt")
