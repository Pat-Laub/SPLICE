library(SPLICE)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

################################################################################
################################################################################

# Create directories "complexity_1", ..., "complexity_5" to organise datasets.
for (i in c(1:5)) {
  directory <- paste0("complexity_", i, "/")
  dir.create(file.path(directory), showWarnings = FALSE)
}

datasets <- list()

# Scenario 1 - simple, homogeneous claims experience, with zero inflation
datasets[[1]] <- generate_data(
  n_claims_per_period = 90,
  n_periods = 40,
  complexity = 1,
  random_seed = 42)

# Scenario 2 - slightly more complex than 1 but still chain ladder compatible, with
# dependence of notification delay and settlement delay on claim size and 2%
# p.a. base inflation
datasets[[2]] <- generate_data(
  n_claims_per_period = 90,
  n_periods = 40,
  complexity = 2,
  random_seed = 42)

# Scenario 3 - steady increase in claim processing speed over occurrence periods
# (i.e. steady decline in settlement delays)
datasets[[3]] <- generate_data(
  n_claims_per_period = 90,
  n_periods = 40,
  complexity = 3,
  random_seed = 42)

# Scenario 4 - inflation shock at time 30 (from 0% to 10% p.a.)
datasets[[4]] <- generate_data(
  n_claims_per_period = 90,
  n_periods = 40,
  complexity = 4,
  random_seed = 42)

# Scenario 5 - default distributional models, with complex dependence structures
# (e.g. dependence of settlement delay on claim occurrence period)
datasets[[5]] <- generate_data(
  n_claims_per_period = 90,
  n_periods = 40,
  complexity = 5,
  random_seed = 42)

# Save as csv files
for (i in c(1:5)) {
  dataset <- datasets[[i]]
  directory <- paste0("complexity_", i, "/")
  write.csv(dataset$claim_dataset, paste0(directory, "claim_", i, ".csv"))
  write.csv(dataset$payment_dataset, paste0(directory, "payment_", i, ".csv"))
  write.csv(dataset$incurred_dataset, paste0(directory, "incurred_", i, ".csv"))
}

################################################################################
# Generate claims datasets with SynthETIC's default covariates claim size
#   adjustments
################################################################################

# Requires SynthETIC >= 1.1.0
if (packageVersion("SynthETIC") >= "1.1.0") {
  datasets_cov <- list()

  datasets_cov[[1]] <- generate_data(
      n_claims_per_period = 90,
      n_periods = 40,
      complexity = 1,
      random_seed = 42,
      covariates_obj = SynthETIC::test_covariates_obj)

  datasets_cov[[2]] <- generate_data(
      n_claims_per_period = 90,
      n_periods = 40,
      complexity = 2,
      random_seed = 42,
      covariates_obj = SynthETIC::test_covariates_obj)

  datasets_cov[[3]] <- generate_data(
      n_claims_per_period = 90,
      n_periods = 40,
      complexity = 3,
      random_seed = 42,
      covariates_obj = SynthETIC::test_covariates_obj)

  datasets_cov[[4]] <- generate_data(
      n_claims_per_period = 90,
      n_periods = 40,
      complexity = 4,
      random_seed = 42,
      covariates_obj = SynthETIC::test_covariates_obj)

  datasets_cov[[5]] <- generate_data(
      n_claims_per_period = 90,
      n_periods = 40,
      complexity = 5,
      random_seed = 42,
      covariates_obj = SynthETIC::test_covariates_obj)

  # Save as csv files
  for (i in c(1:5)) {
    dataset <- datasets_cov[[i]]
    directory <- paste0("complexity_", i, "/")
    write.csv(dataset$claim_dataset, paste0(directory, "claim_", i, "_cov.csv"))
    write.csv(dataset$payment_dataset, paste0(directory, "payment_", i, "_cov.csv"))
    write.csv(dataset$incurred_dataset, paste0(directory, "incurred_", i, "_cov.csv"))
    write.csv(dataset$covariates_data$data, paste0(directory, "covariates_", i, "_cov.csv"))
  }
}
