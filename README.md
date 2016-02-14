# README
## Files
run_analysis.R - downloads and cleans the Accelerometer dataset

CodeBook.md - Lists and describes the variables

README.md - This file right here

## What I did
1. To keep everything reproducible, I first downloaded the zip file listed on the assignment page
2. Applied the variable names from the features.txt file
3. Added the activity labels from the Y_test/train.txt files
4. Added the subject variable from the subect_train/txt. files
5. Combined the train and test sets to make a full data set (called fulldata)
6. Selected the appropriate variables (Subject, Activity and all of the other variables with means and standard deviations)
7. Replaced the activity labels with the actual activity names
8. Created a summarized dataset grouped by Subject and Activity.