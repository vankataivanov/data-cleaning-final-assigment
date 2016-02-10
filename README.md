#"Getting and cleaning data" course final assignment
This repository contains the script/recipe, the dataset and a codebook for obitaning a tidy data set with the average of each mean and standard deviation 
variable present in the original dataset.

The details for steps/recipe taken in the [`run_Analysis.R`](run_analysis.R) script are described in the [codebook](CodeBook.md)

###Prerequisites
 **OS** The code is verified and tested on Arch Linux.

 
 You will need to have the `dplyr` package available in your environment 
 in order to run this the `run_analysis.R` script.

###Usage
1. Clone the repository in a directory of your choice.
2. Run R and set the working directory to the one you cloned the repository in
3. Run the `run_analysis.R` script.

###Output
1. A text file named `grouped_mean_std_means.txt` containing the result dataset
2. 3 Datasets loaded into R 
    - the full one
    - one with only the variables of interest
    - one with the calculated means(which is also written to the file)
