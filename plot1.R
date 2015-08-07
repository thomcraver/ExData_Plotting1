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

plot(data$datetime,data$Global_active_power,type="1", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, width = 480, height = 480, file = "plot2.png")
dev.off()  # If you don't do this, the file doesn't really get written

