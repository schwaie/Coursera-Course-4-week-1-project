##Plot3
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
subsetdates <- cbind(subsetDates, FullTimeDate)

#set submetering columns to numeric 
subsetdates$Sub_metering_1 <- as.numeric(subsetdates$Sub_metering_1)
subsetdates$Sub_metering_2 <- as.numeric(subsetdates$Sub_metering_2)
subsetdates$Sub_metering_3 <- as.numeric(subsetdates$Sub_metering_3)

## create png
png("plot3.png", width=480, height=480)

##create plot
with(subsetdates, plot(FullTimeDate, Sub_metering_1, type="l", xlab="Day", ylab="Energy sub metering"))
lines(subsetdates$FullTimeDate, subsetdates$Sub_metering_2, type="l", col="red")
lines(subsetdates$FullTimeDate, subsetdates$Sub_metering_3, type="l", col="blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2, col=c("black", "red", "blue"))
dev.off()