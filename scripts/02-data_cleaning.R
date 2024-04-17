#### Preamble ####
# Purpose: Cleans the raw data to prepare for model
# Author: Yunzhao Li
# Date: 16 April 2024
# Contact: yunzhao.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
library(arrow)
library(tidyverse)
library(janitor)
library(readr)
library(stringr)
library(forcats)

#### Clean data ####
aerial_priority <- read_parquet("data/raw_data/aerial_priority.parquet")

cleaned_aerial_priority <-
  clean_names(aerial_priority) |>
  filter(
    tgt_country == "GERMANY", 
    tgt_industry %in% c("\"RR INSTALLATIONS,  TRACKS,  MARSHALLING YARDS,  AND STATIONS\"", "SYNTHETIC OIL REFINERIES", 
                        "AIR FIELDS AND AIRDROMES", "CITIES TOWNS AND URBAN AREAS", 
                        "UNIDENTIFIED TARGETS") ) |>
  select(tgt_priority_explanation, tgt_industry, 
         country_flying_mission, total_tons, ac_attacking) |>
  mutate(
    # Convert all character data to lowercase before any other operation
    across(where(is.character), tolower),
    # Replace NA with "others" in 'country_flying_mission' and make sure it's a character
    country_flying_mission = if_else(is.na(country_flying_mission), "others", as.character(country_flying_mission)),
    # Recode 'tgt_industry' to more general categories and convert to factor after 'tolower'
    tgt_industry = case_when(
      tgt_industry == "\"rr installations,  tracks,  marshalling yards,  and stations\"" ~ "railway infrastructure",
      tgt_industry == "air fields and airdromes" ~ "air fields",
      tgt_industry == "cities towns and urban areas" ~ "urban areas",
      TRUE ~ as.character(tgt_industry)  # Keep all other industries as they are
    )
  ) %>%
  # Now convert 'country_flying_mission' and 'tgt_industry' to factor type
  mutate(
    country_flying_mission = factor(country_flying_mission),
    tgt_industry = factor(tgt_industry),
    # Convert 'tgt_priority_explanation' to an ordered factor
    tgt_priority_explanation = factor(tgt_priority_explanation, levels = c("target of last resort", "target of opportunity", "secondary target", "primary target"), ordered = TRUE)
  ) %>%
  filter(complete.cases(tgt_priority_explanation, tgt_industry, country_flying_mission, total_tons, ac_attacking))

# tgt_priority_explanation: Indicates the priority level of the target, reflecting strategic importance assigned to the target within a mission.
# tgt_industry: Specifies the specific industry of the target, such as weapons manufacturing, fuel processing, etc.
# country_flying_mission: Represents the country executing the flying mission, reflecting which nation's air force units participated in the specific bombing.
# total_tons: Represents the total tons of bombs dropped during a mission, reflecting the attack intensity on the target.
# ac_attacking: Represents the total number of aircraft involved in the attack, which can be used to measure the scale and force of an attack.

view((cleaned_aerial_priority))

#### Save data ####
write_parquet(cleaned_aerial_priority, "data/analysis_data/cleaned_aerial_priority.parquet") 
write_csv(cleaned_aerial_priority, "data/analysis_data/cleaned_aerial_priority.csv") 
