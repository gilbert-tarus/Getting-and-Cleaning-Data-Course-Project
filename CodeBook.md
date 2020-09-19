## The `run_analysis.R` script performs the data preparation(downloading and reading). Also it has the 5 steps required as described in the course project.

## Download the dataset
Dataset downloaded and extracted under the folder called `UCI HAR Dataset`(a subfolder of `data` folder just created)

## Assign each data to variables
`FeaturesNames`: features.txt : 561 rows, 2 columns
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.

`featuresTrain`: test/X_train.txt : 7352 rows, 561 columns
contains recorded features train data

featuresTest`: test/X_test.txt : 2947 rows, 561 columns
contains recorded features test data


`activityTest`: test/y_test.txt : 2947 rows, 1 columns
contains test data of activities’code labels

`activityTrain:` test/y_train.txt : 7352 rows, 1 columns
contains train data of activities’code labels

`subjectTest`: test/subject_test.txt : 2947 rows, 1 column
contains test data of 9/30 volunteer test subjects being observed

`subjectTrain`: test/subject_train.txt : 7352 rows, 1 column
contains train data of 21/30 volunteer subjects being observed

`activityLabels`: activity_labels.txt : 6 rows, 2 columns
List of activities performed when the corresponding measurements were taken and its codes (labels)

## set the names to variables
The 561 names in `FeaturesNames` variable are assigned to `FeaturesData` using names function

`activity` and `subject` character vectors are assigned as names to ActivityData and SubjectData respectively

## Merges the training and the test sets to create one data set
`FeaturesData`: (10299 rows, 561 columns) is created by merging featuresTrain  and featuresTest using rbind() function

`ActivityData`: (10299 rows, 1 column) is created by merging activityTrain and activityTest using rbind() function

`SubjectData`: (10299 rows, 1 column) is created by merging subjectTrain and subjectTest using rbind() function

`Data1` (10299 rows, 563 column) is created by merging FeaturesData, ActivityData and SubjectData using cbind() function

## Extracts only the measurements on the mean and standard deviation for each measurement
`literals` is a numeeric vector that holds the output of grep function applied to  names of Data1. meanStdNames selects the names that matches the literals from `FeaturesNames.`

`Data2:` (10299 rows, 88 columns) is created by subsetting Data1, selecting only columns: measurements on the mean and standard deviation (std)(using meanStdNames vector),subject and activity for each measurement

## Uses descriptive activity names to name the activities in the data set
Entire numbers in activity column of the Data2 replaced with corresponding activity taken from second column of the activityLabels variable

## Appropriately labels the data set with descriptive variable names
#### `Acc` is replaced by `accelerometer`
#### `BodyBody` is replaced by `Body`
#### `Gryo` is replaced by `Gryoscope`
#### `Mag` is replaced by `Magnitude`
#### Prefix `f` is replaceed by `frequency`
#### Prefix `t` is replaced by `time`

## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

`Data3` (180 rows, 88 columns) is created by sumarizing `Data2` taking the means of each variable for each `activity` and each `subject`, after grouped by `subject` and `activity`.
Export `Data3` into tidydata.txt file.
