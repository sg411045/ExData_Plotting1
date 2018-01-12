get_base_data <- function() {
    # fetch dataset
    url_to_fetch <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    
    # extract and load
    temp <- tempfile()
    download.file(url_to_fetch, temp)
    data <- read.csv(unz(temp, "household_power_consumption.txt"), sep = ";")
    
    # transform column classes
    data <- transform(data, Global_active_power = as.numeric(Global_active_power), Date = as.Date(Date))

    # subset
    data <- subset(d3, Date == '2007-02-01' | Date =='2007-02-02')
}

# load data
data <- get_base_data()

# setup the device
png(filename = "plot1.png", width = 480, height = 480)

# plot
hist(data$Global_active_power, col="red",main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# close resources
dev.off()