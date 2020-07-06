# Course 3 Assignment

### _Instructions_
- Create one R script called run_analysis.R that does the following.

	1. Merges the training and the test sets to create one data set.
	2. Extracts only the measurements on the mean and standard deviation for each measurement.
	3. Uses descriptive activity names to name the activities in the data set
	4. Appropriately labels the data set with descriptive variable names.
	5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### _Files included_
	* UCI HAR Dataset -> Dataset needed for this exercise which was generated and unzipped from run_analysis.R code.
	* CodeBook.md -> Describes in detail the variables, the data, transformations to clean up the data.
	* README.md -> This file describes the instructions for this exercise and the files which reside in this repository. 
	* run_analysis.R -> Main R script that was used to tidy the dataset.
	* tidy_mean.txt -> final dataset produced by run.analysis.R to find average of each variable for each activity and each subject.
	* tidy_raw.txt -> final dataset produced (in raw form) by run.analysis.R
	
### _Library imported_
	* dplyr
