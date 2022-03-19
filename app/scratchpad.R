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

# Dream fct table:
tribble(
  ~id, ~category, ~subcategory, ~value,
  1, 'proficiency', 'letter grade', 'A',
  1, 'proficiency', 'math rate', .56,
  1, 'proficiency', 'ela rate', .72,
  1, 'growth', 'letter grade', .72,
  ...
)

IDS <- c(
  'AcademicYear', 'ISDCode', 'DistrictCode', 'BuildingCode'
)
DIMS <- c(
  'ISDName', 'DistrictName', 'BuildingName',
  'EntityCategory', 'GradeList', 
  'IsAECSchool', 'AECMeetsLawAssurance', 'AECSummaryStatus',
  'IdentificationType', 'IdentificationReason'
)

fctTable <- old %>% 
  select(
    all_of(IDS),
    !all_of(DIMS)
  )
  
comb_peers <- function(x){
  # Combine list of peer schools from multiple columns
  list(x %>% as.numeric())
}

dimTable <- old %>% 
  rowwise() %>% 
  mutate(peer_list = comb_peers(c_across(starts_with('PeerBuilding')))) %>% 
  select(
    all_of(IDS), 
    all_of(DIMS),
    peer_list
  )
