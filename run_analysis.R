## Getting and Cleaning Data course project Jan/2015
##
## assume UCI HAR Dataset is downloaded and extracted
## assume runningn in the root directory of UCI HAR Dataset 
##
## get list of activities and name column
activ<-read.table("activity_labels.txt",sep=" ")
names(activ)[2]<-"activity"  
## get list of features and name column
feature<-read.table("features.txt",sep=" ")
names(feature)[2]<-"feature" 
##
## Use time-domain features, freq-domain features are of questionable validity
## Use basic Body data - mean and stdev of accelertion, radial velocity, 
##     jerk(accelertion), jerk(radial velocity). Also provide mean gravity 
##     acceleration vector to put dody data vectors into context.  
## 
## Structure tidy data sets to be, by column: 
## user_ID number
## activity_ID number or name
## time mean Body Acceleration X,Y,Z,Mag 
## time stdv Body Acceleration X,Y,Z,Mag 
## time mean Body Gyro X,Y,Z,Mag
## time stdv Body Gyro X,Y,Z,Mag
## time mean Acceleration Jerk X,Y,Z,Mag
## time Stdv Acceleration Jerk X,Y,Z,Mag
## time mean Body Gyro Jerk X,Y,Z,Mag
## time stdv Body Gyro Jerk X,Y,Z,Mag
## time mean Gravity Acceleration X,Y,Z,Mag
##
## find column locations of selected features
collect<-c(grep("tBodyAcc-mean",feature$feature),
           grep("tBodyAccMag-mean",feature$feature),
           grep("tBodyAcc-std",feature$feature),
           grep("tBodyAccMag-std",feature$feature),
           grep("tBodyGyro-mean",feature$feature),
           grep("tBodyGyroMag-mean",feature$feature),
           grep("tBodyGyro-std",feature$feature),
           grep("tBodyGyroMag-std",feature$feature),
           grep("tBodyAccJerk-mean",feature$feature),
           grep("tBodyAccJerkMag-mean",feature$feature),
           grep("tBodyAccJerk-std",feature$feature),
           grep("tBodyAccJerkMag-std",feature$feature),
           grep("tBodyGyroJerk-mean",feature$feature),
           grep("tBodyGyroJerkMag-mean",feature$feature),
           grep("tBodyGyroJerk-std",feature$feature),
           grep("tBodyGyroJerkMag-std",feature$feature),
           grep("GravityAcc-mean",feature$feature),
           grep("GravityAccMag-mean",feature$feature))
## make char vector of target feature names
c_names<-c("user","activity",as.character(feature$feature[collect]))
## remove abnoxious characters 
c_names<-gsub("\\(","",c_names)
c_names<-gsub("\\)","",c_names)
c_names<-gsub("-","",c_names)
## remove redundant characters all are Body except as Gravity retained  
##    and all time-domain
c_names<-gsub("tBody","",c_names)
c_names<-gsub("tGr","Gr",c_names)
## Restructure feature names in camelBack and into format 
## functionQuantityOperateDirection
## function = (mean,stdv) refering to mean or standard_deviation
## Quantity = (Acc,Gyro) refering to acceleration or angular_velocity
## Operation = (Jerk,NULL) Jerk being the time_deriviative of Quantity
## Direction = (X,Y,Z,Mag) refering to vector directions and magnitude
c_names<-gsub("Magmean","meanMag",c_names)
c_names<-gsub("Magstd","stdMag",c_names)
c_names<-gsub("Jerkmean","meanJerk",c_names)
c_names<-gsub("Jerkstd","stdJerk",c_names)
c_names<-gsub("Accmean","meanAcc",c_names)
c_names<-gsub("Accstd","stdvAcc",c_names)
c_names<-gsub("Gyromean","meanGyro",c_names)
c_names<-gsub("Gyrostd","stdvGyro",c_names)
c_names<-gsub("Gravitymean","meanGrav",c_names)
##
## for each column row-bind test and train components
## date frame df with first column = user ID
tmptest<-read.table("./test/subject_test.txt")
tmptrain<-read.table("./train/subject_train.txt")
df<-rbind(tmptest,tmptrain)
## add second column = activity ID
tmptest<-read.table("./test/y_test.txt")
tmptrain<-read.table("./train/y_train.txt")
df<-cbind(df,rbind(tmptest,tmptrain))
## read feature value data, may be seperated by a variable number of spaces
tmptest<-read.table("./test/X_test.txt")
tmptrain<-read.table("./train/X_train.txt")
tbl<-rbind(tmptest,tmptrain)
## make remaining columns of df = feature value data in sequential order of 
##    selected features
df <- cbind(df,tbl[,collect])
## apply column names and sort df by user ID then by activity ID 
names(df) <- c_names
## a tidy data set with all activity windows by activity ID number
df <- df[order(df$user,df$activity),]   
##
## average over repeats of each activity window for each user
##    use aggregate, keeping columns in origional order
f <- aggregate(df[,3],by=list(user=df$user,activity=df$activity),mean)
for (j in 4:ncol(df)){
  ftemp <- aggregate(df[,j],by=list(user=df$user,activity=df$activity),mean)
  f <- cbind(f, ftemp[,3])
}
## re-order by user then by activity to clean up order after aggregate 
f <- f[order(f[,1],f[,2]),]
## apply column and row names 
names(f) <- c_names
r_names <- rep(c("walk","walkUp","walkDown","sit","stand","lie"),30)
## a tidy data set averaged over activity windows
f[,2] <- r_names    
##
## Output to enable reading by data<-read.table("fresult.txt",header=T)
## Sensor-to-sensor reproducibility and linearity warrents no more than 
##    4 to 5 digits on the averaged data 
write.table(format(f,digits=5),"fresult.txt",row.names=F,quote=F)
## quod erat demonstrandum

