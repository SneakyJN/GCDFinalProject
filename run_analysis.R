install.packages("reshape")
library(reshape2)

##Load All Data Features Names
DT_Features <- read.table("features.txt") 
DT_Features[,2] <- as.character(DT_Features[,2])

##Load All Samsung Activity Names
DT_ActNames <- read.table("activity_labels.txt") 
DT_ActNames[,2] <- as.character(DT_ActNames[,2])

##Narrow down filter Col names for mean/std
FAC_MSD <- grep(".*mean.*|.*std.*", DT_Features[,2])
FAC_Names <- DT_Features[FAC_MSD,2] 
FAC_Names = gsub('-mean', 'Mean', FAC_Names) 
FAC_Names = gsub('-std', 'Std', FAC_Names) 
FAC_Names <- gsub('[-()]', '', FAC_Names) 

##Load All Samsung Train Data
DT_STrain <- read.table("train/subject_train.txt") 
DT_XTrain <- read.table("train/X_train.txt") 
DT_YTrain <- read.table("train/y_train.txt") 
DT_XTrain <- DT_XTrain[FAC_MSD]
DT_XTrain <- cbind(DT_STrain, DT_XTrain, DT_YTrain)

##Load All Samsung Test Data
DT_STest <- read.table("test/subject_test.txt") 
DT_XTest <- read.table("test/X_test.txt") 
DT_YTest <- read.table("test/y_test.txt") 
DT_XTest <- DT_XTest[FAC_MSD]
DT_XTest <- cbind(DT_STest, DT_XTest, DT_YTest)

## Merge it all together and rename columns nicely
DF_FullMerge <- rbind(DT_XTrain, DT_XTest)
colnames(DF_FullMerge) <- c("subject", "activity", FAC_Names)

## Fix up the Merged Data Frame to have descriptive variable names (Change to Factors)
DF_FullMerge$activity <- factor(DF_FullMerge$activity, levels = DT_ActNames[,1], labels = DT_ActNames[,2]) 
DF_FullMerge$subject <- as.factor(DF_FullMerge$subject) 

## Use Melt for subject and ativity, use dcast by variable/mean to form final Tiday Structure
DF_MergeMelt <- melt(DF_FullMerge, id = c("subject", "activity")) 
DF_Tidy <- dcast(DF_MergeMelt, subject + activity ~ variable, mean) 

## Output final Tidy Data
write.table(DF_Tidy, "Output_Tidy_Data.txt", row.names = FALSE, quote = FALSE) 