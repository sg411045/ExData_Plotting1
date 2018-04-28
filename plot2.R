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
png(filename = "plot2.png", width = 480, height = 480)

# plot
# hist(data$Global_active_power, col="red",main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
plot(Global_active_power ~ dateTime, data, type="l", xlab = "", ylab = "Global Active Power (Kilowatts)")

# close resources
dev.off()