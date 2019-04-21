##Plot2
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
subsetdates2 <- cbind(subsetDates, FullTimeDate)

##set subsetdates2$Global_Active_power to numeric
subsetdates2$Global_active_power <- as.numeric(subsetdates2$Global_active_power)

## create png
png("plot2.png", width=480, height=480)

##create plot
with(subsetdates2, plot(FullTimeDate, Global_active_power, type="l", xlab="Day", ylab="Global Active Power (kilowatts)"))
dev.off()