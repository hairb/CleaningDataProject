## Tidy Dataset Code Book 


Tidy dataset name: *tidy_dataset_part5*

input data (raw data) for the project is described in UCI HAR Dataset\\features_info.txt

Variables in *tidy_dataset_part5*:
* Subject_ID - the ID of the subject (1-30) as loaded from the subject_train.txt and subject_test.txt files
* Activity_Label - The Activity performed by the subject. The Activity Label is the description of the activity code. Labels and codes matching are taken from activity_labels.txt file.
* 66 variable, named avg(**variable_name**). 
  * The variables being averaged mean() and std() features taken from the x_train.txt and x_test.txt files. 
  * Names were changed to be more descriptive and use less abbreviations.
  * The measurements were averaged

The file contains:
* 180 rows: 30 subjects * 6 activities
* 68 columns: Suject_ID + Activity_Label + 66 average of measurements variables (only mean() and std() features)


