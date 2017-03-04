library(lubridate)
library(dplyr)
household<-read.csv("household_power_consumption.txt",sep=";",header = TRUE,na.strings = "?",colClasses = "character" )
household_set<-filter(household,(Date=="1/2/2007")|(Date=="2/2/2007"))
household_set<-mutate(household_set,datetime=paste(Date,Time,sep = " "))
household_set$datetime<-dmy_hms(household_set$datetime)

png(filename = "plot4.png",width = 480, height = 480, units = "px",bg = "transparent")
par(mfrow=c(2,2),mar=c(4,4,2,1))
# plot 1
household_set$Global_active_power<-as.numeric(household_set$Global_active_power)
with(household_set,plot(datetime,Global_active_power,pch=".",xlab="",ylab = "Global Active Power"))
lines(household_set$datetime,household_set$Global_active_power)

# plot 2
household_set$Voltage<-as.numeric(household_set$Voltage)
with(household_set,plot(datetime,Voltage,pch=".",ylab = "Voltage"))
lines(household_set$datetime,household_set$Voltage)


# plot 3
household_set$Sub_metering_1<-as.numeric(household_set$Sub_metering_1)
household_set$Sub_metering_2<-as.numeric(household_set$Sub_metering_2)
household_set$Sub_metering_3<-as.numeric(household_set$Sub_metering_3)
with(household_set,plot(datetime,Sub_metering_1,pch=".",ylab = "Energy sub metering",xlab="",col="black"))
with(household_set,points(datetime,Sub_metering_2,pch=".",col="red"))
with(household_set,points(datetime,Sub_metering_3,pch=".",col="blue"))
lines(household_set$datetime,household_set$Sub_metering_1)
lines(household_set$datetime,household_set$Sub_metering_2)
lines(household_set$datetime,household_set$Sub_metering_2,col="red")
lines(household_set$datetime,household_set$Sub_metering_3,col="blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty = c(1, 1, 1),cex = 0.5)

# plot 4
household_set$Global_reactive_power<-as.numeric(household_set$Global_reactive_power)
with(household_set,plot(datetime,Global_reactive_power,pch="."))
lines(household_set$datetime,household_set$Global_reactive_power)

dev.off()