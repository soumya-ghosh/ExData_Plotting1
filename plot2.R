# Using data.table for faster operations as input file is large, over 100 MB
library(data.table)

file <- "household_power_consumption.txt"

# reading data into eData, suppressing warnings if any
suppressWarnings(eData <- fread(file, header = TRUE, sep = ";", na.strings = "?"))

# convert Date field from character to date
eData$Date<-as.Date(eData$Date,"%d/%m/%Y")

# Subset rows having specified dates
eData <- data.frame(eData[eData$Date >= "2007-02-01" & eData$Date <= "2007-02-02"])

# Make a new column Date_time by concatenating Date and Time, parse them into DateTime format using strptime
eData$Date_Time <- strptime(paste(eData$Date, eData$Time), "%Y-%m-%d %H:%M:%S")

png("plot2.png")
# No need to mention width and height because the default values are 480 pixels, 
# units is pixels, background color is white
 
Title <- "Global Active Power"
YLabel <- "Global Active Power (kilowatts)"

plot(eData$Date_Time, as.numeric(eData$Global_active_power),
     xlab="", ylab=YLabel, type = "l")

dev.off()