# First download the zip and extract "household_power_consumption.txt"
# file to the working directory
  
  ## Bring datafrom file to hcp data.frame
  ## make sure sqldf library is loaded
  
  fileName = "household_power_consumption.txt"
  sql = "select * from file where Date in ('1/2/2007','2/2/2007')"
  hpc <- read.csv.sql(fileName, 
                      sql = sql, 
                      eol = "\n", 
                      header = TRUE, 
                      sep = ";"
  )
  
  ## Add datatime column to hpc (as POSIXct)
  hpc$datetime <- paste(hpc$Date,hpc$Time,sep = " ")
  hpc$datetime <- as.POSIXct(strptime(hpc$datetime, 
                                      format = "%d/%m/%Y %H:%M:%S"
                                      )
                             )
  
  par(mfrow=c(2,2))
  
  # Plot1
  main = "Global Active Power"
  with(hpc,plot(datetime,
                Global_active_power, 
                type = "l", 
                ylab = main))

  # Plot2
  with(hpc,plot(datetime,
                Voltage, 
                type = "l"))

  # Plot3
  main = "Energy Sub Metering"
  with(hpc,plot (datetime,Sub_metering_1,type = "l", ylab = main))
  with(hpc,lines(datetime,Sub_metering_2,col = "red"))
  with(hpc,lines(datetime,Sub_metering_3,col = "blue"))
  legend("topright",
         col = c("Black","red","blue"), 
         legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
         inset = 0.01,
         cex = 0.75,
         lwd = 0.75, lty = 1,
         box.col = "white")
  
  # Plot4
  main = "Global Reactive Power"
  with(hpc,plot(datetime,
                Global_reactive_power, 
                type = "l", 
                ylab = main))
  
  ## Create PNG
  dev.copy(png, 
           file = "plot4.png", 
           width = 480,
           height = 480
  )
  dev.off()