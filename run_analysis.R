# =====================================
cat("# fetching data...")
if (!dir.exists("data")) {
  dir.create("data")
}
if (!file.exists("data/dataset.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "data/dataset.zip")
  
}
if (!dir.exists("data/UCI HAR Dataset")) {
  unzip("data/dataset.zip", exdir = "data")
}

cat("done\n")

# =====================================
cat("# loading data into memory ... ")
library(dplyr)

testDataDir        <- "data/UCI HAR Dataset/test/"
subjectTest        <- tbl_df(read.table(paste0(testDataDir, "subject_test.txt"), stringsAsFactors = FALSE))
names(subjectTest) <- "subject"
yTest              <- tbl_df(read.table(paste0(testDataDir, "y_test.txt"), stringsAsFactors = FALSE))
names(yTest)       <- "activity"
xTest              <- tbl_df(read.table(paste0(testDataDir, "X_test.txt"), stringsAsFactors = FALSE))


trainDataDir        <- "data/UCI HAR Dataset/train/"
subjectTrain        <- tbl_df(read.table(paste0(trainDataDir, "subject_train.txt"), stringsAsFactors = FALSE))
names(subjectTrain) <- "subject"
yTrain              <- tbl_df(read.table(paste0(trainDataDir, "y_train.txt"), stringsAsFactors = FALSE))
names(yTrain)       <- "activity"
xTrain              <- tbl_df(read.table(paste0(trainDataDir, "X_train.txt"), stringsAsFactors = FALSE))

rm(testDataDir, trainDataDir)
cat("done\n")

# =====================================
cat("# merging data sets...")

testDS <- bind_cols(subjectTest, yTest, xTest)
trainDS <- bind_cols(subjectTrain, yTrain, xTrain)
full_ds <- bind_rows(testDS, trainDS)

names_vec <- read.table("data/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)[,2]
names(full_ds) <- c("subject", "activity", names_vec)

rm(subjectTest, xTest, yTest, subjectTrain, xTrain, yTrain, testDS, trainDS)

cat("done\n")
# =====================================
cat("# extracting mean and std columns...")

mean_std_ds <- full_ds[, c("subject", "activity", names_vec[grep("(mean\\(\\)|std\\(\\))+", tolower(names_vec))])]

rm(names_vec)
cat("done\n")

# =====================================
cat("# fixing activity values...")

activity_names <- tbl_df(read.table("data/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE))
mean_std_ds <- mean_std_ds %>% rowwise() %>% mutate(activity = as.character(activity_names[activity,2]))

rm(activity_names)
cat("done\n")

# =====================================
cat("# updating variable names...")
fixMeanAndStdColumnNames <- function(ds) {
  cnames <- gsub("-", ".", colnames(ds))
  cnames <- gsub("^t", "time.", cnames)
  cnames <- gsub("^f", "freq.", cnames)
  cnames <- gsub("\\(\\)", "", cnames)
  tolower(cnames)
}

colnames(mean_std_ds) <- fixMeanAndStdColumnNames(mean_std_ds)

rm(fixMeanAndStdColumnNames)
cat("done\n")

# =====================================
cat("# creating averages data set of each variable for each activity and each subject ...")

grouped_mean_std_means <- mean_std_ds %>% ungroup %>% group_by(subject, activity) %>% summarise_each(funs(mean))

cat("done\n")

cat("# writing output to 'grouped_mean_std_means.csv...")

write.csv(grouped_mean_std_means,"grouped_mean_std_means.csv", row.names = FALSE)

cat("done\n")