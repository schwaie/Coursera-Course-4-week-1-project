##Plot 1
##get data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./dataset.zip", mode = "wb")
unzip(zipfile="./dataset.zip", exdir="./data")

##read the data
electricPowerConsumption <- read.table(./data/household_power_consumption.txt, header = TRUE,
                                       sep=";", stringsAsFactors = FALSE, dec = ".")

##extract data from dates 2007-02-01 and 2007-02-02
subsetDates <- electricPowerConsumption[electricPowerConsumption$Date %in% c("1/2/2007", "2/2/2007") ,]

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
png("plot1.png", width=480, height=480)

## make histogram for plot 1
hist(subsetDates$Global_active_power, col="red", border="black", 
     main ="Global Active Power", xlab="Global Active Power (kilowatts)", 
     ylab="Frequency")