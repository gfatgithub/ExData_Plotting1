
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
                                                           "Sub_metering_2", "Sub_metering_3"))
##convert date field
dateFeed$Date <- as.Date(dateFeed$Date, format = "%d/%m/%Y")


## Converting dates
datetime <- paste(as.Date(dateFeed$Date), dateFeed$Time)
dateFeed$Datetime <- as.POSIXct(datetime)

## Plot 2
plot(dateFeed$Global_active_power ~ dateFeed$Datetime, type = "l", xlab = "",
     ylab = "Global Active Power (kilowatts)")

dev.copy(png, file = "plot2.png") ## Copy my plot to a PNG file
dev.off() ## close the PNG device!