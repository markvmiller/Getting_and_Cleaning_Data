# Getting_and_Cleaning_Data 

Project information

run_analysis.R
Generate Dataset

Checkout the repo, and run the script run_analysis.R.

source("run_analysis.R")

This code requires the use of the plyr package. The data that is to be used comes from (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), and must first be downloaded.
The files are downloaded into a folder, "UCI HAR Dataset", which is used as the main working directory. 

After running the code, the following two datasets are produced as the final output within the main working directory:

    merged_data.txt - 10299 rows and 68 cols
    merged_data_tidy_version.txt - 180 rows and 68 cols