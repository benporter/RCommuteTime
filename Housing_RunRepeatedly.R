
#Steps
# 1: Load workspace
# 2: Kickoff function
# 3: Write data to save

# ? logic for run reverse route after 1:00

#setwd("C:/Users/Ben/Documents/R/Housing Analysis")
load("/home/user/housing/housing.RData")

library(RCurl) #To get the result of an url
library(rjson) #To read json files

for (i in 1:n) {
  durations$travelDuration[i] <- as.numeric(getData(durations$HomeAddress[i],durations$WayPoint[i],work_addy))
  durations$executionTime[i] <- as.character(Sys.time())
}


timeStamp <-gsub("-","",Sys.time()) #remove dashes
timeStamp <-gsub(":","",timeStamp)  #remove colons
timeStamp <-gsub(" ","",timeStamp)  #remove spaces

fileName <- paste("durations",timeStamp,".csv",sep="")

write.csv(x = durations, file = fileName)

quit(save = "no", status = 0, runLast = FALSE)
# save: a character string indicating whether the environment (workspace) should be saved
# status:  the (numerical) error status to be returned to the operating system, where relevant. Conventionally 0 indicates successful completion.
# runLast: should .Last() be executed?