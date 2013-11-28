# Programmer:         Ben Porter
# Last Update:        11/27/2013
# Purpose:            To pull driving durations from Bing API
# Notes:              Companion File to "Housing_RunOnce.R"
#                     This file is kicked off by the crontab


#Steps
# 1: Load workspace
# 2: Kickoff function
# 3: Write data to save

# logic for run reverse route after 1:00

setwd("~/R/housing/data/")

#loads the workspace created from the RunOnce file
load("~/R/housing/housing.RData")

library(RCurl) #To get the result of an url
library(rjson) #To read json files

hour <- as.numeric(substr(Sys.time(),12,13))

for (i in 1:n) {
  #UTC time, 6 UTC = 1am EST; 18 UTC = 1pm EST
  if(hour>6 & hour<18) {
    durations$travelDuration[i] <- as.numeric(getData(durations$HomeAddress[i],durations$WayPoint[i],work_addy))
    durations$executionTime[i] <- as.character(Sys.time())
    durations$direction[i] <- "In: Commute into the office"
    print(paste("in",i))
  } else {
    durations$travelDuration[i] <- as.numeric(getData(work_addy,durations$WayPoint[i],durations$HomeAddress[i]))
    durations$executionTime[i] <- as.character(Sys.time())
    durations$direction[i] <- "Out: Commute home"
    print(paste("out",i))
  }
}



timeStamp <-gsub("-","",Sys.time()) #remove dashes
timeStamp <-gsub(":","",timeStamp)  #remove colons
timeStamp <-gsub(" ","",timeStamp)  #remove spaces

fileName <- paste("durations",timeStamp,".csv",sep="")

write.csv(x = durations, file = fileName)

#quit(save = "no", status = 0, runLast = FALSE)
# save: a character string indicating whether the environment (workspace) should be saved
# status:  the (numerical) error status to be returned to the operating system, where relevant. Conventionally 0 indicates successful completion.
# runLast: should .Last() be executed?
