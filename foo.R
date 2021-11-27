library(tidyverse)
library(readxl)
library(janitor)

old <- read_excel('data/2018-19_School_Grades_683671_7.xlsx')
new <- read_excel('data/2020-21_School_Grades_Results_741650_7.xlsx')

compare_df_cols(
  old, new
)

MATCHES <- c(
  'ISD',
  'District',
  '^Building',
  'Proficiency',
  'Growth',
  'PeerCompare',
  'OnTrack',
  'Participation',
  'Subgroup',
  'Identification'
) %>% 
  paste0(collapse='|')

INDEXES <- c(
  'AcademicYear',
  'ISD',
  'District',
  '^Building'
) %>% 
  paste0(collapse='|')

# isAEC schools
both <- bind_rows(
  old, new
) 

both %>% 
  select(
    AcademicYear,
    matches(MATCHES),
  ) %>% 
  mutate_at(vars(-matches(INDEXES)), as.character) %>% 
  pivot_longer(cols=-matches(INDEXES))
