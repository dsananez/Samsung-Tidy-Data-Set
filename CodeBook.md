##Code Book

Note: All the code in the script is commented with details. However, I will also explain it here.

First of all, its important to set the folder containing "UCI HAR Dataset" as the Working Directory, not the "UCI HAR Dataset" folder per se.

The train set and the test set are loaded using read.table(). Then both data frames get merged into a new one called "data". The list of descrptive variables (called features) is readed the same way but gets subsetted because the only column/vector needed is the one containing the names. That vector ("features") is used to label the data (with colnames()).

grep() is used to look for "mean()" and "std()" in the string vector "features". The vector returned is used to subset "data" to include only the columns ending in "mean()" or "std()", calling the new data set "measu".

Train and test activities are loaded using read.table() through the files "UCI HAR Dataset/train/Y_train.txt" and "UCI HAR Dataset/test/Y_test.txt". Both vectors get merged in a new vector named "activity". cbind() is used to column-bind this "activity" vector to the "measu" data set into a new data set called "dataAct". A vector including all activities labels is created and called "actiVec". A loop is runned to replace the numbers in the "activities" columns of the "dataAct" data set, with the string labels available in the "actiVec" vector.

Creates a Data Frame with the Activities and Subjects columns called "dfLab". Then loops an agregate function using Activities and Subjects fators and cbinds for every variable.Tidy data using the names of the variables available in "measu".And finally writes the Tidy Data Set in a text file.
