CleaningDataProject
===================

course project for "Getting and Cleaning Data" course

files:
* run_analysis.R - the project's script 
* README.md - this readme file
* CodeBook.md - the codebook
* datasets - intermediate dataset files created by the run_analysis.R script

## Information regarding *run_analysis.R*:

### Input Data:

A provided zip file containing a directory (UCI HAR Dataset). 
The directory includes data from the "Human Activity Recognition Using Smartphones Dataset"

Information regarding the raw data for the course project can be found in the provided files within the zip file
- README.txt 
- features_info.txt

The script works on the following data:
* subjects (from train/subject_train.txt, test/subject_test.txt) 
* features values i.e. the train/test sets (from train/x_train.txt, test/x_test.txt)
* activity labels (from train/y_train.txt, test/y_test.txt) 

The scripts uses the following data as code tables:
* features.txt - for names of all features
* activity_labels.txt - for labels of activities (corresponds to the codes in y_train.txt and y_test.txt)

Data not used by the course project:
* The "Inertial Signals" (from both train and test directories)
* The data was not used, as suggested by the project directions and by discussion forums threads

### Script work:

The script does the following work:  
1. Downloads and unzips the provided zip file  
2. loads subjects, x and y data  
3. produces (by combining the rows)  
	- subject_set (subject_train + subject_test)  
	- x_set (x_train + x_test)  
	- y_set (y_train + y_test)   
4. changes column names to be meaningful  
5. add a column with the matching activity_label (as requested by *step 3*)   
6. creates **dataset_0** - a basic merged dataset of train and test data (as requested by *step 1*)  
7. creating a subset of features containing only mean() and std() measurements (a phase for *step 2*)  
8. change the column names to be more descriptive (as requested by *step 4*)  
9. creates **dataset_1** - an intermediate file, containing the requested subset of measurements (mean and std) with
appropriate column names (dataset corresponds to requested steps 1-4)  
10. creates **tidy_dataset_part5** - a tidy dataset with an average of each variable, for each subject and each activity (i.e. grouped by subject+activity)




