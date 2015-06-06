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

##create the plot
plot(dt$Datetime,dt$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(dt$Datetime,dt$Sub_metering_2,col="red")
lines(dt$Datetime,dt$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))

dev.copy(png, file="plot3.png", width=480, height=480)
##shut off the device
dev.off()

cat("plot3.png saved in", getwd())