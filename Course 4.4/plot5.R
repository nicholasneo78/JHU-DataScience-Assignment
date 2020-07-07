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

# Get the Baltimore City data by subsetting it according to its fips value
dataBaltimore <- filter(dataMerged, fips=="24510")

# Get the emissions from motor vehicle sources by subsetting using grepl
motorVehicleTemp <- grepl("vehicle", dataBaltimore$Short.Name, ignore.case = TRUE)
motorVehicle <- dataBaltimore[motorVehicleTemp, ]

# Sum PM2.5 emissions for each year
totalemissions <- motorVehicle %>% 
  group_by(year) %>%
  summarize(sum(Emissions))
colnames(totalemissions) = c("year", "emissions")
format(totalemissions$emissions, scientific = FALSE)

# Plot5 deliverables
png("plot5.png")
ggplot(totalemissions, aes(factor(year), emissions, fill = year)) + 
  geom_col(show.legend = FALSE) +
  labs(x = "Year", 
       y = expression('Total PM'[2.5]*' emission (tons)'), 
       title = expression('Total PM'[2.5]*' emission from motor vehicles in Baltimore City by year')
  ) +
  ylim(range(pretty(c(0, totalemissions$emissions)))) + 
  theme_bw()
dev.off()

# QUESTION 5
#' How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?