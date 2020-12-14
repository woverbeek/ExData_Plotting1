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

#Create plot 4
png("plot4.png", width= 480, height= 480, units= "px")
par(mfrow= c(2,2))
with(Feb, plot(Feb$`date/time`, Global_active_power, type="l", col="black", xlab= "", ylab= "Global Active Power"))
with(Feb, plot(Feb$`date/time`, Voltage, type="l", col="black", xlab= "datetime", ylab= "Voltage"))
with(Feb, plot(Feb$`date/time`, Feb$Global_intensity, type="n", col="black", xlab= "", ylab= "Energy sub metering"))
with(Feb, lines(Feb$`date/time`, Sub_metering_1, col="black"))
with(Feb, lines(Feb$`date/time`, Sub_metering_2, col="red"))
with(Feb, lines(Feb$`date/time`, Sub_metering_3, col="blue"))
legend("topright", col= c("black", "red", "blue"), legend= c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty= 1, bty= "n")
with(Feb, plot(Feb$`date/time`, Global_reactive_power, type="l", col="black", xlab= "datetime", ylab= "Global_reactive_power"))
dev.off()

