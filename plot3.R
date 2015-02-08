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

png("plot3.png")
# No need to mention width and height because the default values are 480 pixels, 
# units is pixels, background color is white

Title <- "Global Active Power"
YLabel <- "Energy sub metering"

# plotting sub metering 1
plot(eData$Date_Time, as.numeric(eData$Sub_metering_1), col = "black",
     xlab="", ylab=YLabel, type = "l")

# Plotting sub metering 2 and 3 using lines()
lines(eData$Date_Time, as.numeric(eData$Sub_metering_2), col = "red")
lines(eData$Date_Time, as.numeric(eData$Sub_metering_3), col = "blue")

# Adding legend
legend("topright",col=c("black", "red", "blue"), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)

dev.off()