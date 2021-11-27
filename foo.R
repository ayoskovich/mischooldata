library(tidyverse)
library(tidylog)
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
  'Identification',
  'IsAECSchool'
) %>% 
  paste0(collapse='|')

INDEXES <- c(
  'AcademicYear',
  'ISD',
  'District',
  '^Building',
  'IsAECSchool'
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
  pivot_longer(cols=-matches(INDEXES)) %>% 
  mutate(
    rate_type = case_when(
      str_detect(name, 'LetterGrade') ~ 'letter grade',
      str_detect(name, 'Label') ~ 'rank',
      TRUE ~ 'numeric value'
    ),
    category = case_when(
      str_starts(name, 'Proficiency') ~ 'Proficiency',
      str_starts(name, 'Growth') ~ 'Growth',
      str_starts(name, 'PeerCompare') ~ 'PeerCompare',
      str_starts(name, 'OnTrackAttendance') ~ 'OnTrackAttendance',
      str_starts(name, 'Participation') ~ 'Participation',
      str_starts(name, 'SubgroupPerformance') ~ 'SubgroupPerformance',
      str_starts(name, 'Identification') ~ 'ID'
    )
  ) %>% 
  filter(is.na(rate_type)) %>% 
  View()
