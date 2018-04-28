get_base_data <- function() {
  # fetch dataset
  url_to_fetch <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  
  # setup column classes
  colClasses=c(rep("character",2), rep("numeric",7))
  
  # extract and load
  temp <- tempfile()
  download.file(url_to_fetch, temp)
  data <- read.csv(unz(temp, "household_power_consumption.txt"), sep = ";", na.strings = "?",
                   colClasses = colClasses, stringsAsFactors = FALSE)
  
  # combine date and time to form one variable
  data$dateTime <- as.POSIXct(paste(data$Date, data$Time, sep = " "), format="%d/%m/%Y %H:%M:%S")
  
  # transform column classes
  data <- transform(data, Date = as.Date(Date, format="%d/%m/%Y"))
  
  # subset
  data <- subset(data, Date == '2007-02-01' | Date =='2007-02-02')
  
}

# load data
data <- get_base_data()

# setup the device
png(filename = "plot4.png")

# setup the layout
par(mfrow=c(2,2))

# plot1
plot(Global_active_power ~ dateTime, data, type="l", xlab = "", ylab = "Global Active Power (Kilowatts)")

# plot 2
plot(Voltage ~ dateTime, data, type="l", xlab = "datetime", ylab = "Voltage")

# plot 3
plot(Sub_metering_1 ~ dateTime, data, type="l", xlab = "", ylab = "Energy Sub Metering", lty=1)
lines(data$dateTime, data$Sub_metering_2, type = "l", col = "red", lty=1)
lines(data$dateTime, data$Sub_metering_3, type = "l", col = "blue", lty=1)
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red","blue"), lty=1)

# plot 4
plot(Global_reactive_power ~ dateTime, data, type="l", xlab = "datetime", ylab = "Global_reactive_power")

# close resources
dev.off()