library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Get the emissions type vehicles
SCC_Vehicle <- grep(pattern = "Vehicle", SCC$EI.Sector, ignore.case = T)
SCC_Vehicle <- SCC[SCC_Vehicle, ]
##Get the records from NEI corresponding to the vehicle emissions
NEI_Vehicle <- subset(NEI, NEI$SCC %in% SCC_Vehicle$SCC)

##Prepare the data for Baltimore
dataPollution <-
  NEI_Vehicle %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  select(year, Emissions) %>%
  summarise(
    totalPM25 = sum(Emissions, na.rm = TRUE)
  )

png("plot5.png")
##Plot the graph using ggplot2
ggplot(dataPollution, aes(x=year, y=totalPM25)) +
  geom_line() + labs(xlab = "Year", ylab = expression ("Total" ~ PM[2.5] ~"Emissions")) +  
  labs(title=expression("Total" ~ PM[2.5] ~ "Vehicles Emissions Baltimore by Year")) 

dev.off()