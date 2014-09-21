## First of all set the folder containing "UCI HAR Dataset" as the Working Directory.

## Part 1:
trainSet <- read.table("UCI HAR Dataset/train/X_train.txt") #Loads the train set
testSet <- read.table("UCI HAR Dataset/test/X_test.txt") #and the test set using read.table().
data <- rbind(trainSet, testSet) #Merges both data frames into a new one called "data".

## Part 4 (required to work easly and clean):
features <- read.table("UCI HAR Dataset/features.txt") #Assigns the list of descriptive variables 
                                                        #names to "features".
features <- features[,2]  #Subsets to get the names column only.
colnames(data) <- features  #Labels the data using those names.

## Part 2:
grepMean <- grep("mean()", features) #Creates a vector with the variables named "...mean()".
grepSD <- grep("std()", features) #Same with Standard Deviation.
measu <- data[,append(grepMean, grepSD)] #Subsets "data" using both vectors (grepMean & grepSD)
                                        #appended and calls that data set "measu".

## Part 3:
trainAct <- read.table("UCI HAR Dataset/train/Y_train.txt") #Loads train
testAct <- read.table("UCI HAR Dataset/test/Y_test.txt") #and test activities.
activity <- rbind(trainAct, testAct) #Merges both in a vector named activity.
dataAct <- cbind(measu, c("Activity" = activity)) #Column-binds it to our data (measu)
actiVec <- c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying")
#Creates a vector with the activities name
for (i in 1:10299){                     #Loops through the last column of the data frame (activities), row
        x <- as.numeric(dataAct[i,80])   #by row, using actiVec to label each activity according to its number.
        dataAct[i,80] <- actiVec[x]
}

## Part 5
meanData <- data.frame() #Creates an empty data frame called meanData.
for (i in 1:79){
        x <- tapply(dataAct[,i], dataAct[,80], mean) #Loops column per column using tapply to calculate the
        meanData <- rbind(meanData, x)          #mean of each one, setting the activities column as the index.
}
colnames(meanData) <- actiVec           #Tidys the data set using the actiVec vector for columns
rownames(meanData) <- colnames(measu)   #and the column names we used in our previous data sets now as the
                                        #row names.
