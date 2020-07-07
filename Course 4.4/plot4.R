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

# Get the coal combustion-related sources by subsetting using grepl
dataMergedCoalTemp <- grepl("coal", dataMerged$Short.Name, ignore.case = TRUE)
dataMergedCoal <- dataMerged[dataMergedCoalTemp, ]

# Sum PM2.5 emissions for each year
totalemissions <- dataMergedCoal %>% 
  group_by(year) %>%
  summarize(sum(Emissions))
colnames(totalemissions) = c("year", "emissions")
format(totalemissions$emissions, scientific = FALSE)

# Plot4 deliverables
png("plot4.png")
ggplot(totalemissions, aes(factor(year), emissions, fill = year)) + 
  geom_col(show.legend = FALSE) +
  labs(x = "Year", 
       y = expression('Total PM'[2.5]*' emission (tons)'), 
       title = expression('Total PM'[2.5]*' emission from coal combustion-related sources by year')
  ) +
  ylim(range(pretty(c(0, totalemissions$emissions)))) + 
  theme_bw()
dev.off()

# QUESTION 4
#'Across the United States, how have emissions from 
#'coal combustion-related sources changed from 1999–2008?