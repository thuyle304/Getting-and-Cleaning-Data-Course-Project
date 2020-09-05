# Read all the tables we need for cleaning and tidying and name all the columns with descriptive variable names.
X_train <- read.table("/Users/thuyle/Downloads/UCI HAR Dataset/train/X_train.txt", header = TRUE, stringsAsFactors = FALSE)
names(X_train) <- features[, 2]
Y_train <- read.table("/Users/thuyle/Downloads/UCI HAR Dataset/train/y_train.txt", header = TRUE, stringsAsFactors = FALSE)
names(Y_train) <- "activities"
Subject_train <- read.table("/Users/thuyle/Downloads/UCI HAR Dataset/train/subject_train.txt", header = TRUE, stringsAsFactors = FALSE)
names(Subject_train) <- "Subjects"
X_test <- read.table("/Users/thuyle/Downloads/UCI HAR Dataset/test/X_test.txt", header = TRUE, stringsAsFactors = FALSE)
names(X_test) <- features[, 2]
Y_test  <- read.table("/Users/thuyle/Downloads/UCI HAR Dataset/test/y_test.txt", header = TRUE, stringsAsFactors = FALSE)
names(Y_test) <- "activities"
Subject_test  <- read.table("/Users/thuyle/Downloads/UCI HAR Dataset/test/subject_test.txt", header = TRUE, stringsAsFactors = FALSE)
names(Subject_test) <- "Subjects"

# create the data sets for trained subjects and tested subjects respectively
train_data <- cbind(Subject_train, Y_train, X_train)
test_data <- cbind(Subject_test, Y_test, X_test)

# 1. Merges the training and the test sets to create one data set.
mdata <- rbind(train_data, test_data)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
 # Read the table of features 
 features <- read.table("/Users/thuyle/Downloads/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
 # Extract 
 mdata_extract <- mdata[ ,c("Subjects", "activities", grep("[Mm]ean|std", features$V2, value=TRUE) )]
 
# 3. Uses descriptive activity names to name the activities in the data set
  # Step 1: read the activity data set 
  activity<- read.table("/Users/thuyle/Downloads/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
  # Step 2: Create a function that return the name of each activity replace for 
  # the number coded for that activity than apply the dfunction to each element 
  # in the column of activity
  replace <- function(x) activity[x,2]
  mdata$activities = sapply(mdata$activities, replace)
# 4. Appropriately labels the data set with descriptive variable names: Did in 
# the first place when reading data set above 
# 5. From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.
library(dplyr)
groupdata <- group_by(mdata, Subjects, activities)
secondata <- summarise_each(groupdata, funs(mean))


