source('./batters.r')

batters <- getBatters()

library(tidyr)
positions <- read.csv("./data/2017-player-position-appearances.csv")
positions <- separate(positions, Name, c("Name", "ID"), sep = "\\\\")


pitchers <- read.csv("./data/2018-in-season-pitching-standard.csv")
pitchers$K_9 <- with(pitchers, SO / (IP / 9))
pitchers$K_BB <- with(pitchers, SO / (BB + IBB))
pitchers$OBPA <- with(pitchers, (H + BB + IBB) / TBF)


write.csv(batters, file="./2018-score-batters.csv")
