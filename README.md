# Hopkins-Clean-Data-Project
Final assignment for Getting and Cleaning Data course

The run_analysis.R script performs some cleaning activities on the combination of two datasets obtained from a University of California Irvine study on fitness-tracking devices.  The data loaded in the script was from one portion of that study which used 30 subjects all tracking their movements with a Samsung Galaxy S II smartphone.

The first step in the script involved downloading the zipped dataset from the UCI site.

The second step loaded the data from the training and test datasets into two dataframes, and also loaded a set of variable names ("features") which were stored in a separate text file that was part of the overall zipped package.

The third step of the script merges the two data frames together into a combined dataframe using the rbind command.

The fourth step extracts just the mean and standard deviation measurements from the combined data frame, as instructed in the class assignment.

The fifth step of the script updates the six activity values from their original numerals to more descriptive labels, that were obtained from another text file in the zipped package.

The sixth step updates some of the variable names to more descriptive and less abbreviated versions.

The final step of the script extracts a new tidy dataset from the dataset that was formed in the first six steps, using the aggregate function to extract the mean values by activity and subject person.   That data set is then exported as a text file, and is found in this repo (data_tidy.txt)
