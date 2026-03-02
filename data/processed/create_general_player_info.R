library(tidyverse)

# Load D1 hitters data from GitHub
url <- "https://raw.githubusercontent.com/mrees002/NCAA-Projection/refs/heads/main/data/raw/D1_Hitters.csv"

d1_hitters <- read_csv(url)

# Keep only general player info
player_info <- d1_hitters %>%
  select(
    name = person_full_name,
    age = person_current_age,
    team = team_name
  ) %>%
  distinct()

# Export CSV
write_csv(player_info, "general_player_info.csv")

head(player_info)
library(tidyverse)

url <- "https://raw.githubusercontent.com/mrees002/NCAA-Projection/refs/heads/main/data/raw/D1_Hitters.csv"

d1_hitters <- read_csv(url)

player_info <- d1_hitters %>%
  select(
    name = person_full_name,
    age = person_current_age,
    position = person_primary_position_abbreviation,
    team = team_name
  ) %>%
  distinct()

write_csv(player_info, "general_player_info.csv")

head(player_info)