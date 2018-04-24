library(RCurl)
library(XML)
library(tidyr)

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
        sep = "."),
      "level=mlb",
      "franch=",
      "stat=",
      "stat_value=0",
      sep = "&"),
    sep = "")

  extractMLB_ID <- function(node, encoding) {
    stat <- xmlGetAttr(node, "data-stat")
    val <- xmlValue(node)
    td <- xmlName(node) == "td"
    if(td & stat == "player"){
      mlb_id <- gsub(".*mlb_ID=", "", xmlGetAttr(node, "data-append-csv"))
      paste(
        val,
        mlb_id,
        sep = "::")
    } else {
      as.character(val)
    }
  }

  table <-
    getURL(url, .opts = list(followlocation = TRUE)) %>%
    readHTMLTable(elFun = extractMLB_ID) %>%
    with(daily)

  # remove the heading rows  mixed in
  table <- table[table$RBI != "RBI", ] 

  # Parse the name column to separate the name from the id
  n <- table$Name %>%
       as.data.frame %>%
       separate(col=1, into=c("Name", "MLB_ID"), sep="::")
  table$Name <- n$Name
  table$MLB_ID <- n$MLB_ID

  return (table)
}
