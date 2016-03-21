## Getting and Cleaning Data Final Project

The initial data used for this project comes from smartlab.ws, and the contents of the
original documentation of the source data is included in the file CodeBook.md, detailing 
how the data were collected and processed before I began working with the data.

The data contains the following features of interest for this project:

Subjects: 30 individuals

Activities: 6 - Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing, Laying

Variables: 561 variables (features) per observation - based on detecting the motion of smartphones

For the class project, we were asked to

*1. Merge the training and the test sets to create one data set.

*2. Extract only the measurements on the mean and standard deviation for each measurement.

*3. Use descriptive activity names to name the activities in the data set

*4. Appropriately label the data set with descriptive variable names.

*5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

For this project I created two scripts, downloading.R and run_analysis.R.  The downloading.R
only downloads the data.  It isn't really necessary, but it is considered good practice to
use a script for downloading, in order to increase reproducibility of results.

The five steps above are performed in the run_analysis.R script.  After downloading, but before
running run_analysis.R, the downloaded files should be unzipped in the working directory. Then
the script will be able to find the data it needs to read in.

The run_analysis.R script creates a dataset called mean_std_data satisfying #1-#4 above, and
then creates a list called averages satisfying requirement #5.
averages[1] is the 66 variable means overall - a 66x1 data frame
averages[2] is the variable means by activity - a 66x6 data frame
averages[3] is the variable means by subject - a 66x30 data frame

according to tidy data principles each different kind of thing needs
to have its own separate table or dataset, so my "averages is a list of 3 data frames.
However, due to the constraints of the submission to the Coursera website,
we were asked to use write.table() to a single .txt file, not a list. Therefore, my
submission file is essentially a 66x37 table rather than the set of three tables
as calculated in the script.



