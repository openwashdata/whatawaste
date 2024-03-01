library(tidyverse)
library(tibble)

# COUNTRY LEVEL DATA -----------------------------------------------------------
countrylevel <- readr::read_csv("data-raw/country_level_data.csv")
## Modify data types -----------------------------------------------------------
countrylevel <- countrylevel |>
  dplyr::mutate(dplyr::across(c("region_id", "income_id"), as.factor)) |>
  dplyr::mutate(dplyr::across(starts_with("other_information_"), as.factor))

skimr::skim(citylevel)
# CITY LEVEL DATA --------------------------------------------------------------
citylevel <- readr::read_csv("data-raw/city_level_data_0_0.csv")
## Modify data types -----------------------------------------------------------
citylevel <- citylevel |>
  dplyr::mutate(dplyr::across(c("region_id", "income_id"), as.factor)) |>
  dplyr::mutate(dplyr::across(ends_with("_na"), as.factor))

# Create dictionary
countrydict <- tibble(directory = "data",
                      file_name = "countrylevel.rda",
                      variable_name = colnames(countrylevel),
                      variable_type =  sapply(countrylevel, typeof),
                      description = NA)
citydict <- tibble(directory = "data",
                   file_name = "citylevel.rda",
                   variable_name = colnames(citylevel),
                   variable_type =  sapply(citylevel, typeof),
                   description = NA)
dict <- rbind(countrydict, citydict)
# readr::write_csv(dict, "data-raw/dictionary.csv")

usethis::use_data(countrylevel, overwrite = TRUE)
usethis::use_data(citylevel, overwrite = TRUE)
