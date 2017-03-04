library(lubridate)
library(dplyr)
household<-read.csv("household_power_consumption.txt",sep=";",header = TRUE,na.strings = "?",colClasses = "character" )
household_set<-filter(household,(Date=="1/2/2007")|(Date=="2/2/2007"))

household_set$Sub_metering_1<-as.numeric(household_set$Sub_metering_1)
household_set$Sub_metering_2<-as.numeric(household_set$Sub_metering_2)
household_set$Sub_metering_3<-as.numeric(household_set$Sub_metering_3)

household_set<-mutate(household_set,datetime=paste(Date,Time,sep = " "))
household_set$datetime<-dmy_hms(household_set$datetime)
png(filename = "plot3.png",width = 480, height = 480, units = "px",bg = "transparent")

with(household_set,plot(datetime,Sub_metering_1,pch=".",xlab="",ylab = "Energy sub metering",col="black"))
with(household_set,points(datetime,Sub_metering_2,pch=".",col="red"))
with(household_set,points(datetime,Sub_metering_3,pch=".",col="blue"))

lines(household_set$datetime,household_set$Sub_metering_1)
lines(household_set$datetime,household_set$Sub_metering_2)
lines(household_set$datetime,household_set$Sub_metering_2,col="red")
lines(household_set$datetime,household_set$Sub_metering_3,col="blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty = c(1, 1, 1))
dev.off()