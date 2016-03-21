## Final project for Getting and Cleaning Data course:
## producing a tidy data set from downloaded data

## script 1 of 2
## first step is to download the data and observation labels

url<-"https://d396qusza40orc.cloudfront.net/
  getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,"ProjectData.zip",method="curl")

## note: you should be in the desired directory already before downloading the zip file

## note: after running, you should manually unzip the zip file before running the
## next script

## end of script 1
