#Load libraries
library(dplyr)
library(tidyverse)
library(lubridate)

#Download and unzip file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile= "C:/Users/Admin/OneDrive/Bureau/Coursera/Data Science Specialization/Exploratory Data Analysis/Week 1/Swirl and quiz/db.zip")
unzip("db.zip")
db<- read.table("db/household_power_consumption.txt", sep= ";", header = TRUE, na.strings = "?")

#Subset wanted date
db$Date <- as.Date(db$Date, "%d/%m/%Y")
Feb <- subset(db, db$Date == c("2007-02-01","2007-02-02"))

#Merge date and time together
Feb <- Feb %>%
  unite(col = "date/time", c(Date, Time)) 
Feb[,1] <- ymd_hms(Feb[,1]) 

#Create Plot 3
png("plot3.png", width= 480, height= 480, units= "px")
with(Feb, plot(Feb$`date/time`, Feb$Global_intensity, type="n", col="black", xlab= "", ylab= "Energy sub metering"))
with(Feb, lines(Feb$`date/time`, Sub_metering_1, col="black"))
with(Feb, lines(Feb$`date/time`, Sub_metering_2, col="red"))
with(Feb, lines(Feb$`date/time`, Sub_metering_3, col="blue"))
legend("topright", col= c("black", "red", "blue"), legend= c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty= 1)
dev.off()

