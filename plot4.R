#download file
if (!file.exists("household_power_consumption.txt")) {
        url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(url, destfile = "powerdata.zip")
        unzip("powerdata.zip")}

#read date
dataorignial <- read.table("household_power_consumption.txt", sep=";", header = T, na.string = "?", nrow=100000)
#retrieve data between 1/2/2007 and 2/2/2007
library(dplyr)
datafeb1 <- filter(dataorignial, dataorignial$Date=="1/2/2007")
datafeb2 <- filter(dataorignial, dataorignial$Date=="2/2/2007")
datafeb <- rbind(datafeb1, datafeb2)
# combine date and time
datafeb$DateTime <- strptime(paste(datafeb$Date, datafeb$Time), "%d/%m/%Y %H:%M:%S")

#plot4
png("plot4.png")
par(mfrow = c(2, 2))

# 1
plot(datafeb$DateTime, datafeb$Global_active_power, ylab = "Global Active Power", 
     xlab = "", type = "l")

# 2
plot(datafeb$DateTime, datafeb$Voltage, 
     xlab = "datetime", ylab = "Voltage", 
     type = "l" )

# 3
plot(datafeb$DateTime, datafeb$Sub_metering_1, 
     xlab = "", ylab = "Energy sub metering", 
     type = "l", col = "black")
points(datafeb$DateTime, datafeb$Sub_metering_2, 
       xlab = "", ylab = "Sub_metering_2", 
       type = "l", col = "red")
points(datafeb$DateTime, datafeb$Sub_metering_3, 
       xlab = "", ylab = "Sub_metering_3", 
       type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, bty = "n")

# 4
plot(datafeb$DateTime, datafeb$Global_reactive_power, 
     xlab = "datetime", ylab = "Global_reactive_power", 
     ylim = c(0, 0.5), type = "l")
dev.off()