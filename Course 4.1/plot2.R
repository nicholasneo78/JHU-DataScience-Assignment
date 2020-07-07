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

# Subset the required date
# Date format is referenced from the dataset
data <- subset(data, subset = (Date == "1/2/2007" | Date == "2/2/2007"))

# Reformat data to standard time
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- format(strptime(data$Time, "%H:%M:%S"),"%H:%M:%S")
data$datetime <- as.POSIXct(strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S"))

# final check on the subsetted data
head(data,10)

# Plot2 deliverables
png("plot2.png", width=480, height=480)
plot(data$Global_active_power ~ data$datetime,
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")
dev.off()
