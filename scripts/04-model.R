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
library(ggplot2)
library(modelsummary)

#### Read data ####
cleaned_aerial_priority <- read_parquet("data/analysis_data/cleaned_aerial_priority.parquet")

### Model data ####

# Random sampling if needed
set.seed(302)
sampled_data <- cleaned_aerial_priority %>%
  sample_n(1000)

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

prior_summary(aerial_priority_model)

pp_check(aerial_priority_model) +
  theme_classic() +
  theme(legend.position = "bottom")

posterior_vs_prior(aerial_priority_model) +
  theme_minimal() +
  scale_color_brewer(palette = "Set1") +
  theme(legend.position = "bottom") +
  coord_flip()

plot(aerial_priority_model, "trace")

plot(aerial_priority_model, "rhat")

#### Save model ####
saveRDS(
  aerial_priority_model,
  file = "models/aerial_priority_model.rds"
)