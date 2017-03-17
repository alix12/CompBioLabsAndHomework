## LAB 09: Novel problem solving

### Set working directory
setwd("~/Comp Bio/CompBioLabsAndHomework/Lab09")

##1. Pull info from Sam's git onto your local computer so you have necessary files.


##2. load the data into R
camera_data <- read.csv("Cusack_et_al/Cusack_et_al_random_versus_trail_camera_trap_data_Ruaha_2013_14.csv")

## look at the data in the global environment and in general

head(camera_data)


###3. Parse the time in the data set so that the data in that column can be used to
### calculate time intervals between observations.

## first, pull the DateTime into its own vector.
DateTime <- camera_data$DateTime
head(DateTime)

## find a function that will recognize the characters as date characters
?as.Date()
?strptime
?POSIXct

## recognize that the vector date time is a string of 
## factors, and strptime needs them to be characters
camera_data$DateTime <- strptime(as.character(DateTime), format = "%d/%m/%Y %H:%M")
abs(camera_data$DateTime[3] - camera_data$DateTime[4])



###4. make a function called calcTimeDiff that takes two times as the argument and
### calculates the difference bewtween them

calcTimeDiff <- function(Time1, Time2) {
  abs(Time1 - Time2)
}
## does it work?? 
calcTimeDiff(camera_data$DateTime[18], camera_data$DateTime[75])

###5. make a new function that takes four arguments:
### (i) the data (all the camera trap data), (ii) Placement, (iii) Season, and
### (iv) Station
### and outputs a vector of time intervals betweeen consecutive camera trappings.










