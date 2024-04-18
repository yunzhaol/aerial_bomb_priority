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
# Set seed for reproducibility
set.seed(23)

# Create a tibble with simulated data for aerial missions
simulated_aerial_data <- tibble(
  # Simulate target priority levels as a factor with ordered levels
  tgt_priority = factor(
    sample(c("target of last resort", "target of opportunity", "primary target"), 
           1000, replace = TRUE), 
    levels = c("target of last resort", "target of opportunity", "primary target")
  ),
  
  # Simulate target industry types
  tgt_industry = sample(c("unidentified targets", "synthetic oil refineries"), 
                        1000, replace = TRUE),
  
  # Simulate the country executing the mission
  country_mission = sample(c("usa", "great britain", "others"), 
                                  1000, replace = TRUE),
  
  # Simulate the total tons of bombs dropped
  bomb_tons = sample(1:40, 1000, replace = TRUE),
  
  # Simulate the number of aircraft involved in the attack
  aircraft_attack = sample(1:20, 1000, replace = TRUE)
)

# Display the first few rows of the simulated data
head(simulated_aerial_data)

