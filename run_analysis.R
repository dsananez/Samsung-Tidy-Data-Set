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
trainSub <- read.table("UCI HAR Dataset/train/subject_train.txt") #Same with train
testSub <- read.table("UCI HAR Dataset/test/subject_test.txt") #and test subjects.
activity <- rbind(trainAct, testAct) #Merges trainAct and testAct in a vector named "activity".
subject <- rbind(trainSub, testSub)  #Same with trainSub and testSub in "subject"
dataAct <- cbind(measu, c("Activity" = activity)) #Column-binds it to our data ("measu").
dataAct <- cbind(dataAct, c("Subject" = subject)) #Same to "dataAct".
actiVec <- c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying")
#Creates a vector with the activities name
for (i in 1:10299){                     #Loops through the last column of the data frame (activities), row
        x <- as.numeric(dataAct[i,80])   #by row, using actiVec to label each activity according to its number.
        dataAct[i,80] <- actiVec[x]
}

## Part 5
dfLab <- aggregate(dataAct[,1], by=list(Activity = dataAct[,80], Subject = dataAct[,81]), mean)
dfLab <- dfLab[1:2] #We create a Data Frame with the Activities and Subjects columns.
for (i in 1:79){
        temp <- aggregate(dataAct[,1], by=list(Activity = dataAct[,80], Subject = dataAct[,81]), mean)
        dfLab <- cbind(dfLab, a[3])
}
colnames(dfLab) <- c("Activity", "Subject", colnames(measu))
write.table(dfLab, "Tidy Data Set.txt", row.names = F)
