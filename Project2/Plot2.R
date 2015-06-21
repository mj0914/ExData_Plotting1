library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Data Preparation
data <-
  NEI %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  select(year, Emissions) %>%
  summarise(
    totalPM25 = sum(Emissions, na.rm = TRUE)
  )

png("plot2.png")

##Data Plotting
plot(data$year, data$totalPM25, type="l", 
     xlab = "Year", ylab = expression ("Total" ~ PM[2.5] ~"Emissions"), 
     main = expression("Total" ~ PM[2.5] ~ "Emissions by Year in Baltimore"), 
     col = "blue")

dev.off()