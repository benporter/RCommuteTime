# Programmer:         Ben Porter
# Last Update:        11/27/2013
# Purpose:            To set up workspace for pull driving durations from Bing API
# Notes:              Companion File to "Housing_RunRepeatedly.R"
#                     If edits are made in prod, this file needs to be re-ran to get
#                     the image .data file re-written 

###########################################
# Load Libaries
###########################################

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
  WayPoint <- gsub(" ","+",StartLocation)
  end_point <- gsub(" ","+",EndLocation)

  url <- paste("http://dev.virtualearth.net/REST/V1/Routes/Driving?wp.0=",starting_point,
               "&wp.1=",WayPoint,"&wp.2=",end_point,"&optmz=timeWithTraffic",
               "&key=",bingkey ,sep="")
  
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
n <- 7

#durations <- data.frame(HomeAddress = rep("3808 Halcyon Dr, Huntersville, NC 28078",n),
#                    HomeName = rep("Beckett",n ),
#                    WayPoint = c("35.410042,-80.862865","35.443596,-80.880249"),
#                    WayPointName = c("Via Gilead","Via Birkdale"),
#                    travelDuration = rep(0,n ),
#                    executionTime  = rep(" ",n ),
#                    stringsAsFactors=FALSE)

durations <- data.frame(HomeAddress = c(rep("3808 Halcyon Dr, Huntersville, NC 28078",2),
                                        rep("3126 Planters Ridge Rd, Charlotte, NC 28270",3),
                                        "926 Wessington Manor Ln, Fort Mill, SC 29715",
                                        "11414 Talleys Way, Cornelius, NC 28031"),
                        HomeName = c(rep("Beckett",2),
                                     rep("Providence Plantation",3),
                                     "Garrison Mill",
                                     "Antiquity"),
                        WayPoint = c("8872 Gilead Rd, Huntersville, NC 28078",
                                     "8872 Gilead Rd, Huntersville, NC 28078", #change to birkdale 
                                      "near Providence Rd & street & Greylyn Dr, Charlotte, NC 28226",
                                      "near Randolph Rd & Shasta Ln, Charlotte, NC 28211",
                                      "near E WT Harris Blvd & E Independence Blvd, Charlotte, NC 28212",
                                      "near 3307 US-21 S, Fort Mill, SC 29715",
                                      "E Catawba Ave, Cornelius, NC 28031"),
                        WayPointName = c("Via Gilead","Via Birkdale",
                                         "Via Providence","Via Sardis","Via Independence",
                                         "Via I-77",
                                         "Via I-77"),
                        travelDuration = rep(0,7 ),
                        executionTime  = rep(" ",7 ),
                        direction      = rep(" ",7 ),  
                        stringsAsFactors=FALSE)


#durations$WayPoint[1]

work_addy <- "100 N Tryon Charlotte, NC"

#setwd("C:/Users/Ben/Documents/R/Housing Analysis")
save.image(file = "~/R/housing/housing.RData")

