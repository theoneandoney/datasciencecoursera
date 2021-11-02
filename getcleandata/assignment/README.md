## README.md
### Solution to the Johns Hopkins Getting and Cleaning Data Coursera Course final assignment

<p>This repository contains my notes and solutions for all of the Johns Hopkins Data Science Coursera courses.  Each of the courses are contained as separate subfolders in the repo, with this folder containing the "Getting and Cleaning Data" course.  It contants the following files/folders:</p>

- README.md (this file)
- CodeBook.md (the codebook for the final tidy data set)
- run_analysis.R (script to run my analsyis/solution for the assignment)
- tidy_data.txt (the final output of the run_analysis.R script)
- data.zip (the raw data used as input to run_analysis.R)
- data/UCI HAR Dataset/ (the raw data in unzipped format)

<p>The run_analysis.R script does the following:</p>

 - Merges the training and the test sets to create one data set.
 - Extracts only the measurements on the mean and standard deviation for each measurement. 
 - Uses descriptive activity names to name the activities in the data set
 - Appropriately labels the data set with descriptive variable names. 
 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

