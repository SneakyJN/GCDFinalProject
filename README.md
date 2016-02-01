# GCDFinalProject
Final Project for the Getting &amp; Cleaning Data Coursera Course

SOURCE DATA DOWNLOAD: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

DETAILS OF DATA:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

[SETUP]
- Download the data zip file
- Extract the file to a directory
- Change your Working Directory in R to the directory you extracted the data to

[RUN & OUTPUT]
- Execute the "run_analysis.R" file from R/R Studio
- A "Output_Tiny_Data.txt" file will be created in the same directory

[SCRIPT STEPS]
- install and load "reshape" package (for Melt and DCast)
- Load files:
  - features.txt
  - activity_labels.txt
- Setup column filters based on txt matches for anything with Mean or Standard Deviation
- Load files:
  - subject_train.txt
  - X_train.txt
  - Y_train.txt
- subset down to just mean/std columns
- bind 2 new columns to large data set
- Load Files:
  - subject_test.txt
  - X_test.txt
  - Y_test.txt
- subset down to just mean/std columns
- bind 2 new columns to large data set
- Merge both subsetted data frames into a single frame adn rename columns
- create descriptive variable names (change to factors)
- Melt on subject and activity
- dcast on subject and activity by variable and mean
- Output the "Output_Tidy_Data.txt" output file to the working directory