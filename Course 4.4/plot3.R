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

# Sum PM2.5 emissions for each year
totalemissions <- dataBaltimore %>% 
  group_by(year,type) %>%
  summarize(sum(Emissions))
colnames(totalemissions) = c("year", "type", "emissions")
format(totalemissions$emissions, scientific = FALSE)

# Plot3 deliverables
png("plot3.png")
ggplot(totalemissions, aes(factor(year), emissions, fill = type)) + 
  geom_col(show.legend = FALSE) +
  facet_grid(. ~ type) +
  labs(x = "Year", 
       y = expression('Total PM'[2.5]*' emission (tons)'), 
       title = expression('Total PM'[2.5]*' emission in Baltimore City by source and year')
  ) +
  ylim(range(pretty(c(0, totalemissions$emissions)))) + 
  theme_bw()
dev.off()

# QUESTION 3
#'Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
#'variable, which of these four sources have seen decreases in emissions from 1999–2008 
#'for Baltimore City? Which have seen increases in emissions from 1999–2008? 
#'Use the ggplot2 plotting system to make a plot answer this question.