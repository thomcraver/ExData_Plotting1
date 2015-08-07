## Get Data from URL
data_url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(data_url,"household_power_consumption.zip", mode="wb")
unzip("household_power_consumption.zip")

## Subset data to requested parameters
alldata<-read.csv("household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)
alldata$Date<- as.Date(alldata$Date, format="%d/%m/%Y")

data<-subset(alldata,alldata$Date=="2007-02-01" | alldata$Date=="2007-02-02")

## Make the data tidy
data$datetime <- paste(data$Date, data$Time)
data$datetime <- strptime(data$datetime, "%Y-%m-%d %H:%M:%S")

data$Global_active_power <- as.numeric(data$Global_active_power)

# Graph code goes here.

par(mfcol=c(2,2), cex=.5)

#topleft
plot(data$datetime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power")

#bottomleft
plot(data$datetime, data$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l")
with(data,{
        lines(datetime,Sub_metering_1,col="black")
        lines(datetime,Sub_metering_2,col="red")
        lines(datetime,Sub_metering_3,col="blue")
})
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("black","red","blue"), bty="n")

#topright
plot(data$datetime, data$Voltage, type="l", ylab="Voltage", xlab="datetime")

#bottomright
plot(data$datetime, data$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")

#copy to png
dev.copy(png, width = 480, height = 480, file = "plot4.png")
dev.off()  # If you don't do this, the file doesn't really get written

