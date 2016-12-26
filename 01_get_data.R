library(rvest)
library(stringr)
library(ggplot2)

#cities = c("kyiv", "lviv", "odesa", "kharkiv", "dnipro")

get_dalyight_data <- function(city = "kyiv", year = 2016) {
  
  data <- data.frame(stringsAsFactors = F)
  
  for(i in 1:12) {
    
    url <- paste0("https://www.timeanddate.com/sun/ukraine/", city, "?month=",
                  i, "&year=", year)
    
    page <- html_session(url)
    
    day <- page %>% 
      html_nodes('tbody th') %>% 
      html_text()
    
    start <- page %>% 
      html_nodes('th+ td') %>% 
      html_text()
    
    end <- page %>% 
      html_nodes('td:nth-child(3)') %>% 
      html_text()
    
    df <- data.frame(year = year, month = i, day, start, end, city)
    
    data <- rbind.data.frame(data, df)
    
    Sys.sleep(5)
    
  }
  
  return(data)
  
}

df <- get_dalyight_data(city = "kyiv")

write.csv(df, "~/R/daylight/data/kyiv.csv", row.names = F)