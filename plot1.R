# Using data.table for faster operations as input file is large, over 100 MB
library(data.table)

file <- "household_power_consumption.txt"

# reading data into eData, suppressing warnings if any
suppressWarnings(eData <- fread(file, header = TRUE, sep = ";", na.strings = "?"))

# convert Date field from character to date
eData$Date<-as.Date(eData$Date,"%d/%m/%Y")

# Subset rows having specified dates
eData <- data.frame(eData[eData$Date >= "2007-02-01" & eData$Date <= "2007-02-02"])

png("plot1.png", bg = "transparent")
# No need to mention width and height because the default values are 480 pixels, 
# units is pixels. Default Background color is white, hence setting it to transparent

Title <- "Global Active Power"
XLabel <- "Global Active Power(kilowatts)"

hist(as.numeric(eData$Global_active_power), xlab=XLabel, col="red", main=Title)

dev.off()