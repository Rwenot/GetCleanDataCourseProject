## Final project for Getting and Cleaning Data course:
## producing a tidy data set from downloaded data

## script 2 of 2
## This script:
## Merges the training data and test data
## Extracts only the mean and standard deviation for each measurement
## Renames activities in the dataset using descriptive activity names
## Labels the variables with descriptive variable names
##           (the result of the four steps above will be called "mean_std_data")
## Creates a second "tidy" dataset with averages by variable, activity, subject
##           (called "averages")

## assuming you have already run script 1 of 2 to download the data, and
## assuming you have already unzipped the downloads, now to read the data into R  
traintable<-read.table(
  "~UCI HAR Dataset/train/X_train.txt"
  )
trainsubj<-read.table(
  "~UCI HAR Dataset/train/subject_train.txt"
  )
trainlabels<-read.table(
  "~UCI HAR Dataset/train/y_train.txt"
  )
testtable<-read.table(
  "~UCI HAR Dataset/test/X_test.txt"
  )
testsubj<-read.table(
  "~/UCI HAR Dataset/test/subject_test.txt"
  )
testlabels<-read.table(
  "~/UCI HAR Dataset/test/y_test.txt"
  )

## append the subject and label information to the data
traintable$label<-trainlabels[,1]
testtable$label<-testlabels[,1]
traintable$subject<-trainsubj[,1]
testtable$subject<-testsubj[,1]

## combine test and train into one
alldata<-rbind(traintable,testtable)

## change activity labels to descriptions - note that plyr package was used
alldata$activity<-mapvalues(alldata$label,from=c(1,2,3,4,5,6),to=c("walking",
    "walking upstairs","walking downstairs","sitting","standing","laying"))

## select out variables that are means or stds
features<-read.table(
    "~/DataSci/R_Coursera/CleanFinalProj/UCI HAR Dataset/features.txt",
    stringsAsFactors = FALSE
    )
features<-features$V2
varnames<-c(features,"label","subject","activity")
names(alldata)<-varnames
std<-grepl("std",features,ignore.case=TRUE)
mean<-grepl("mean",features,ignore.case=TRUE)
angle<-grepl("angle",features,ignore.case=TRUE)
freq<-grepl("freq",features,ignore.case=TRUE)
meanstd<-mean|std
use<-!freq&!angle&meanstd
mean_std_data<-alldata[,use]

## improve the variable names and drop unneeded columns
names(mean_std_data)<-sub("^t","time domain ",names(mean_std_data))
names(mean_std_data)<-sub("^f","frequency domain ",names(mean_std_data))
names(mean_std_data)<-sub("BodyBody","Body",names(mean_std_data))
names(mean_std_data)<-sub("Body","body ",names(mean_std_data))
names(mean_std_data)<-sub("Gravity","gravitational ",names(mean_std_data))
names(mean_std_data)<-sub("Gyro","gyroscopic ",names(mean_std_data))
names(mean_std_data)<-sub("Acc","acceleration ",names(mean_std_data))
names(mean_std_data)<-sub("Mag","magnitude ",names(mean_std_data))
names(mean_std_data)<-sub("Jerk","jerk ",names(mean_std_data))
names(mean_std_data)<-sub("-"," ",names(mean_std_data))
names(mean_std_data)<-sub("X$","X direction",names(mean_std_data))
names(mean_std_data)<-sub("Y$","Y direction",names(mean_std_data))
names(mean_std_data)<-sub("Z$","Z direction",names(mean_std_data))
names(mean_std_data)<-sub("  "," ",names(mean_std_data))
names(mean_std_data)<-sub("std","standard dev",names(mean_std_data))
mean_std_data<-mean_std_data[,-67]
  
## create another "tidy" dataset with averages of variables for activities,
## for subjects, and each variable's overall average
## it will consist of a list called 'averages' with three components: 
## averages[1] is the 66 variable means overall - a 66x1 data frame
## averages[2] is the variable means by activity - a 66x6 data frame
## averages[3] is the variable means by subject - a 66x30 data frame
## (according to tidy data principles each different kind of thing
##  needs to have its own separate table or dataset)

##component 1
overall_averages<-colMeans(mean_std_data[,1:66],na.rm=TRUE)
overall_averages<<-as.data.frame(overall_averages)

##component 2
avgs_by_activity<-
  sapply(split(mean_std_data,mean_std_data$activity),function(x) colMeans(x[1:66]))
avgs_by_activity<-as.data.frame(avgs_by_activity)

##component 3
avgs_by_subject<-
  sapply(split(mean_std_data,mean_std_data$subject),function(x) colMeans(x[1:66]))
avgs_by_subject<-as.data.frame(avgs_by_subject)
names(avgs_by_subject)<-c(
  "Subject 1","Subject 2","Subject 3","Subject 4","Subject 5",
  "Subject 6","Subject 7","Subject 8","Subject 9","Subject 10",
  "Subject 11","Subject 12","Subject 13","Subject 14","Subject 15",
  "Subject 16","Subject 17","Subject 18","Subject 19","Subject 20",
  "Subject 21","Subject 22","Subject 23","Subject 24","Subject 25",
  "Subject 26","Subject 27","Subject 28","Subject 29","Subject 30")

##final list
averages<-list(overall_averages,avgs_by_activity,avgs_by_subject)
write.table(averages,file="TidyData.txt",row.names = FALSE)

##end of project
