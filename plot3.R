# This R script creates plot3.png according to specification of JHU Exploratory DA course Project 1

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

# at first let's make initial plot and then add additional lines
plot(pwr$DateTime, pwr$Sub_metering_1, type='l', col="black", lwd=1,
     main = NULL,
     xlab="",
     ylab="Energy sub metering")

# add lines
lines(pwr$DateTime, pwr$Sub_metering_2, type='l', col="red", lwd=1)
lines(pwr$DateTime, pwr$Sub_metering_3, type='l', col="blue", lwd=1)

# add legend
legend('topright', # location of the legend
       names(pwr)[c(7,8,9)], # captions, could've also used c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       lty=1, col=c("black", "red", "blue"), # size and colors of the legend lines
       bty='o', cex=0.75 # type of the legend box and font size
)

dev.copy(png, file = "plot3.png")
dev.off()