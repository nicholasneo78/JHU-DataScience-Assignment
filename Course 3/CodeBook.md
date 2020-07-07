# CodeBook.md

### _Modifications made to the data_
	- Merge the train and test sets to create one data set.
	- Retrieve only the measurements on the mean and standard deviation for each measurement.
	- Rename the descriptive activity names to make it more understandable.
	- Creating a second, independent tidy data set with the average of each variable for each activity and each subject.

### _Identifiers_
	- Subject -> ID of the subjects
	- Activity -> The action that the subject performed when they took the measurements.
		- WALKING
		- WALKING_UPSTAIRS
		- WALKING_DOWNSTAIRS
		- SITTING
		- STANDING
		- LAYING
		
### _Renaming of descriptive activities using gsub()_
##### To make the descriptive activities more understandable, there is a naming convention to rename the descriptive activities.
- Replace the special characters like brackets, parentheses, dash with a space
- Replace mean with Mean
- Replace std with StandardDeviation
- Replace ^t with Time
- Replace ^f with Frequency
- Replace Acc with Accelerometer
- Replace Gyro with Gyroscope
- Replace Mag with Magnitude
- Replace Freq with Frequency
	
### _Steps to transform raw data_
	1. Download source data and unzip the data if files does not exists yet
	2. Get train and test sets of subjects, activities and features
	3. Merge the individual data stated in point 2 into one big dataset
	4. Extracts only the measurements on the mean and standard deviation for each measurement using grepl
	5. Rename the activities' names for readability
	6. Export tidy_raw.txt and tidy_mean.txt files with write.table
	
### _Measurements_
The measurements taken (after the renaming of descriptive activities) 
- TimeBodyAccelerometerMeanX/Y/Z
- TimeBodyAccelerometerStandardDeviationX/Y/Z
- TimeGravityAccelerometerMeanX/Y/Z
- TimeGravityAccelerometerStandardDeviationX/Y/Z
- TimeBodyAccelerometerJerkMeanX/Y/Z
- TimeBodyAccelerometerJerkStandardDeviationX/Y/Z
- TimeBodyGyroscopeMeanX/Y/Z
- TimeBodyGyroscopeStandardDeviationX/Y/Z
- TimeBodyGyroscopeJerkMeanX/Y/Z
- TimeBodyGyroscopeJerkStandardDeviationX/Y/Z
- TimeBodyAccelerometerMagnitudeMean
- TimeBodyAccelerometerMagnitudeStandardDeviation
- TimeGravityAccelerometerMagnitudeMean
- TimeGravityAccelerometerMagnitudeStandardDeviation
- TimeBodyAccelerometerJerkMagnitudeMean
- TimeBodyAccelerometerJerkMagnitudeMeanStandardDeviation
- TimeBodyGyroscopeMagnitudeMean
- TimeBodyGyroscopeMagnitudeStandardDeviation
- TimeBodyGyroscopeJerkMagnitudeMean
- TimeBodyGyroscopeJerkMagnitudeStandardDeviation
- FrequencyBodyAccelerometerMeanX/Y/Z
- FrequencyBodyAccelerometerStandardDeviationX/Y/Z
- FrequencyBodyAccelerometerJerkMeanX/Y/Z
- FrequencyBodyAccelerometerJerkStandardDeviationX/Y/Z
- FrequencyBodyAccelerometerJerkMeanFrequencyX/Y/Z
- FrequencyBodyGyroMeanX/Y/Z
- FrequencyBodyGyroStandardDeviationX/Y/Z
- FrequencyBodyGyroMeanFrequencyX/Y/Z
- FrequencyBodyAccelerometerMagnitudeMean
- FrequencyBodyAccelerometerMagnitudeStandardDeviation
- FrequencyBodyAccelerometerMagnitudeMeanFrequency
- FrequencyBodyBodyAccelerometerJerkMagnitueMean
- FrequencyBodyBodyAccelerometerJerkMagnitueStandardDeviation
- FrequencyBodyBodyAccelerometerJerkMagnitudeMeanFrequency
- FrequencyBodyBodyGyroscopeMagnitudeMean
- FrequencyBodyBodyGyroscopeMagnitudeStandardDeviation
- FrequencyBodyBodyGyroscopeMagnitudeMeanFrequency
- FrequencyBodyBodyGyroscopeJerkMagnitudeMean
- FrequencyBodyBodyGyroscopeJerkMagnitudeStandardDeviation
- FrequencyBodyBodyGyroscopeJerkMagnitudeMeanFrequency
