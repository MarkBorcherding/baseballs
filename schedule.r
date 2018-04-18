games <- read.csv("./data/2018-schedule.csv", header = FALSE )
names(games) <- c(
  "Date",
  "GameNumber",
  "DayOfWeek",
  "VisitorTeam",
  "VistorLeague",
  "VisitorSeasonGameNumber",
  "HomeTeam",
  "HomeLeague",
  "HomeSeasonGameNumber",
  "DayNight",
  "PostponeIndicator",
  "DateOfMakeup"
)

today <- strftime(Sys.Date(), '%Y%m%d')
gameDays <- unique(schedule$Date)

schedule <- list(
  games = games,
  today = today
  gameDays = gameDayes
  statDays = gameDays[gameDays < today]
)
