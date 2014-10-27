############################################
# Run Analysis.R  does the following: 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Please NOTE!
I re-submitted the run_analysis.R file after the deadline, however I did not make any changes to it after SUN 2PM. My initial submission was the very old version
of that file, which I mistakenly copied to my repo from my local "draft" folder.
I apologize for any inconvenience it may cause.


Code file: run_analysis.R - Main function to perform the required task

data file: aggregate.txt - the aggregated dataset


How the function works:

Step 1: First lets create our lookup vectors


STEP 2: Read the features and extact only those column indexes that match the "mean" or "std" pattern
        that way, we'll be able to dynamically retrieve the proper column names even of the "feature" file gets 
        re-arranged

STEP 3:  Read the features.txt that maps the column indexes to the data labels


STEP 4:  Extract only required (mean and std) column indexes using RegEx search pattern. 

STEP 5:  Read Test Data

STEP 6:  Read Test Activities (type of activity, such as Walking, Seating, etc)

STEP 7:  Read the main test data

STEP 8: Set the readable column names for test data

STEP 9: Merge Activities, Subjects and main test data


STEP 10: Repeat steps 5 to 9 for the train 

STEP 11: Merge test and train data by the common fields

STEP 12: Create the aggregate data set and write it to disk
