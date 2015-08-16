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

#plot3
png("plot3.png")
plot(datafeb$DateTime, datafeb$Sub_metering_1, 
     xlab = "", ylab = "Energy sub metering", 
     type = "l")
points(datafeb$DateTime, datafeb$Sub_metering_2, 
       xlab = "", ylab = "Energy sub metering", 
       type = "l", col = "red")
points(datafeb$DateTime, datafeb$Sub_metering_3, 
       xlab = "", ylab = "Energy sub metering", 
       type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()