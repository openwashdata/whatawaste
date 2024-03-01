
<!-- README.md is generated from README.Rmd. Please edit that file -->

# whatawaste

<!-- badges: start -->
<!-- badges: end -->

The goal of whatawaste is to …

## Installation

You can install the development version of whatawaste from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("openwashdata/whatawaste")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(whatawaste)
## basic example code
```

    #>   iso3c region_id country_name income_id      gdp
    #> 1   ABW       LCN        Aruba       HIC 35563.31
    #>   composition_food_organic_waste_percent composition_glass_percent
    #> 1                                     NA                        NA
    #>   composition_metal_percent composition_other_percent
    #> 1                        NA                        NA
    #>   composition_paper_cardboard_percent composition_plastic_percent
    #> 1                                  NA                          NA
    #>   composition_rubber_leather_percent composition_wood_percent
    #> 1                                 NA                       NA
    #>   composition_yard_garden_green_waste_percent
    #> 1                                          NA
    #>   other_information_information_system_for_solid_waste_management
    #> 1                                                            <NA>
    #>   other_information_national_agency_to_enforce_solid_waste_laws_and_regulations
    #> 1                                                                           Yes
    #>   other_information_national_law_governing_solid_waste_management_in_the_country
    #> 1                                                                            Yes
    #>   other_information_ppp_rules_and_regulations
    #> 1                                         Yes
    #>   other_information_summary_of_key_solid_waste_information_made_available_to_the_public
    #> 1                                                                                   Yes
    #>   population_population_number_of_people
    #> 1                                 103187
    #>   special_waste_agricultural_waste_tons_year
    #> 1                                         NA
    #>   special_waste_construction_and_demolition_waste_tons_year
    #> 1                                                        NA
    #>   special_waste_e_waste_tons_year special_waste_hazardous_waste_tons_year
    #> 1                              NA                                      NA
    #>   special_waste_industrial_waste_tons_year
    #> 1                                       NA
    #>   special_waste_medical_waste_tons_year total_msw_total_msw_generated_tons_year
    #> 1                                    NA                                88132.02
    #>   waste_collection_coverage_rural_percent_of_geographic_area
    #> 1                                                         NA
    #>   waste_collection_coverage_rural_percent_of_households
    #> 1                                                    NA
    #>   waste_collection_coverage_rural_percent_of_population
    #> 1                                                    NA
    #>   waste_collection_coverage_rural_percent_of_waste
    #> 1                                               NA
    #>   waste_collection_coverage_total_percent_of_geographic_area
    #> 1                                                         NA
    #>   waste_collection_coverage_total_percent_of_households
    #> 1                                                    NA
    #>   waste_collection_coverage_total_percent_of_population
    #> 1                                                    NA
    #>   waste_collection_coverage_total_percent_of_waste
    #> 1                                               NA
    #>   waste_collection_coverage_urban_percent_of_geographic_area
    #> 1                                                         NA
    #>   waste_collection_coverage_urban_percent_of_households
    #> 1                                                    NA
    #>   waste_collection_coverage_urban_percent_of_population
    #> 1                                                    NA
    #>   waste_collection_coverage_urban_percent_of_waste
    #> 1                                               NA
    #>   waste_treatment_anaerobic_digestion_percent waste_treatment_compost_percent
    #> 1                                          NA                              NA
    #>   waste_treatment_controlled_landfill_percent
    #> 1                                          NA
    #>   waste_treatment_incineration_percent
    #> 1                                   NA
    #>   waste_treatment_landfill_unspecified_percent
    #> 1                                           NA
    #>   waste_treatment_open_dump_percent waste_treatment_other_percent
    #> 1                                NA                            NA
    #>   waste_treatment_recycling_percent
    #> 1                                11
    #>   waste_treatment_sanitary_landfill_landfill_gas_system_percent
    #> 1                                                            NA
    #>   waste_treatment_unaccounted_for_percent
    #> 1                                      89
    #>   waste_treatment_waterways_marine_percent where_where_is_this_data_measured
    #> 1                                       NA                              <NA>
