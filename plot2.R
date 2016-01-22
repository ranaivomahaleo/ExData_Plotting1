library(data.table)

housePower <- fread("household_power_consumption.txt", na.strings="?")

#
# 1. Convert Date columns to date
# 2. Filter Date
# 3. Merge Date and Time, convert to DateTime format and create DateTime column
housePower$Date <- as.Date(housePower$Date , "%d/%m/%Y")
subsethousePower <- subset(housePower, Date==as.Date("2007-02-01") | Date==as.Date("2007-02-02"))
subsethousePower$DateTime <- as.POSIXct(paste(subsethousePower$Date, subsethousePower$Time), format="%Y-%m-%d %H:%M:%S")

print(head(subsethousePower))

if (dev.cur()!=0) {
  dev.off() # To return back to screen graphic device if necessary
}

with(subsethousePower, plot(DateTime, Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", pch="."))
lines(subsethousePower$DateTime, subsethousePower$Global_active_power)

dev.copy(png, file="plot2.png")
dev.off()

