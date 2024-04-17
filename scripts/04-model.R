#### Preamble ####
# Purpose: Create GLM on cleaned data
# Author: Yunzhao Li
# Date: 16 April 2024
# Contact: yunzhao.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

install.packages("brms")
install.packages("dplyr")
install.packages("arrow")
#### Workspace setup ####
library(brms)  # Load the brms package for Bayesian modeling
library(dplyr) # Load dplyr for data manipulation
library(arrow)

#### Read data ####
cleaned_aerial_priority <- read_parquet("data/analysis_data/cleaned_aerial_priority.parquet")

### Model data ####
# Assuming your data frame is already loaded into `data`
# Build a Bayesian ordered logistic regression model


# Set a seed for reproducibility
set.seed(123)

# Randomly sample 1000 observations from the dataset
sampled_cleaned_aerial_priority <- cleaned_aerial_priority %>%
  sample_n(500)

# Build a Bayesian ordered logistic regression model using the sampled data
aerial_priority_model <- brm(
  formula = tgt_priority_explanation ~ tgt_industry + country_flying_mission + total_tons + ac_attacking,
  data = sampled_cleaned_aerial_priority,
  family = cumulative(),  # Use the cumulative link model appropriate for ordered categorical data
  prior = c(
    set_prior("normal(0, 5)", class = "b"),  # Normal prior for regression coefficients
    set_prior("normal(0, 10)", class = "Intercept")  # Normal prior for the intercept
  ),
  chains = 4,  # Number of chains in the Bayesian inference
  iter = 2000,  # Number of iterations per chain
  control = list(adapt_delta = 0.95)  # Adjust to improve model fitting stability
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


