#### Preamble ####
# Purpose: Downloads and saves the data from
# Author: Yunzhao Li
# Date: 16 April 2024
# Contact: yunzhao.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: None


#### Workspace setup ####
library(tidyverse)
library(arrow)


#### Download data ####
aerial_priority <-
  read_csv(
    here::here("data/raw_data/THOR_WWII_DATA_CLEAN.csv"),
    show_col_types = FALSE
  )

#### Save data ####
# change the_raw_data to whatever name you assigned when you downloaded it.
write_parquet(aerial_priority, "data/raw_data/aerial_priority.parquet")
write_csv(aerial_priority, "data/raw_data/aerial_priority.csv")
