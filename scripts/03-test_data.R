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
if(!all(c("tgt_priority", "tgt_industry", "country_mission", "bomb_tons", "aircraft_attack") %in% names(data))) {
  stop("Data frame does not have the correct columns.")
}

# Check for correct types
if(!is.factor(data$tgt_priority)) {
  stop("tgt_priority is not a factor.")
}
if(!is.factor(data$tgt_industry)) {
  stop("tgt_industry is not a factor.")
}
if(!is.factor(data$country_mission)) {
  stop("country_mission is not a factor.")
}
if(!is.numeric(data$bomb_tons)) {
  stop("bomb_tons is not numeric.")
}
if(!is.numeric(data$aircraft_attack)) {
  stop("aircraft_attack is not an numeric.")
}

# Check for expected levels in factors
expected_levels_priority <- c("target of last resort", "target of opportunity",  "secondary target", "primary target")
if(!all(expected_levels_priority %in% levels(data$tgt_priority))) {
  stop("tgt_priority does not have the expected levels.")
}

# Check numeric variables for expected range
if(any(data$bomb_tons < 0)) {
  stop("bomb_tons contains negative values.")
}
if(any(data$aircraft_attack < 0)) {
  stop("aircraft_attack contains negative values.")
}

# Check for missing values
if(any(!complete.cases(data))) {
  stop("There are missing values in the data.")
}

# If the script gets to this point without stopping, all tests passed
print("All tests passed!")
