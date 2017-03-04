library(dplyr)
household<-read.csv("household_power_consumption.txt",sep=";",header = TRUE,na.strings = "?",colClasses = "character" )
household_set<-filter(household,(Date=="1/2/2007")|(Date=="2/2/2007"))
household_set$Global_active_power<-as.numeric(household_set$Global_active_power)

png(filename = "plot1.png",width = 480, height = 480, units = "px",bg = "transparent")
hist(household_set$Global_active_power,main = "Global Active Power",col = "red" ,xlab = "Global Active Power (kilowatts)")
dev.off()