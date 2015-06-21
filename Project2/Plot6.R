library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Get the emissions type vehicles
SCC_Vehicle <- grep(pattern = "vehicle", SCC$EI.Sector, ignore.case = T)
SCC_Vehicle <- SCC[SCC_Vehicle, ]
NEI<-transform(NEI,type=factor(type),year=factor(year))
##Get the records from NEI corresponding to the vehicle emissions
NEI_Vehicle <- subset(NEI, NEI$SCC %in% SCC_Vehicle$SCC & fips %in% c("24510", "06037"))

##Prepare the data for Baltimore and LA
dataPollution <-
  NEI_Vehicle %>%
  mutate(city= ifelse(fips=="24510", "Baltimore", "Los Angeles")) %>%
  group_by(city,year) %>%
  select(city, year, Emissions) %>%
  summarise(
    totalPM25 = sum(Emissions, na.rm = TRUE)
  )

png("plot6.png")
##Plot the graph using ggplot2 system
ggplot(dataPollution, aes(x=year, y=totalPM25, group=city)) +
  geom_line() + 
  facet_grid(.~city) + 
  labs(xlab = "Year", ylab = expression ("Total" ~ PM[2.5] ~"Emissions")) +  
  labs(title=expression("Total" ~ PM[2.5] ~ "Vehicles Emissions in LA and Baltimore by Year")) 

dev.off()