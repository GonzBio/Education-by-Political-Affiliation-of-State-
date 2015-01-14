library(dplyr)
library(ggplot2)
#dataset downloaded from KIDS COUNT data center
data <- read.csv("./HighSchoolGrads.csv")
#the rows showing percent were extracted
dataStates <- data[data$DataFormat %in% "Percent", ]
#calculated the mean percentage of high school students earning a bachelor or higher degree from 2000 to 2012
meanStates <- dataStates %>%
  group_by(Location) %>%
  summarise(mean(Data))
#deleted row containing data from Puerto Rico and USA (national data)
meanStates1 <- meanStates[-c(40, 46)]
#dataset containing results of general elections by State
GeneralElections <- read.csv("/GeneralElections.csv")
#added column containing mean percentage of of high school students earning a bachelor or higher degree from 2000 to 2012 to dataset with the results of general elections in 2012
Fdata <- cbind(GeneralElections, meanStates1$Education)
colnames(Fdata) <- c("State", "yr2000", "yr2004", "yr2008", "yr2012", "HigherEd")
#ploted data
ggplot(Fdata, aes(x = State, y = HigherEd)) + geom_boxplot(aes(factor(yr2012)), fill = c("lightblue", "red")) + geom_jitter(aes(factor(yr2012))) + ylab("High school graduates ages 25 to 29 who have completed a bachelor's degree or higher") + xlab("Results of 2012 General Elections by Party")

