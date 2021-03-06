plot4 <- function (reload) {
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
  png(filename='plot4.png',width=480,height=480,units='px')
  
  #par settings make a 2x2 layout
  par(mfrow=c(2,2))
  
  # plot 1
  plot(house$datetime,house$Global_active_power,ylab='Global Active Power', xlab="", type="l")
  
  # plot 2
  plot(house$datetime,house$Voltage,ylab='Voltage', xlab="datetime", type="l")
  
  # plot 3
  plot(house$datetime,house$Sub_metering_1,ylab='Energy Sub Metering', xlab="", type="l")
  lines(x=house$datetime,y=house$Sub_metering_2, type="l",col="red")
  lines(x=house$datetime,y=house$Sub_metering_3, type="l",col="blue")
  #make a legend
  legend("topright",c("Sub Metering 1","Sub Metering 2", "Sub Metering 3"),bty='n',lwd=c(2.5,2.5,2.5),col=c("black","blue","red"))
  
  # plot 4
  plot(house$datetime,house$Global_reactive_power,ylab='Global_reactive_power', xlab="datetime", type="l")
  
  # Turn off device
  dev.off()
  
}