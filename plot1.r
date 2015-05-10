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

# plot 1 - screen device
plot.new()
par(mfrow = c(1, 1))
hist(hpc$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (killowatts)")

# plot 1 - png file
png(file = "plot1.png",width = 480, height = 480) 
hist(hpc$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (killowatts)")
dev.off()

