library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Prepare the data by filtering on Baltimore and grouping the sum of the total emission
##type and year
dataPollution <-
  NEI %>%
  filter(fips == "24510") %>%
  group_by(type, year) %>%
  select(type, year, Emissions) %>%
  summarise(
    totalPM25 = sum(Emissions, na.rm = TRUE)
  )

png("plot3.png")

##Plot the graph with ggplot2 system
ggplot(dataPollution, aes(x=year, y=totalPM25, group = type)) +
  geom_line(color=type) + labs(xlab = "Year", ylab = expression ("Total" ~ PM[2.5] ~"Emissions")) +  
  labs(title=expression("Total" ~ PM[2.5] ~ "Emissions due to Coal in US by Year")) 

dev.off()