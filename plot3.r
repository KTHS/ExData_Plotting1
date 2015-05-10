library(sqldf)
library(lubridate)

#Uploading data with use of sqldf package
hpc<-read.csv.sql("household_power_consumption.txt",sql="select * from file where Date = '1/2/2007' OR  Date = '2/2/2007'",header=TRUE,sep=";",nrow=1000)
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

#plot 3 - screen device
plot.new()
par(mfrow = c(1, 1))
with(hpc, plot(timestamp,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"), col="black")
with(hpc,lines(timestamp, Sub_metering_2, col = "red"))
with(hpc,lines(timestamp, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c("black","red","blue"))

# plot 3 - png file
png(file = "plot3.png",width = 480, height = 480) 
with(hpc, plot(timestamp,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"), col="black")
with(hpc,lines(timestamp, Sub_metering_2, col = "red"))
with(hpc,lines(timestamp, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c("black","red","blue"))
dev.off()