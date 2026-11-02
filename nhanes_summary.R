#!/usr/bin/env Rscript

required_packages <- c("readr", "dplyr")
for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg, repos = "https://cloud.r-project.org")
  }
}

library(readr)
library(dplyr)

candidate_roots <- unique(c(
  getwd(),
  dirname(getwd()),
  dirname(dirname(getwd()))
))

candidate_paths <- unlist(lapply(
  candidate_roots,
  function(root) {
    file.path(root, "examples", "nhanes-equity", "data", "nhanes_equity_v6.csv")
  }
))

nhanes_path <- candidate_paths[file.exists(candidate_paths)][1]
if (is.na(nhanes_path)) {
  stop("Could not find examples/nhanes-equity/data/nhanes_equity_v6.csv")
}

nhanes_analysis <- read_csv(nhanes_path, show_col_types = FALSE)

summary_table <- nhanes_analysis |>
  summarise(
    rows = n(),
    missing_bmi = sum(is.na(BMI)),
    missing_income = sum(is.na(IncomeGroup))
  )

print(summary_table)
