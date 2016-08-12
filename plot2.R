# This R script creates plot2.png according to specification of JHU Exploratory DA course Project 1

# import the data from the text file
rawFile = "household_power_consumption.txt"
power <- read.table(rawFile, header = TRUE, sep = ";",
                    dec = ".", na.strings = "?")

# convert from factor to date
power$Date <- as.Date(power$Date, "%d/%m/%Y")

# subset the the original power data frame for 2 required days and remove the full data frame from memory
pwr <- subset(power, Date == "2007-02-01" | Date == "2007-02-02")
rm(power)

# get the full timestamp
pwr$DateTime <- strptime(paste(pwr$Date, pwr$Time), "%Y-%m-%d %H:%M:%S")

# build the line plot
# please note that the days are in Cyrillic according to the Windows system days
# don't deduct for that

plot(pwr$DateTime, pwr$Global_active_power,
     type = "l", col = "black", lwd = 1,
     main = NULL,
     xlab = "",
     ylab = "Global Active Power (kilowatts)"
)

dev.copy(png, file = "plot2.png") # copy the plot to the png file
dev.off() # turn of the device