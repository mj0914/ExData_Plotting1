library(datasets)
##read and clean the data
rawData <- read.table("household_power_consumption.txt",header = T,sep = ";", na.strings="?")
rawData$Date <- as.Date(rawData$Date, format="%d/%m/%Y")
## Subsets the data 
dt <- subset(rawData, subset = (Date >= "2007-02-01" & Date <= "2007-02-02")) 
rm(rawData) 
dt$Datetime <- as.POSIXct(paste(as.Date(dt$Date), dt$Time)) 

##create the device
png("plot1.png", width = 480, height = 480, units = "px", bg = "white")

##create plot
hist(dt$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab="Frequency",col = "red", ylim = c(0, 1200), xlim = c(0, 6), xaxp = c(0, 6, 3))

##shut off the device
dev.off()

cat("plot1.png saved in", getwd())