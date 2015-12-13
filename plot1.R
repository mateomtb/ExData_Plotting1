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
  head(house)
  
}