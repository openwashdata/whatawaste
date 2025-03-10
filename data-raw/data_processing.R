# Description ------------------------------------------------------------------
# R script to process uploaded raw data into a tidy, analysis-ready data frame
# Load packages ----------------------------------------------------------------
## Run the following code in console if you don't have the packages
## install.packages(c("usethis", "fs", "here", "readr", "readxl", "openxlsx"))
library(usethis)
library(fs)
library(here)
library(readr)
library(readxl)
library(openxlsx)
library(dplyr)

# Read data --------------------------------------------------------------------
data_in <- readr::read_csv("data-raw/country_level_data.csvins") %>%
  janitor::clean_names()
# codebook <- readxl::read_excel("data-raw/codebook.xlsx") |>
#  clean_names()

# Tidy data --------------------------------------------------------------------
## Clean the raw data into a tidy format here
countrylevel <- data_in %>%
  select(iso3c:gdp)

# Export Data ------------------------------------------------------------------
usethis::use_data(countrylevel, overwrite = TRUE)
fs::dir_create(here::here("inst", "extdata"))
readr::write_csv(countrylevel,
                 here::here("inst", "extdata", paste0("countrylevel", ".csv")))
openxlsx::write.xlsx(countrylevel,
                     here::here("inst", "extdata", paste0("countrylevel", ".xlsx")))
