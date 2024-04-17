#### Preamble ####
# Purpose: Create GLM on cleaned data
# Author: Yunzhao Li
# Date: 16 April 2024
# Contact: yunzhao.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
library(rstanarm)  # Load the rstanarm package for Bayesian modeling
library(arrow)     # Load the arrow package to read Parquet files
library(dplyr)

#### Read data ####
cleaned_aerial_priority <- read_parquet("data/analysis_data/cleaned_aerial_priority.parquet")

### Model data ####

# Random sampling if needed
set.seed(302)
sampled_data <- cleaned_aerial_priority %>%
  sample_n(1000)

# Ensure the response is an ordered factor
sampled_data$tgt_priority_explanation <- factor(
  sampled_data$tgt_priority_explanation,
  levels = c("target of last resort", "target of opportunity", "secondary target", "primary target"),
  ordered = TRUE
)

# Convert categorical predictors to factors
sampled_data$tgt_industry <- factor(sampled_data$tgt_industry)
sampled_data$country_flying_mission <- factor(sampled_data$country_flying_mission)

# Build a Bayesian ordered logistic regression model using stan_polr
aerial_priority_model <- stan_polr(
  formula = tgt_priority_explanation ~ tgt_industry + country_flying_mission + total_tons + ac_attacking,
  data = sampled_data,
  method = "logistic",  # Use logistic cumulative link model
  prior = NULL,  # Use default priors to simplify the model
  prior_counts = NULL  # Use default priors for the intercepts
)

# Print the summary of the model to inspect the results
print(summary(aerial_priority_model))

# Optional: Plot the effects to visualize the model results
plot(aerial_priority_model)


#### Save model ####
saveRDS(
  aerial_priority_model,
  file = "models/aerial_priority_model.rds"
)
