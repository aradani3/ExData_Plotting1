# First download the zip and extract "household_power_consumption.txt"
# file to the working directory
  
  ## Bring datafrom file to hcp data.frame
  library(sqldf) #needed in order to use read.csv.sql
  
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
  
  ## Plot1
  main = "Global Active Power"
  with(hpc,hist(Global_active_power, 
                col = "red", 
                main = main, 
                xlab = paste(main, " (Kilowatts)"),
                )
       )
  
  ## Create PNG
  dev.copy(png, 
           file = "plot1.png", 
           width = 480,
           height = 480
           )
  dev.off()