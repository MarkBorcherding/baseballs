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
      #mlb_id <- gsub(".*mlb_ID=", "", xmlGetAttr(node, "data-append-csv"))
      paste(
        val,
        "mlb_id",
        sep = "::")
    } else {
      as.character(val)
    }
  }

  table <-
    readHTMLTable(
      getURL(url, .opts = list(followlocation = TRUE)),
      elFun = extractMLB_ID,
      )$daily

  return (table[table$RBI != "RBI", ])
}
