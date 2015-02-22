1. Introduction

The program "run_analysis.R" loads some data into the R environment,
and applies some rudimentary manipulations to it(for instance "means").

The data come from the following source:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

2. Contents 

a. Measurements of human mouvements, and their recognition to be used in smartphones
There were 30 volunteers. Each person performed six activities (WALKING, WALKING_UPSTAIRS, 
WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone on the waist. 
Using accelerometer and gyroscope contained in the smartphone, 3-axial linear acceleration and 
3-axial angular velocity were measured and separated into two sets: 70% of the volunteers for 
the training dataset, and 30% for the test dataset. 

b. For each record was provided: 

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body 
  acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label (see description in the code book)
- An identifier of the subject who carried out the experiment.

c. files and format

'README.txt'
'features_info.txt': Shows information about the variables used on the feature vector.
'features.txt': List of all features.
'activity_labels.txt': Links the class labels with their activity name.
'train/X_train.txt': Training set.
'train/y_train.txt': Training labels.
'test/X_test.txt': Test set.
'test/y_test.txt': Test labels.

3. Description of the program

INPUT:  All the files described in 2.c, except the features_info.txt
OUTPUT: A tidy dataframe "tidyData2" containing the means of all features, themselves
        selected for being a mean or a standard deviation of variables provided. These 
		have been computed on the basis of raw data described in 2.b
		
DECISIONS: 1. Errors were found in the features.txt file when comparing the names of the
           features to the names described in features_info.txt. In fact, the part 
		   "BodyBody" was not supposed to be there. I decided to correct it in "Body".
		   2. On the other hand, I considered the variable whose names contains the section 
		   "meanFreq" not part of the assignment. They seemed to me to be means of frequencies,
		   not of vectors.
		   
PROGRAM STRUCTURE:
           1. Correcting the features.txt file so that they can be used as column
		      names
		   2. Among the "features", selection of the variables containing the key word "mean" 
		      or "std"(standard deviation)
		   3. Creation of the complete "test2 dataframe (subjects, activities, features)
		   4. Creation of the complete "training" dataframe (subjects, activities, features)
		   5. Merging of the above two dataframes (-> tidyData).
		   6. Column naming of tidyData
		   7. Replacing activity numbers by activity names
		   8. After the line, computation of means of each variable according to
		      subject and activity (-> tidyData2)
		   9. Column naming of tidyData2 (add "_Mean")
		   
		   	   
NOTES:
		   1. The working directory must be in the unzipped UCI HAR Dataset folder.
		   2. It may take time (a minute or two) to run the program : dplyr has to be installed, 
		   and files are heavy.