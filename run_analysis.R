## Downloading the data
if(!file.exists("./data")){dir.create("./data")}
dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")
## Extracting the data
unzip(zipfile="./data/Dataset.zip",exdir="./data")

# Taking a look at the files in the destination path
path <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path, recursive=TRUE)
files
## To load the data, we require the following files from README.txt
#       test/subject_test.txt
#       test/X_test.txt
#       test/y_test.txt
#       train/subject_train.txt
#       train/X_train.txt
#       train/y_train.txt

## Read the data from the files to variables.
## 1. Reading the features files
featuresTrain <- read.table(file.path(path,"train","X_train.txt"),header = FALSE)
featuresTest <- read.table(file.path(path,"test","X_test.txt"),header = FALSE)


## 2. Reading the activity files
activityTrain <- read.table(file.path(path,"train","Y_train.txt"),header = FALSE)
activityTest <- read.table(file.path(path,"test","Y_test.txt"),header = FALSE)


## 3. Reading the subject files
subjectTrain <- read.table(file.path(path,"train","subject_train.txt"),header = FALSE)
subjectTest <- read.table(file.path(path,"test","subject_test.txt"),header = FALSE)

## looking at the structure of the above variables
str(featuresTrain)
str(featuresTest)

str(activityTrain)
str(activityTest)

str(subjectTrain)
str(subjectTest)

## Step 1: Merges the training and the test sets to create one data set.
## combine rows
FeaturesData <- rbind(featuresTrain,featuresTest)
ActivityData <- rbind(activityTrain,activityTest)
SubjectData <- rbind(subjectTrain,subjectTest)
View(head(FeaturesData))
## - set the names to variables
FeaturesNames <- read.table(file.path(path,"features.txt"),header = FALSE)
names(FeaturesData)<- FeaturesNames[,2]

names(ActivityData) <- c("activity")

names(SubjectData) <- c("subject")

## - merge the columns for the three data frames to have one data frame
Data1 <- cbind(FeaturesData,SubjectData,ActivityData)


## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
## subset the  names of featuresData that have 'mean()' and 'std()' in them

literals <- grep("mean\\(\\)|std\\(\\)",FeaturesNames[,2])
meanStdNames <- FeaturesNames$V2[literals]
meanStdNames

## Subset the data frame by the selected names of features
Data2 <- subset(Data1,select = c(as.character(meanStdNames),"subject","activity"))
dim(Data2)

# look at the structures of the selecteed data
str(Data2)

##Step 3: Uses descriptive activity names to name the activities in the data set

## Load the activity labels file
activityLabels <- read.table(file.path(path,"activity_labels.txt"),header = FALSE)

## Factorize the activity variable in the Data2
Data2$activity <- factor(Data2$activity,labels = activityLabels[,2])
head(Data2$activity,10)
## Step 4: Appropriately labels the data set with descriptive variablee names
names(Data2)
## Here the names of Features will be labelled using descriptive variable names

        # Acc is replaced by accelerometer
        # BodyBody is replaced by Body
        # Gryo is replaced by Gryoscope
        # Mag is replaced by Magnitude
        # prefix f is replaceed by frequency
        # prefix t is replaced by time
names(Data2) <- gsub("Acc","Accelerometer",names(Data2))
names(Data2) <- gsub("BodyBody","Body",names(Data2))
names(Data2) <- gsub("Gyro","Gyroscope",names(Data2))
names(Data2) <- gsub("Mag","Magnitude",names(Data2))
names(Data2) <- gsub("^f","frequency",names(Data2))
names(Data2) <- gsub("^t","time",names(Data2))

names(Data2)

#Step 5: From the data set in step 4, create a second, independent tidy data set with
#the average of each variable for each activity and each subject.
Data3 <- Data2 %>% 
        group_by(subject,activity) %>% 
        summarise_all(funs(mean))
# save the tidy data
write.table(Data3, file = "tidydata.txt",row.name=FALSE)

