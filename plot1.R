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

#create first plot
png("plot1.png", width = 480, height = 480, units = "px", bg = "white")
par(mar= c(4, 4, 2, 1))
hist(household_subset$Global_active_power, col = "red", breaks = 12, main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()