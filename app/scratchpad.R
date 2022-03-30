library(tidyverse)
library(tidylog)
library(readxl)
library(janitor)

old <- read_excel('app/data/2018-19_School_Grades_683671_7.xlsx')
# I have no clue where I got the 2020-21 file from...
new <- read_excel('app/data/2020-21_School_Grades_Results_741650_7.xlsx')

compare_df_cols(
  old, new
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

## -------------------------------------
## Fact table
fctTable <- old %>% 
  select(-starts_with('PeerBuilding')) %>% 
  select(
    all_of(IDS),
    !all_of(DIMS)
  ) %>% 
  mutate_all(as.character) %>% 
  pivot_longer(
    cols=!c(AcademicYear, ISDCode, DistrictCode, BuildingCode)
  ) %>% 
  mutate(category = case_when(
    str_starts(name, 'Proficiency') ~ 'Proficiency',
    str_starts(name, 'Growth') ~ 'Growth',
    str_starts(name, 'GradRate') ~ 'Graduation',
    str_starts(name, 'EL') ~ 'Engligh Learner',
    str_starts(name, 'PeerCompare') ~ 'Peer Compare',
    str_starts(name, 'OnTrackAttendance') ~ 'Attendance',
    str_starts(name, 'Participation') ~ 'Participation',
    str_starts(name, 'SubgroupPerformance') ~ 'Subgroup Performance'
  )) %>% 
  rename(
    subcategory = name
  ) %>% 
  select(
    AcademicYear, ISDCode, DistrictCode, BuildingCode, category, subcategory, value
  )
  
## -------------------------------------
## Dimension table
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
