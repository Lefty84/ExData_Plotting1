# This R script creates plot4.png according to specification of JHU Exploratory DA course Project 1

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

# create a 2 by 2 plot frame
par(mfrow = c(2, 2))

with(pwr, {
  # plot 1,1
  plot(DateTime, Global_active_power,
       type = "l", col = "black", lwd = 1,
       main = NULL,
       xlab = "",
       ylab = "Global Active Power (kilowatts)",
       cex.lab=0.5,
       cex.axis=0.5
  )
  # plot 1,2
  plot(DateTime, Voltage, type='l', col="black", lwd=1,
       main = NULL,
       xlab="datetime",
       ylab="Voltage",
       cex.lab=0.5,
       cex.axis=0.5)
  
  # plot 2,1
  plot(DateTime, Sub_metering_1, type='l', col="black", lwd=1,
       main = NULL,
       xlab="",
       ylab="Energy sub metering",
       cex.lab=0.5,
       cex.axis=0.5)
  
  
  lines(DateTime, Sub_metering_2, type='l', col="red", lwd=1)
  lines(DateTime, Sub_metering_3, type='l', col="blue", lwd=1)
  
  legend('topright', # location of the legend
         names(pwr)[c(7,8,9)], # captions, could've also used c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
         lty=1, col=c("black", "red", "blue"), # size and colors of the legend lines
         bty='n', cex=0.3, # note that here the style of the legend is different than in plot3
         y.intersp=0.3
         )
  
  # plot 2,2
  plot(DateTime, Global_reactive_power, type='l', col="black", lwd=1,
       main = NULL,
       xlab="datetime",
       cex.lab=0.5,
       cex.axis=0.5
  )
  
})

dev.copy(png, file = "plot4.png")
dev.off()