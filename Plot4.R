library(datasets)
##read and clean the data
## Download data files
downloadUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destZipFile <- "exdata-data-household_power_consumption.zip"

if (!file.exists("household_power_consumption.txt")) {
  if(!file.exists(destZipFile)) {
    download.file(downloadUrl, destZipFile)
  }
  ## Unzip the file
  unzip(destZipFile)
}

rawData <- read.table("household_power_consumption.txt",header = T,sep = ";", na.strings="?")
rawData$Date <- as.Date(rawData$Date, format="%d/%m/%Y")
## Subsets the data 
dt <- subset(rawData, subset = (Date >= "2007-02-01" & Date <= "2007-02-02")) 
rm(rawData) 
dt$Datetime <- as.POSIXct(paste(as.Date(dt$Date), dt$Time)) 

##create layout
par(mfrow = c(2, 2))

##top left
plot(dt$Datetime, dt$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

##top right
plot(dt$Datetime, dt$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

##bottom left
plot(dt$Datetime,dt$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(dt$Datetime,dt$Sub_metering_2,col="red")
lines(dt$Datetime,dt$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1),  bty="n", cex=.25)
##bottom right
plot(dt$Datetime, dt$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

##create png
dev.copy(png, file="plot4.png", width=480, height=480)

##shut off the device
dev.off()
cat("plot4.png saved in", getwd())