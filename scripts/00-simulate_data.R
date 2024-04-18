#### Preamble ####
# Purpose: Simulates an analysis dataset about the aerial bombing campaigns against Germany
# Author: Yunzhao Li
# Date: 16 April 2024
# Contact: yunzhao.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: None



#### Workspace setup ####
library(tidyverse)
library(janitor)

#### Simulate data ####
set.seed(23)

simulated_aerial_data <- tibble(
  tgt_priority_explanation = factor(sample(c("target of last resort", "target of opportunity", "primary target"), 1000, replace = TRUE), levels = c("target of last resort", "target of opportunity", "primary target")),
  tgt_industry = sample(c("unidentified targets", "synthetic oil refineries"), 1000, replace = TRUE),
  country_flying_mission = sample(c("usa", "great britain", "others"), 1000, replace = TRUE),
  total_tons = sample(1:40, 1000, replace = TRUE),
  ac_attacking = sample(1:20, 1000, replace = TRUE)
)

head(simulated_aerial_data)
