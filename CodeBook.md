# Getting and Cleaning Data Course Project

## Files
1. **SAMSUNG_AVG.txt** is the tidy summary data created by the script
2. **run_analysis.r** is the script which generated the data set
3. **CodeBook.md** is this file
4. **README.md** is the required readme file 

## Summary of Data Set Construction
The data set was constructed entirely within the **project.r** script as follows:
* Compressed data and associated files were downloaded from within R from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
* TRAIN and TEST data frames were created from the X_train.txt and X_test.txt for the measurements
* TRAIN and TEST data frames were stacked into COMBO using rbind
* Columns in COMBO were renamed using the variable names given in features.txt
* ACTIVITY_COMBO was similarly created from y_train.txt and y_test.txt, containing activity indicators
* The activity indicator was converted to a factor, and levels 1-6 were decoded from 'activity_levels.txt'  
* All measurements but mean and std were dropped from the COMBO data frame by using a regex on column names
* SUBJECT, ACTIVITY and COMBO were combined using cbind into a final SAMSUNG data frame
* SAMSUNG was converted to a tibble grouped by subject and activity
* The target data set, SAMSUNG_AVG, gives the mean of each measurement by subject and activity by applying dplyr's summarize_all using to SAMSUNG

## Variables
### The following is the variable description from the 'features_info.txt' file packaged with the data set:
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

### Additional notes for this data set
As described above, for each of the above measurements, in the present data set *only* mean and std were preserved. Further, the original 10299 discrete measurements were collapsed to 180 summary measurements grouped by subject (n=30) and activity (6 types of activity each). The mean was used for each summary statistic. That is, it gives the mean for each subject-activity combination of the mean/sds of the actual variable during each time interval. 

subject: integer from 1 to 30 uniquely identifying volunteers for the study
activity: factor indicating the type of body position of movement the subject undertook during the set of measurements
