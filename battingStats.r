library(RCurl)
library(XML)

battingStats <- function(startDate, endDate){
  url <- paste(
    "http://www.baseball-reference.com",
    "/leagues/daily.cgi",
    "?",
    paste(
      "user_team=", 
      "bust_cache=",
      "type=b",
      "lastndays=7",
      "dates=fromandto",
      "fromandto=",
      paste(
        startDate,
        endDate,
        sep = "."
      ),
      "level=mlb",
      "franch=",
      "stat=",
      "stat_value=0",
      sep = "&"
    ),
    sep = ""
  )

  rawTable <-
    readHTMLTable(
      getURL(url, .opts = list(followlocation = TRUE)))

  return (url)
}
