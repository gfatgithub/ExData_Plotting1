
##Create data folder
if(!file.exists("./data")){dir.create("./data")}

##zip url
zipURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destFile ="./data/Dataset.zip"
download.file(zipURL,destFile)

##Unzip the data file
unzip(destFile,exdir="./data")

##source file
dataSource<-"./data/household_power_consumption.txt"
rm(dateFeed)
dateFeed <- read.table(text = grep("^[1,2]/2/2007", readLines(dataSource), value = TRUE), header=TRUE, 
                     sep=";" ,na.strings="?",col.names = c("Date", "Time", "Global_active_power", 
                                                           "Global_reactive_power", "Voltage","Global_intensity", "Sub_metering_1",
                                                           "Sub_metering_2", "Sub_metering_3")
                     , nrows = 2075259, check.names = F, 
                     stringsAsFactors = F, comment.char = "", quote = '\"')
##convert date field
dateFeed$Date <- as.Date(dateFeed$Date, format = "%d/%m/%Y")


## Converting dates
datetime <- paste(as.Date(dateFeed$Date), dateFeed$Time)
dateFeed$Datetime <- as.POSIXct(datetime)

## Plot 3
with(dateFeed, {
  plot(Sub_metering_1 ~ Datetime, type = "l", 
       ylab = "Energy sub metering", xlab = "")
  lines(Sub_metering_2 ~ Datetime, col = 'Red')
  lines(Sub_metering_3 ~ Datetime, col = 'Blue')
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


dev.copy(png, file = "plot3.png") ## Copy my plot to a PNG file
dev.off() ## close the PNG device!