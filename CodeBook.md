#CodeBook: "Getting and cleaning data" course final assignment

This file contains description of the tidy dataset and the steps made to obtain it

### Recipe steps
1. Directory check - the script looks lor "data" directory in the current working directory, if missing it is creted.
1. The dataset should be present in a zip the file **data/dataset.zip**.
    If the file is missing it will attempt to download it from

    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
1. Unzipped data directory check - sthe data should be in "data/UCI HAR Dataset" directory. If the directory is missing the "data/dataset.zip" file will be unzipped.
1. Load data into memory - the subject_test.txt, y_test.txt, X_test.txt, subject_train.txt, y_train.txt, X_train.txt will be loaded into memory
1. Preparing and merging test and train data - the subjects and activities information for each dataset are added to the observations dataset. Then the resulting datasets are merged into one to get the full dataset. The full dataset columns are renamed according to the code book available within the unzipped directory. The subject and y columns are named "subject" and "y" respectively
1. The columns containing measurements of *mean* and *standard deviation* are extracted along with the subject and activity(y) data into a separate dataset called `mean_std_ds`
1. The activity ids are replaced with their text values by mapping the data from the *y* column with the data contained in *activity_labels.txt*
1. The names of the `mean_std_ds` are edited so they contain no special characters, only lowercase letters, the words are separated by dots and the 'f' and 't' abbreaviations are replaced with 'freq' and 'time' respectively.

### Variables 
1. `full_ds` - a full dataset constructed by merging the *test* and *train* data,
  activities and subjects included.
1. `mean_std_ds` - a dataset extracted from the full dataset by selecting only the columns with **mean** and **standard deviation** observations
1. `grouped_mean_std_means` - a dataset obtained from `mean_std_ds` by grouping the data by *person* and then by *activity* and calculating the `mean` for each group. 
1. `grouped_mean_std_means.txt` - the output file with the tidy dataset written in the current working directory

**Note:** The intermediate variables are removed by the script in the process
