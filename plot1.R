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

#plot1
png("plot1.png")
hist(datafeb$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency",  
     xlim = c(0, 6), ylim = c(0, 1200), 
     xaxp = c(0, 6, 3), col = "red", breaks = 13)
dev.off()
