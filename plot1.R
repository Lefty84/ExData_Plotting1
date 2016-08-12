# This R script creates plot1.png according to specification of JHU Exploratory DA course Project 1

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

# plot the histogram with 12 bins in red color
hist(pwr$Global_active_power,
     breaks = 12,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency"
)
dev.copy(png, file = "plot1.png") # copy the plot to the png file
dev.off() # turn of the device