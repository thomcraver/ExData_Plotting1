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

plot(x=data$datetime,y=data$Sub_metering_1, type = "l", xlab = "", ylab="Energy sub metering")

lines(y = data$Sub_metering_2, x=data$datetime, col="red")
lines(y = data$Sub_metering_3, x=data$datetime, col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, width = 480, height = 480, file = "plot3.png")
dev.off()  # If you don't do this, the file doesn't really get written

