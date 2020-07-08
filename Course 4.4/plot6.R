# Get Data from the web
UrlFile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
filename <- "exdata_data_NEI_data.zip"

library(dplyr)
library(ggplot2)

if (!file.exists(filename)) {
  download.file(UrlFile, filename, method = "curl")
}

dataset.name <- "NEI_data"
if (!file.exists(dataset.name)) {
  unzip(filename)
}

# Read the PM2.5 Emissions Data
PM25Data <- readRDS("summarySCC_PM25.rds")
# Read the Source Classification Code Table
SCCData <- readRDS("Source_Classification_Code.rds") 

# Merge datasets based on SCC & retrieve only the relevant columns
dataMerged <- merge(PM25Data, SCCData, by = "SCC")
dataMerged <- subset(dataMerged[ ,1:8])

# Get the Baltimore City & Los Angeles data by subsetting it according to its fips value
dataBCLA <- filter(dataMerged, fips %in% c("24510","06037"))

# Get the emissions from motor vehicle sources by subsetting using grepl
motorVehicleTemp <- grepl("vehicle", dataBCLA$Short.Name, ignore.case = TRUE)
motorVehicle <- dataBCLA[motorVehicleTemp, ]

# Sum PM2.5 emissions for each year
totalemissions <- motorVehicle %>% 
  group_by(fips, year) %>%
  summarize(sum(Emissions))
colnames(totalemissions) = c("location", "year", "emissions")
format(totalemissions$emissions, scientific = FALSE)
totalemissions$location <- gsub("06037", "Los Angeles County", totalemissions$location)
totalemissions$location <- gsub("24510", "Baltimore City", totalemissions$location)

# Plot6 deliverables
png("plot6.png")
ggplot(totalemissions, aes(factor(year), emissions, fill = location)) + 
  geom_col(show.legend = FALSE) +
  facet_grid(. ~ location) +
  labs(x = "Year", 
       y = expression('Total PM'[2.5]*' emission (tons)'), 
       title = expression('Total PM'[2.5]*' emission from motor vehicle sources')
  ) +
  ylim(range(pretty(c(0, totalemissions$emissions)))) + 
  theme_bw()
dev.off()

# QUESTION 6
#'Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los #'Angeles County, 
#'California (fips == "06037"). Which city has seen greater changes 
#'over time in motor vehicle emissions?