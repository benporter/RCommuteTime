RCommuteTime
============

R Code for Pulling Travel Durations using the Bing Maps API

============

See the chart for the results of this analysis:
https://github.com/benporter/RCommuteTime/blob/master/CharlotteDrivingDurationNov15.png

============

Motivation for this code:
While looking for a new place to live, my wife and I weren't sure what the traffic was like in different parts of Charlotte, NC.  We didn't want to rely on anecdotes from friends, or one off tests commutes.  Instead we wanted actual commute times so we could analyze the data ourselves.  We narrowed down our options to four neighborhoods and used the bing maps API to get the real time driving time on a regular basis.  

The code in the repository is what I ran on AWS EC2 over two months, and costs $1.70 after 2 months of continually runs.  Big thanks to Loius Aslett for creating an AMI file with RStudio Server preinstalled.  http://www.louisaslett.com/RStudio_AMI/

============

File Descriptions:

Housing_RunOnce.R - this file creates the workspace with the initial values, and should be ran first, and only once.

Housing_RunRepeatedly.R - this file should be kicked off by the crontab on the interval you choose. 

crontab.txt - the personalized crontab file I used to set the frequency of datapulls

housing_analysis.R - ran locally rather than on the server like the rest of the files.  it reads in all the driving durations output files, cleans them, performs some computations, and creates a chart.

CharlotteDrivingDurationsNov15.png - the output from housing_analysis.R
