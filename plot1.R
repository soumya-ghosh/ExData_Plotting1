# 
# data<-read.table("household_power_consumption.txt", sep=";", na.strings="?", header=TRUE)
# 
# data$Date<-as.Date(data$Date,"%d/%m/%Y")
# 
# data <- subset(data, data$Date >= "2007-02-01" & data$Date <= "2007-02-02")


library(data.table)
file <- "household_power_consumption.txt"
suppressWarnings(data <- fread(file, header = TRUE, sep = ";", na.strings = "?"))
data$Date<-as.Date(data$Date,"%d/%m/%Y")

data <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02"]

png("plot1.png")
# No need to mention width and height because the default values are 480 pixels.

Title <- "Global Active Power"
XLabel <- "Global Active Power(kilowatts)"

hist(as.numeric(data$Global_active_power), xlab=XLabel, col="red", main=Title)

dev.off()