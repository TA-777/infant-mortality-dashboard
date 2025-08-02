# Load required libraries
library(survival)
library(dplyr)
library(ggplot2)
library(tidyr)

# -------------------------------
# Load COHORT DATA
# -------------------------------
file_cohort <- "cohort_data.txt"
readLines(file_cohort, n = 10) 

hmd_cohort_data <- read.delim(file = file_cohort,
                              skip = 2,
                              header = TRUE,
                              stringsAsFactors = FALSE,
                              sep = "")

# Convert columns
hmd_cohort_data <- hmd_cohort_data %>%
  mutate(
    Age = as.numeric(Age),
    lx = as.numeric(lx),
    dx = as.numeric(dx),
    qx = as.numeric(qx),
    Year = as.character(Year)
  )

# COHORT ESTIMATE
cohort_year <- "1855"
# Derive numeric start years from strings
cohort_start <- as.numeric(substr(cohort_year, 1, 4))
period_start <- as.numeric(period_year)

cohort_sel <- hmd_cohort_data %>% filter(Year == cohort_year)

ages_cohort <- cohort_sel$Age
Sx_cohort <- cohort_sel$lx / max(cohort_sel$lx)

# -------------------------------
# Load PERIOD DATA
# -------------------------------
period_file <- "period_data.txt"  # replace with your actual path

period_data <- read.delim(period_file,
                          skip = 2,
                          header = TRUE,
                          stringsAsFactors = FALSE,
                          sep = "")

# Convert columns
period_data <- period_data %>%
  mutate(
    Age = as.numeric(Age),
    qx = as.numeric(qx),
    Year = as.character(Year)
  )

# PERIOD ESTIMATE (e.g. year 1900)
period_year <- "1870"
period_sel <- period_data %>% filter(Year == period_year)

ages_period <- period_sel$Age
Sx_period <- cumprod(1 - period_sel$qx)

# -------------------------------
# KM ESTIMATE
# -------------------------------
lifespans <- rep(ages_cohort, times = round(cohort_sel$dx))
status <- rep(1, length(lifespans))  # all died

km_fit <- survfit(Surv(time = lifespans, event = status) ~ 1)

# -------------------------------
# Combine all for plotting
# -------------------------------
df_cohort <- data.frame(
  Year     = cohort_start + ages_cohort,
  Survival = Sx_cohort,
  Method   = "Cohort Life Table"
)
df_period <- data.frame(
     Year     = cohort_start + ages_period,   # anchor at 1855, not 1870
     Survival = Sx_period,
     Method   = "Period Life Table"
   )
df_km <- data.frame(
  Year     = cohort_start + km_fit$time,
  Survival = km_fit$surv,
  Method   = "KM Estimate"
)

df_all <- bind_rows(df_cohort, df_period, df_km)
# -------------------------------
# Plot all curves
# -------------------------------
ggplot(df_all, aes(x = Year, y = Survival, color = Method)) +
  geom_step(size = 1.2) +
  labs(title = paste("Survival Curves: Cohort", cohort_year, "vs Period", period_year, "vs KM"),
       x = "Calendar Year", y = "Survival Probability") +
  scale_color_manual(values = c("Cohort Life Table" = "blue",
                                "Period Life Table" = "red",
                                "KM Estimate" = "darkgreen")) +
  theme_minimal(base_size = 14) +
  theme(
    legend.position = "right",
    legend.title = element_blank(),
    plot.margin = margin(10, 20, 10, 10)
  )

