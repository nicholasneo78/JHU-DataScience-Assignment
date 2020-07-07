# Get Data from the web
UrlFile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "electrical_power_consumption.zip"

if (!file.exists(filename)) {
  download.file(UrlFile, filename, method = "curl")
}

dataset.name <- "electrical_power_consumption"
if (!file.exists(dataset.name)) {
  unzip(filename)
}

# Read data
data <- read.table("household_power_consumption.txt", 
                   header = TRUE, 
                   sep = ";", 
                   stringsAsFactors = FALSE,
                   na.strings = "?") # missing values are coded as ?

# Reformat data to standard time
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- format(strptime(data$Time, "%H:%M:%S"),"%H:%M:%S")
data$datetime <- as.POSIXct(strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S"))

# Subset the required date
data <- subset(data, subset = (Date == "2007-02-01" | Date == "2007-02-02"))

# Plot1 deliverables
png("plot1.png", width=400, height=400)
hist(data$Global_active_power, 
     main = "Global Active Power",
     ylab = "Frequency",
     xlab = "Global Active Power (kilowatts)",
     col = "red")

dev.off()
