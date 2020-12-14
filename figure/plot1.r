#Load libraries

library(dplyr)

#Download file and unzip it
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile= "C:/Users/Admin/OneDrive/Bureau/Coursera/Data Science Specialization/Exploratory Data Analysis/Week 1/Swirl and quiz/db.zip")
unzip("db.zip")
db<- read.table("db/household_power_consumption.txt", sep= ";", header = TRUE, na.strings = "?")

#Subset the wanted dates
head(db)
db$Date <- as.Date(db$Date, "%d/%m/%Y")
Feb <- subset(db, db$Date == c("2007-02-01","2007-02-02"))
Feb$Global_active_power <- as.numeric(Feb$Global_active_power)

#Create plot 1
png("plot1.png", width= 480, height= 480, units= "px")
with(Feb, hist(Global_active_power, col="red", main= "Global Active Power", xlab= "Global Active Power (kilowatts)", ylab= "Frequency"))
dev.off()
