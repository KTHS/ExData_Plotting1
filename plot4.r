library(sqldf)
library(lubridate)

#Uploading data with use of sqldf package
hpc<-read.csv.sql("household_power_consumption.txt",sql="select * from file where Date = '1/2/2007' OR  Date = '2/2/2007'",header=TRUE,sep=";")
head(hpc,10)

#formating table columns
hpc$Date<-as.Date(hpc$Date, "%d/%m/%Y")
hpc$Time<-strptime(hpc$Time,'%H:%M:%S')
hpc$Time<-format(hpc$Time, format="%H:%M:%S")
hpc$Global_active_power<-as.numeric(hpc$Global_active_power)
hpc$Voltage<-as.numeric(hpc$Voltage)
hpc$Sub_metering_1<-as.numeric(hpc$Sub_metering_1)
hpc$Sub_metering_2<-as.numeric(hpc$Sub_metering_2)
hpc$Sub_metering_3<-as.numeric(hpc$Sub_metering_3)

#adding datetime column
hpc<-within(hpc, { timestamp=format(as.POSIXct(paste(Date, Time)), "%Y-%m-%d %H:%M:%S") })
hpc$timestamp<-as.POSIXct(hpc$timestamp)

#plot 4 - screen device
plot.new()
par(mfrow = c(2, 2))
with(hpc, plot(timestamp,Global_active_power,type="l",xlab="",ylab="Global Active Power"))
with(hpc, plot(timestamp,Voltage,type="l",xlab="datetime",ylab="Voltage"))
with(hpc, plot(timestamp,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"), col="black")
with(hpc,lines(timestamp, Sub_metering_2, col = "red"))
with(hpc,lines(timestamp, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), bty = "n",lty=c(1,1,1), col=c("black","red","blue"))
with(hpc, plot(timestamp,Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power"))

# plot 4 - png file
png(file = "plot4.png",width = 480, height = 480) 
par(mfrow = c(2, 2))
with(hpc, plot(timestamp,Global_active_power,type="l",xlab="",ylab="Global Active Power"))
with(hpc, plot(timestamp,Voltage,type="l",xlab="datetime",ylab="Voltage"))
with(hpc, plot(timestamp,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"), col="black")
with(hpc,lines(timestamp, Sub_metering_2, col = "red"))
with(hpc,lines(timestamp, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), bty = "n",lty=c(1,1,1), col=c("black","red","blue"))
with(hpc, plot(timestamp,Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power"))
dev.off()