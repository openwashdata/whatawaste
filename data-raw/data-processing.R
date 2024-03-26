library(tidyverse)
library(tibble)

# COUNTRY LEVEL DATA -----------------------------------------------------------
countrylevel <- readr::read_csv("data-raw/country_level_data.csv")
## Modify data types -----------------------------------------------------------
countrylevel <- countrylevel |>
  dplyr::mutate(dplyr::across(c("region_id", "income_id"), as.factor)) |>
  dplyr::mutate(dplyr::across(starts_with("other_information_"), as.factor))

##
extract_group <- function(dataset, prefix, suffix = "percent") {
  if (suffix == "") {
    dataset |>
      dplyr::select(c("iso3c", starts_with(prefix))) |>
      tidyr::pivot_longer(
        cols = starts_with(prefix),
        names_to = "type",
        names_pattern = paste0(prefix, "(.*)_")
      )
  } else {
    dataset |>
      dplyr::select(c("iso3c", starts_with(prefix))) |>
      tidyr::pivot_longer(
        cols = starts_with(prefix),
        names_to = "type",
        names_pattern = paste0(prefix, "(.*)_", suffix),
        values_to = suffix
      )
  }
}

extract_country_group <- function(prefix, suffix = "percent") {
  extract_group(countrylevel, prefix, suffix)
}

extract_city_group <- function(prefix, suffix = "percent") {
  extract_group(citylevel, prefix, suffix)
}

country_composition <- extract_country_group(prefix = "composition_")
country_specialwaste <- extract_country_group(prefix = "special_waste_", suffix = "tons_year")
country_wastetreatment <- extract_country_group(prefix = "waste_treatment_")
country_collectcov <- extract_country_group(prefix = "waste_collection_coverage_", suffix = "")

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
