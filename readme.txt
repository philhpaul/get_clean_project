README for run_analysis.R   

VARIABLE			TYPE			NOTE
activity_labels.txt		input data file		assumed in ./
features.txt			input data file		assumed in ./
subject_test.txt		input data file		assumed in ./test/
y_test.txt			input data file		assumed in ./test/
X_test.txt			input data file		assumed in ./test/ 
subject_train.txt		input data file		assumed in ./train/
y_train.txt			input data file		assumed in ./train/
X_train.txt			input data file		assumed in ./train/
activ				data frame [2,6]	authors activity labels										
feature				data frame [2,561]	authors feature labels
collect				integer vector		column #'s of selected features j=1,n
c_names				char vector		tidy feature names
r_names				char vector		tidy activity names used in f
tmptest				data frame		dummy
tmptrain			data frame		dummy
tbl				data frame		dummy
j				integer			dummy
df				data frame	[,1] 	user ID for each data window
						[,2]	activity ID for each window	
						[,2+i]	feature data i=1,n
f  (written to output)		data frame	[,1] 	user ID 
						[,2]	tidy activity name 	
						[,2+i]	mean feature data j=1,n	

AUTHOURS FEATURE NAME 	CLEAN NAME (tidy set)	FUNCTION (as included in data set, listed in order j=1,n)    				
tBodyAcc-mean()-F	meanAccF 		mean of component of body acceleration  (F = X, Y, Z)
tBodyAccMag-mean()	meanAccMag		mean of magnitude of body acceleration 
tBodyAcc-std()-F	stdvAccF		stdev of component of body acceleration
tBodyAccMag-std()	stdvAccMag		stdev of magnitude of body acceleration
tBodyGyro-mean()-F	meanGyroF 		mean of component of angular velocity
tBodyGyroMag-mean()	meanGyroMag		mean of magnitude of angular velocity
tBodyGyro-std()-F	stdGyroF		stdev of component of angular velocity
tBodyGyroMag-std()	stdGyroMag		stdev of magnitude of angular velocity
tBodyAccJerk-mean()-F	meanAccJerkF 		mean of component of rate of body acceleration
tBodyAccJerkMag-mean()	meanAccJerkMag		mean of magnitude of rate of body acceleration
tBodyAccJerk-std()-F	stdAccJerkF		stdev of component of rate of body acceleration
tBodyAccJerkMag-std()	stdAccJerkMag		stdev of magnitude of rate of body acceleration
tBodyGyroJerk-mean()-F	meanGyroJerkF 		mean of component of rate of angular velocity
tBodyGyroJerkMag-mean()	meanGyroJerkMag		mean of magnitude of rate of angular velocity 
tBodyGyroJerk-std()-F	stdGyroJerkF		stdev of component of rate of angular velocity
tBodyGyroJerkMag-std()	stdGyroJerkMag		stdev of magnitude of rate of angular velocity
tGravityAcc-mean()-F	meanGravAccF		mean of component of gravity acceleration
tGravityAccMag-mean()	meanGravAccMag		mean of magnitude of gravity acceleration

ACTIVITES
ID number	AUTHORS NAME 		CLEAN NAME (tidy set)
  	1  	walking			walk
 	2  	walking-upstairs	walkUP 
  	3  	walking-downstairs	walkDown 
  	4  	sitting			sit  
  	5  	standing		stand 
  	6  	lying			lie



