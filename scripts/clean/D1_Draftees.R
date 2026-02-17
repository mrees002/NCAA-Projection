library(dplyr)
library(stringr)

# Read the data
mlb_draft <- read.csv("All_Drafted_Players_2011_2022.csv")
d1_schools <- read.csv("D1_Baseball_Teams.csv")

# Clean D1 school names - extract the short name in parentheses when available
d1_schools <- d1_schools %>%
  mutate(
    # Extract the name in parentheses
    short_name = str_extract(School..Branded.as.or.widely.known.as., "(?<=\\().*(?=\\))"),
    # Get the main part before newline
    full_name = str_extract(School..Branded.as.or.widely.known.as., "^[^\n]+"),
    # Create simplified version - remove "University", "of", "at", "The"
    simple_name = str_remove_all(full_name, " University| College") %>%
      str_remove_all("^University of |^The ") %>%
      str_remove_all(" at .*")
  )

# Create a comprehensive list of all D1 school name variations
d1_name_list <- unique(c(
  d1_schools$short_name[!is.na(d1_schools$short_name)],
  d1_schools$simple_name,
  d1_schools$full_name
))

# Filter for rounds 1-10 and match with D1 schools using fuzzy matching
college_rounds_1_10 <- mlb_draft %>%
  filter(pick_round %in% 1:10) %>%
  filter(!grepl(" HS$| HS\"|High School", school_name, ignore.case = TRUE)) %>%
  # Try to match school names (allowing for slight variations)
  filter(school_name %in% d1_name_list | 
           # Also try matching with simplified version
           str_remove_all(school_name, " -.*| \\(.*") %in% d1_name_list)


write.csv(college_rounds_1_10, "D1_Draftees.csv", row.names = FALSE)
