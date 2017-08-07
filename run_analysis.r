# Getting and Cleaning Data end of course project
## Sean McGrew
## August 2017

library(tidyverse)

# The following code was needed to download and run the analysis on my workstation
#setwd("C:/Users/smcgrew/Documents/coursera cleaning data")
#fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(fileURL,"20Dataset.zip",mode="wb")
#unzip("20Dataset.zip")
#setwd("C:/Users/smcgrew/Documents/coursera cleaning data/UCI HAR Dataset")

# The following code should work if the working directory is set to ".../UCI HAR Dataset"

TRAIN<-read.table("train/X_train.txt")
TEST<-read.table("test/X_test.txt")
SUBJECT_TEST<-read.table("test/subject_test.txt")
SUBJECT_TRAIN<-read.table("train/subject_train.txt")
ACTIVITY_TRAIN<-read.table("train/y_train.txt")
ACTIVITY_TEST<-read.table("test/y_test.txt")
activity_labels<-read.table("activity_labels.txt")
column_names<-read.table("features.txt")

COMBO<-rbind(TRAIN,TEST)
SUBJECT_COMBO<-rbind(SUBJECT_TRAIN,SUBJECT_TEST)
ACTIVITY_COMBO<-rbind(ACTIVITY_TRAIN,ACTIVITY_TEST)

names(COMBO)<-column_names[,2]
names(SUBJECT_COMBO)<-c("subject")
names(ACTIVITY_COMBO)<-c("activity")

ACTIVITY_COMBO$activity<-factor(ACTIVITY_COMBO$activity)
levels(ACTIVITY_COMBO$activity)<-activity_labels$V2

COMBO<-subset(COMBO, select = grep("-mean\\(|-std\\(",names(COMBO)))

SAMSUNG<-cbind(SUBJECT_COMBO,ACTIVITY_COMBO,COMBO)

SAMSUNG<-group_by(SAMSUNG,subject,activity)

SAMSUNG_AVG<-summarize_all(SAMSUNG,mean)

write.table(SAMSUNG_AVG,"SAMSUNG_AVG.txt",row.name=FALSE)
