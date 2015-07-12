#download the file to the working directory
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile="homework1", method="curl")

#unzip downloaded .zip file
unzip("homework1")

#download the zip file, unzip, and copy into working directory
household <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

#create a subset of the data
household_subset <- subset(household, Date == "1/2/2007" | Date == "2/2/2007")

#create new datetime column and format into POSIXct
household_subset$DateTime <- paste(as.Date(household_subset$Date, format = "%d/%m/%Y"), household_subset$Time, sep = " ")
household_subset$DateTime <- as.POSIXct(household_subset$DateTime)

#change power to a numeric
household_subset$Global_active_power <- as.numeric(as.character(household_subset$Global_active_power))

#create fourth plot
png("plot4.png", width = 480, height = 480, units = "px", bg = "white")
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(household_subset, {
  plot(Global_active_power~DateTime, type="l", 
       ylab="Global Active Power", xlab="")
  plot(Voltage~DateTime, type="l", 
       ylab="Voltage (volt)", xlab="datetime")
  plot(Sub_metering_1~DateTime, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~DateTime, type="l", 
       ylab="Global_reactive_power",xlab="datetime")
})
dev.off()