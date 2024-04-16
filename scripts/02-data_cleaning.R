#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... 
# Author: Yunzhao Li
# Date: 26 March 2024
# Contact: yunzhao.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
install.packages("tidyverse")
library(tidyverse)

#### Clean data ####
aerial_priority <- read_csv("data/raw_data/aerial_priority.csv")

cleaned_aerial_priority <-
  clean_names(aerial_priority) |>
  filter(
    tgt_country == "germany", !is.na(tgt_priority_explanation)
  ) |>
  select(tgt_priority_explanation, tgt_type, tgt_industry, country_flying_mission, msn_type, total_tons, ac_attacking
)

head(cleaned_aerial_priority)



#### Save data ####
write_csv(cleaned_data, "outputs/data/analysis_data.csv")

