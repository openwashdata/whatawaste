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
city_data_in <- readr::read_csv("data-raw/city_level_data_0_0.csv") |>
  janitor::clean_names()
city_codebook <- readr::read_csv("data-raw/city_level_codebook_0.csv")

country_data_in <- readr::read_csv("data-raw/country_level_data.csv") |>
  janitor::clean_names()
country_codebook <- readr::read_csv("data-raw/country_level_codebook.csv")
# Tidy data --------------------------------------------------------------------
## Clean the raw data into a tidy format here
countrylevel <- country_data_in  |>
  rename(bool_system_for_solid_waste_management=other_information_information_system_for_solid_waste_management) |>
  rename(bool_national_agency_to_enforce_solid_waste_laws_and_regulations=other_information_national_agency_to_enforce_solid_waste_laws_and_regulations) |>
  rename(bool_national_law_governing_solid_waste_management_in_the_country=other_information_national_law_governing_solid_waste_management_in_the_country) |>
  rename(bool_ppp_rules_and_regulations=other_information_ppp_rules_and_regulations) |>
  rename(bool_summary_of_key_solid_waste_information_made_available_to_the_public=other_information_summary_of_key_solid_waste_information_made_available_to_the_public) |>
  rename(population=population_population_number_of_people) |>
  relocate(population, .after = gdp) |>
  rename(municipal_solid_waste_msw_tons_year=total_msw_total_msw_generated_tons_year) |>
  rename(waste_treatment_sanitary_landfill_percent=waste_treatment_sanitary_landfill_landfill_gas_system_percent) |>
  relocate(c(waste_collection_coverage_urban_percent_of_geographic_area,
             waste_collection_coverage_urban_percent_of_households,
             waste_collection_coverage_urban_percent_of_population,
             waste_collection_coverage_urban_percent_of_waste), .before=waste_collection_coverage_total_percent_of_geographic_area) |>
  relocate(waste_treatment_open_dump_percent, .after = waste_treatment_controlled_landfill_percent) |>
  relocate(waste_treatment_sanitary_landfill_percent, .after = waste_treatment_open_dump_percent) |>
  relocate(waste_treatment_landfill_unspecified_percent, .after = waste_treatment_sanitary_landfill_percent) |>
  relocate(waste_treatment_waterways_marine_percent, .after=waste_treatment_landfill_unspecified_percent) |>
  relocate(waste_treatment_recycling_percent, .after=waste_treatment_waterways_marine_percent) |>
  relocate(waste_treatment_incineration_percent, .after = waste_treatment_recycling_percent) |>
  relocate(waste_treatment_other_percent, .after=waste_treatment_incineration_percent) |>
  relocate(waste_treatment_unaccounted_for_percent, .after=waste_treatment_other_percent)

country_data_in |>
  select(other_information_information_system_for_solid_waste_management:other_information_summary_of_key_solid_waste_information_made_available_to_the_public) |>
  lapply(unique)

countrylevel$bool_system_for_solid_waste_management[country_data_in$other_information_information_system_for_solid_waste_management == "None"] <- "No"
countrylevel$bool_national_agency_to_enforce_solid_waste_laws_and_regulations[country_data_in$other_information_national_agency_to_enforce_solid_waste_laws_and_regulations == "None"] <- "No"
countrylevel$bool_national_law_governing_solid_waste_management_in_the_country[country_data_in$other_information_national_law_governing_solid_waste_management_in_the_country == "yes"] <- "Yes"
countrylevel$bool_ppp_rules_and_regulations[country_data_in$other_information_ppp_rules_and_regulations == "None"] <- "No"
countrylevel$bool_summary_of_key_solid_waste_information_made_available_to_the_public[country_data_in$other_information_summary_of_key_solid_waste_information_made_available_to_the_public == "None"] <- "No"
countrylevel$bool_summary_of_key_solid_waste_information_made_available_to_the_public[country_data_in$other_information_summary_of_key_solid_waste_information_made_available_to_the_public == "yes"] <- "Yes"
countrylevel$bool_summary_of_key_solid_waste_information_made_available_to_the_public[country_data_in$other_information_summary_of_key_solid_waste_information_made_available_to_the_public == "MNRE publishes monthly environmental newsletters informing the public about solid waste activities and projects."] <- "Yes"

countrylevel |>
  select(bool_system_for_solid_waste_management:bool_summary_of_key_solid_waste_information_made_available_to_the_public) |>
  lapply(unique)


# Export Data ------------------------------------------------------------------
usethis::use_data(countrylevel, overwrite = TRUE)
fs::dir_create(here::here("inst", "extdata"))
readr::write_csv(countrylevel,
                 here::here("inst", "extdata", paste0("countrylevel", ".csv")))
openxlsx::write.xlsx(countrylevel,
                     here::here("inst", "extdata", paste0("countrylevel", ".xlsx")))
