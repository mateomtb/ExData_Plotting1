plot2 <- function (reload) {
  library(sqldf)
  if (reload == TRUE) {
    selector <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
    house <- read.csv.sql('household_power_consumption.txt', sql=selector, sep=";")
    closeAllConnections()
    saveRDS(house, 'household_power_consumption.RDS')
  }
  
  #system.time(house <- readRDS('household_power_consumption.RDS'))
  house <- readRDS('household_power_consumption.RDS')
  house$datetime <- as.POSIXct(strptime(paste(house$Date,house$Time), "%d/%m/%Y %H:%M:%S"))
  head(house)
  # open device
  png(filename='plot2.png',width=480,height=480,units='px')
  
  # plot data
  plot(house$datetime,house$Global_active_power,ylab='Global Active Power (kilowatts)', xlab="", type="l")
  
  # Turn off device
  dev.off()
  
}