#### Preamble ####
# Purpose: Tests 
# Author: Yunzhao Li
# Date: 16 April 2023 
# Contact: yunzhao.li@mail.utoronto.ca 
# License: MIT
# Pre-requisites: None


#### Workspace setup ####
library(arrow)


#### Test data ####

# Read the data
data <- read_parquet("data/analysis_data/cleaned_aerial_priority.parquet")

# Check for correct columns
if(!all(c("tgt_priority_explanation", "tgt_industry", "country_flying_mission", "total_tons", "ac_attacking") %in% names(data))) {
  stop("Data frame does not have the correct columns.")
}

# Check for correct types
if(!is.factor(data$tgt_priority_explanation)) {
  stop("tgt_priority_explanation is not a factor.")
}
if(!is.factor(data$tgt_industry)) {
  stop("tgt_industry is not a factor.")
}
if(!is.factor(data$country_flying_mission)) {
  stop("country_flying_mission is not a factor.")
}
if(!is.numeric(data$total_tons)) {
  stop("total_tons is not numeric.")
}
if(!is.numeric(data$ac_attacking)) {
  stop("ac_attacking is not an numeric.")
}

# Check for expected levels in factors
expected_levels_priority <- c("target of last resort", "target of opportunity",  "secondary target", "primary target")
if(!all(expected_levels_priority %in% levels(data$tgt_priority_explanation))) {
  stop("tgt_priority_explanation does not have the expected levels.")
}

# Check numeric variables for expected range
if(any(data$total_tons < 0)) {
  stop("total_tons contains negative values.")
}
if(any(data$ac_attacking < 0)) {
  stop("ac_attacking contains negative values.")
}

# Check for missing values
if(any(!complete.cases(data))) {
  stop("There are missing values in the data.")
}

# If the script gets to this point without stopping, all tests passed
print("All tests passed!")
