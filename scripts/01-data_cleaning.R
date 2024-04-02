#### Preamble ####
# Purpose: Cleans the raw agriculture data
# Author: Cheng Yang
# Date: 01 April 2024
# Contact: 
# License: MIT

#### WORKPLACE SETUP ####
library(dplyr)
library(tidyverse)
library(arrow)
library(janitor)


#### CLEAN DATA ####
agriculture <- read_excel("data/raw_data/Projected_impacts_datasheet_11.24.2021.xlsx")

agriculture_clean <- agriculture|>
  filter(Region == "Asia", Crop == "Rice", `Publication year` %in% c(2011, 2012, 2013,2014,2015,2016,2017,2018,2019, 2020)) |>
  select(Crop,
         Country,
         Region,
         `Current Average Temperature (dC)_area_weighted`,
         `Current Annual Precipitation (mm) _area_weighted`,
         `Local delta T`,
         `Annual Precipitation change each study  (mm)` ,
         `Projected yield (t/ha)`,
         `Climate impacts per decade (%)`,
         `CO2 ppm`,
         `Publication year`
         ) |>
  clean_names()|>
  na.omit()

write_parquet(agriculture_clean,
              "data/analysis_data/agriculture.parquet")