library(sqldf)
setwd("C:\\coursera\\CleaningData\\project")
urlFile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destZipFile <- "dataFile.zip"
download.file(urlFile,destZipFile,mode="wb")
unzip(destZipFile)

# Reading the Activity labels (codes and labels)
activity_labels <- read.table("UCI HAR Dataset\\activity_labels.txt")
colnames(activity_labels) <- c("Code","Label")

# Reading all features (codes and labels)
features <- read.table("UCI HAR Dataset\\features.txt")
colnames(features) <- c("Code","Description")

# Reading all train data (subjects, x and y)
subject_train <- read.table("UCI HAR Dataset\\train\\subject_train.txt")
x_train <- read.table("UCI HAR Dataset\\train\\X_train.txt")
y_train <- read.table("UCI HAR Dataset\\train\\Y_train.txt")


# Reading all test data (subjects, x and y)
subject_test <- read.table("UCI HAR Dataset\\test\\subject_test.txt")
x_test <- read.table("UCI HAR Dataset\\test\\X_test.txt")
y_test <- read.table("UCI HAR Dataset\\test\\Y_test.txt")

# merge all subjects (train + test) 
subject_set <- rbind(subject_train, subject_test)

# change the column name  
colnames(subject_set) <- "Subject_ID"

# merge the x sets (train + test) 
x_set <- rbind(x_train, x_test)

# change the column names to be as in the features file
colnames(x_set) <- features$Description

# merge the y sets (train + test)
y_set <- rbind(y_train, y_test)
# change the column name
colnames(y_set) <- "Activity_Label_Code"

# create a new data frame for the y (activity) label (according to the matching code in the y_set)
#  as asked by step 3 
y_label_set <- sqldf("select label Activity_Label from y_set y, activity_labels a where y.Activity_Label_Code = a.code")


# create the basic dataset, including all train + test data
#  and all columns - subjects + x + y + y label (the activity label)
dataset_0 <- cbind(subject_set, y_set , y_label_set, x_set)

# select only measurments of std() or mean()
features_subset <- sqldf("select * 
                         from features 
                         where description like '%std()%' 
                            or description like '%mean()%'")

# change the column names to be more descriptive 
column_names <- gsub("-","_",as.character(features_subset$Description))
column_names <- gsub("Acc","_Acceleration", column_names)
column_names <- gsub("tBody","time_Body", column_names)
column_names <- gsub("fBody","frequency_Body", column_names)
column_names <- gsub("tGravity","time_Gravity", column_names)
column_names <- gsub("fGravity","frequency_Gravity", column_names)
column_names <- gsub("Mag","_Magnitude", column_names)
column_names <- gsub("Gyro","_Gyroscope", column_names)
column_names <- gsub("Jerk","_Jerk", column_names)
column_names <- gsub("\\(\\)","", column_names)
features_subset$New_Description <-  column_names


features_subset_list <- c(features_subset[,1]+3)

# create the dataset with only the columns in interest (mean and std + id and activity label)
dataset_1 <- dataset_0[,c(1,2,3,features_subset_list)]

# update the column names as prepared in previous step
colnames(dataset_1)[4:ncol(dataset_1)] <- features_subset[,3] 

# create a sql stmt to create the tidy dataset for step 5
variable_avg_str <- paste("avg(",c(features_subset$New_Description),"),", collapse="")
select_avg_stmt <- paste("select subject_id, activity_label,",variable_avg_str, "1 
                          from dataset_1 
                          group by subject_id, activity_label",collapse="")
tidy_dataset_part5 <- sqldf(select_avg_stmt)
tidy_dataset_part5 <- tidy_dataset_part5[,1:68]

write.table(tidy_dataset_part5,"tidy_dataset_part5.txt",row.names=FALSE)




