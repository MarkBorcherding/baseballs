library(tidyr)
positions <- read.csv("./data/2017-player-position-appearances.csv")
positions <- separate(positions, Name, c("Name", "ID"), sep = "\\\\")
