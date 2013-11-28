# Programmer:         Ben Porter
# Last Update:        11/27/2013
# Purpose:            Analyze data from API calls
# Notes:              Reads in all .csv files and creates charts

library(ggplot2)

setwd("/home/user/housing/datapulls/good")

allCSV <- list.files(pattern="*.csv")
print(paste("number of files: ",length(allCSV),sep=""))

readAppend <- function(df,primaryDF) {
    
  currentDF <- read.csv(file=df,head=TRUE,sep=",")
  
  colNames <- names(currentDF)
  colCount <- length(colNames)
  if("direction" %in% colNames) {
    #direction included the latest
    if(colCount==8){
      if(nrow(currentDF) > 0 ) {
        primaryDF <- rbind(currentDF,primaryDF)
    
      }
    }
  }
  
  return(primaryDF)
  
}

lastrec <- length(allCSV)

#initialize base dataframe
durationsDF <- read.csv(file=allCSV[lastrec],head=TRUE,sep=",")

for (i in 1:(lastrec-1)) {
  durationsDF <- readAppend(df=allCSV[i] , primaryDF=durationsDF)
  #namesList[[i]] <- readAppend(df=allCSV[i] , primaryDF=durationsDF)
}


nrow(durationsDF)

durationsDF$HourMin <- format(strptime(durationsDF$executionTime, "%Y-%m-%d %H:%M:%OS"),"%H:%M")
durationsDF$DayOfWeek <- weekdays(strptime(durationsDF$executionTime, "%Y-%m-%d %H:%M:%OS"))
durationsDF$Weekend <- as.factor(ifelse(durationsDF$DayOfWeek=="Saturday" | durationsDF$DayOfWeek=="Sunday",1,0))
durationsDF$DurationMin <- durationsDF$travelDuration / 60
durationsDF <- subset(durationsDF,DurationMin < 200)

t <- table(durationsDF$HourMin)
t <- rbind(t,1:dim(t))


######## Limit to just weekdays
durationsDF_subset <- subset(durationsDF,Weekend==0)

# Combined Plot
g <- ggplot(data=durationsDF_subset, aes(x=HourMin,y=DurationMin,color=HomeName,group=HomeName))
g <- g + geom_smooth()
g <- g + stat_summary(fun.y="mean",geom="line")
g

# Faceted Plot
g <- ggplot(data=durationsDF, aes(x=HourMin,y=DurationMin,color=Weekend)) 
#g <- g + geom_line()
g <- g + geom_point()
#g <- g + geom_vline(xintercept = "09:00")
g <- g + facet_wrap( ~ HomeName, ncol=2)
g <- g + theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank())
g <- g + geom_vline(aes(xintercept = 20)) #9 am
g <- g + geom_vline(aes(xintercept = 37)) #5 am
g


write.csv(durationsDF, file = "CombinedDurationsGood.csv")

