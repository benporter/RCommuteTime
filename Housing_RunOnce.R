# Programmer:         Ben Porter
# Last Update:        9/18/2013
# Purpose:            Topic Modeling
# Acknowledgements:   

###########################################
# Load Libaries
###########################################

#HAVING PROBLEMS HERE
#install.packages("RCurl",repos='http://cran.us.r-project.org',lib="/home/user/R/i686-pc-linux-gnu-library/3.0/rjson/libs")
#install.packages("rjson",repos='http://cran.us.r-project.org')

library(RCurl) #To get the result of an url
library(rjson) #To read json files

###############################################################################
# Microsoft Bing Maps API
###############################################################################

getData <- function(StartLocation,WayPoint,EndLocation) {
  
  bingkey <- "AowkQT_NrDaYfFF2OQEepSWQkk9kHy3YmLixkYpYtHW25aDU9KWxp5SoC9PN248D"
  starting_point <- gsub(" ","+",StartLocation)
  end_point <- gsub(" ","+",EndLocation)

  url <- paste("http://dev.virtualearth.net/REST/V1/Routes/Driving?wp.0=",starting_point,
                 "&wp.1=",WayPoint,"&wp.2=",end_point,"&key=",bingkey ,sep="")
  
  suppressWarnings(json_bing <- fromJSON(paste(readLines(url), collapse="")))

  travelDuration <- json_bing$resourceSets[[1]]$resources[[1]]$travelDuration
  
  results <- list(travelDuration=travelDuration)
  return(results)
}
 
#things to do next for Contour Map
# 1) go through all lat and long coords to see if it double backs on itself
# 2) hard code the work location and what it is resolved to
# 3) get syntax for saving and loading a workspace
# 4) put all 900 locations in the workspace


#number of routes
n <- 2

durations <- data.frame(HomeAddress = rep("3808 Halcyon Dr, Huntersville, NC 28078",n),
                    HomeName = rep("Beckett",n ),
                    WayPoint = c("35.410042,-80.862865","35.443596,-80.880249"),
                    WayPointName = c("Via Gilead","Via Birkdale"),
                    travelDuration = rep(0,n ),
                    executionTime  = rep(" ",n ),
                    stringsAsFactors=FALSE)

#durations$WayPoint[1]

work_addy <- "100 N Tryon Charlotte, NC"


#setwd("C:/Users/Ben/Documents/R/Housing Analysis")
save.image(file = "/home/user/housing/housing.RData")





