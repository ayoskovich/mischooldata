library(tidyverse)
library(tidylog)
library(readxl)
library(janitor)

old <- read_excel('app/data/2018-19_School_Grades_683671_7.xlsx')
new <- read_excel('app/data/2020-21_School_Grades_Results_741650_7.xlsx')

compare_df_cols(
  old, new
)

# Combine peer list
old %>% 
  select(
    AcademicYear, ISDCode, DistrictCode, BuildingCode, 
    starts_with('PeerBuilding')
  ) %>% 
  mutate(peer_list = paste0(c_across(starts_with('PeerBuilding')), collapse=',')) %>% 
  select(-starts_with('PeerBuilding'))

# Proficiency, Growth, Graduation, EL, PAP, Subgroup, Attendance, Participation
old %>% 
  select(-starts_with('PeerBuilding')) %>% 
  names()
