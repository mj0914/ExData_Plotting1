library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Extract the indices of the rows with coal in the short.name columns
SCC_Coal <- grep(pattern = "coal", SCC$Short.Name, ignore.case = T)
##Extract the rows based on the indices derived in the previous line
SCC_Coal <- SCC[SCC_Coal, ]
##Get rows from NEI dataset that have the same source ids as found in previous line
NEI_Coal <- subset(NEI, NEI$SCC %in% SCC_Coal$SCC)

## Sum the totl emissions by year
dataPollution <-
  NEI_Coal %>%
  group_by(year) %>%
  select(year, Emissions) %>%
  summarise(
    totalPM25 = sum(Emissions, na.rm = TRUE)
  )

png("plot4.png")

##Plot the graph with ggplot2 system
ggplot(dataPollution, aes(x=year, y=totalPM25)) +
  geom_line() + labs(xlab = "Year", ylab = expression ("Total" ~ PM[2.5] ~"Emissions")) +  
  labs(title=expression("Total" ~ PM[2.5] ~ "Emissions due to Coal in US by Year")) 

dev.off()