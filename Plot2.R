library(datasets)
##read and clean the data
rawData <- read.table("household_power_consumption.txt",header = T,sep = ";", na.strings="?")
rawData$Date <- as.Date(rawData$Date, format="%d/%m/%Y")
## Subsets the data 
dt <- subset(rawData, subset = (Date >= "2007-02-01" & Date <= "2007-02-02")) 
rm(rawData) 
dt$Datetime <- as.POSIXct(paste(as.Date(dt$Date), dt$Time)) 

##start the device
png("plot2.png", width = 480, height = 480, units = "px", bg = "white")

##create plot
plot(dt$Datetime, dt$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

##shut the device
dev.off()

cat("plot2.png saved in", getwd())