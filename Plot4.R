##Plot4
##get data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./dataset.zip", mode = "wb")
unzip(zipfile="./dataset.zip", exdir="./data")

##read the data
electricPowerConsumption <- read.table(./data/household_power_consumption.txt, header = TRUE,
                                       sep=";", stringsAsFactors = FALSE, dec = ".")

##extract data from dates 2007-02-01 and 2007-02-02
subsetDates <- electricPowerConsumption[electricPowerConsumption$Date %in% c("1/2/2007", "2/2/2007") ,]

##create column in table with date and time merged together 
FullTimeDate <- strptime(paste(subsetDates$Date, subsetDates$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
subsetDates <- cbind(subsetDates, FullTimeDate)

## convert the Date and Time variables to Date/Time classes in R using the strptime()as.Date()
## functions
subsetDates$Date <- as.Date(subsetDates$Date, format="%d/%m/%Y")
subsetDates$Time <- format(subsetDates$Time, format="%H:%M:%S")

## set other colums to numeric

subsetDates$Global_active_power <- as.numeric(subsetDates$Global_active_power)
subsetDates$Global_reactive_power <- as.numeric(subsetDates$Global_reactive_power)
subsetDates$Voltage <- as.numeric(subsetDates$Voltage)
subsetDates$Global_intensity <- as.numeric(subsetDates$Global_intensity)
subsetDates$Sub_metering_1 <- as.numeric(subsetDates$Sub_metering_1)
subsetDates$Sub_metering_2 <- as.numeric(subsetDates$Sub_metering_2)
subsetDates$Sub_metering_3 <- as.numeric(subsetDates$Sub_metering_3)

## create png
png("plot4.png", width=480, height=480)

##par(mfrow) to generate two columns, two rows of plots
par(mfrow=c(2,2))

##create plot from plot 2
with(subsetDates, plot(FullTimeDate, Global_active_power, type="l", ylab="Global Active Power (kilowatts)"))

##create plot on top right
with(subsetDates, plot(FullTimeDate, Voltage, type="l", xlab="datetime", ylab="Voltage"))

##create plot on botton left, same as 3
with(subsetdates, plot(FullTimeDate, Sub_metering_1, type="l", xlab="Day", ylab="Energy sub metering"))
lines(subsetdates$FullTimeDate, subsetdates$Sub_metering_2, type="l", col="red")
lines(subsetdates$FullTimeDate, subsetdates$Sub_metering_3, type="l", col="blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2, col=c("black", "red", "blue"), bty="o")

##create plot on bottom right
with(subsetDates, plot(FullTimeDate, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))
dev.off()