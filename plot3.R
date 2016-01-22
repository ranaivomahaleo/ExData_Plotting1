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

with(subsethousePower, plot(DateTime,Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
with(subsethousePower, lines(DateTime,Sub_metering_1, col="black", pch="."))
with(subsethousePower, lines(DateTime,Sub_metering_2, col="red", pch="."))
with(subsethousePower, lines(DateTime,Sub_metering_3, col="blue", pch="."))

legend("topright", lty=1, cex=0.8, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file="plot3.png")
dev.off()

