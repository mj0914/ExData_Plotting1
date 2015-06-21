library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Prepare the dataset
data <-
  NEI %>%
  group_by(year) %>%
  select(year, Emissions) %>%
  summarise(
    totalPM25 = sum(Emissions, na.rm = TRUE)
  )

png("plot1.png")

##Plot the graph
plot(data$year, data$totalPM25, type="l", 
     xlab = "Year", ylab = expression ("Total" ~ PM[2.5] ~"Emissions"), 
     main = expression("Total" ~ PM[2.5] ~ "Emissions by Year in US"), 
     col = "blue")

dev.off()