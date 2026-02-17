library(baseballr)
library(dplyr)

years <- 2011:2022
draft_list <- lapply(years, function(yr) {
  message(paste("Fetching year:", yr))  # Optional: shows progress
  
  draft <- mlb_draft(year = yr)
  draft$draft_year <- yr  # Add year column
  
  Sys.sleep(2)  # 2 second delay between requests
  
  return(draft)
})

draft_data <- bind_rows(draft_list)

write.csv(draft_data, "All_Drafted_Players_2011_2022.csv", row.names = FALSE)
