draftees <- read.csv('D1_Draftees.csv')

hitters <- draftees %>%
  filter(person_primary_position_code != 1)

write.csv(hitters, "D1_Hitters.csv", row.names = FALSE)
