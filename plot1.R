plot1 <- function (reload) {
  library(sqldf)
  if (reload == TRUE) {
    selector <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
    house <- read.csv.sql('household_power_consumption.txt', sql=selector, sep=";")
    closeAllConnections()
    saveRDS(house, 'household_power_consumption.RDS')
  }
  
  #system.time(house <- readRDS('household_power_consumption.RDS'))
  house <- readRDS('household_power_consumption.RDS')
  
  # open device
  png(filename='plot1.png',width=480,height=480,units='px')
  
  # plot data
  hist(house$Global_active_power,main='Global Active Power',xlab='Global Active Power (kilowatts)',col='red')
  
  # Turn off device
  dev.off()
  
}