batters <- read.csv("./data/2018-in-season-batting-standard.csv")

batters$OBP <- with(batters, (H + BB + IBB + HBP) / (AB + BB + IBB + HBP + SF))
batters$TB <- with(batters, X1B + (2 * X2B) + (3 * X3B) + (4 * HR))

R_m = mean(batters$R)
R_sd = sd(batters$R)
batters$R_Score <- with(batters, (R - R_m) / R_sd)

RBI_m = mean(batters$RBI)
RBI_sd = sd(batters$RBI)
batters$RBI_Score <- with(batters, (RBI - RBI_m) / RBI_sd)


BB_m = mean(batters$BB)
BB_sd = sd(batters$BB)
batters$BB_Score <- with(batters, (BB - BB_m) / BB_sd)


TB_m = mean(batters$TB)
TB_sd = sd(batters$TB)
batters$TB_Score <- with(batters, (TB - TB_m) / TB_sd)

OBP_m = mean(batters$OBP)
OBP_sd = sd(batters$OBP)
batters$OBP_Score <- with(batters, (OBP - OBP_m) / OBP_sd)

batters$TotalScore <- with(batters, R_Score + RBI_Score + BB_Score + TB_Score + OBP_Score)

batters <- batters[with(batters, order(-TotalScore)),]

write.csv(batters, file="./2018-score-batters.csv")
