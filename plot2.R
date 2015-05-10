# First download the zip and extract "household_power_consumption.txt" file to the working directory
  
  ## Bring data from file to hcp data.frame
  library(sqldf) # the sqldf library is needed in order to use read.csv.sql
  
  fileName = "household_power_consumption.txt"
  sql = "select * from file where Date in ('1/2/2007','2/2/2007')"
  hpc <- read.csv.sql(fileName,       # read from the household_power_consumption.txt file
                      sql = sql,      # select only data from the first two days of FEB 2007
                      eol = "\n",     # End of Line
                      header = TRUE,  # Take the heared as Column names
                      sep = ";"       # semicolon separated values
                      )
  
  ## Add datatime column to hpc (as POSIXct)
  hpc$datetime <- paste(hpc$Date,hpc$Time,sep = " ") # concatenate date and time columns into a new column
  hpc$datetime <- as.POSIXct(strptime(hpc$datetime,  # convert to POSIXct class
                                      format = "%d/%m/%Y %H:%M:%S"
                                      )
                             )
  
  
  # Plot2
  main = "Global Active Power"
  with(hpc,plot(datetime,             # plot datetime from hpc data.frame
                Global_active_power,  # against Global_active_power from hpc data.frame
                type = "l",           # plot as line
                ylab = paste(main, " (Kilowatts)") # y axis label
                )
       )
  
  ## Create PNG
  dev.copy(png, 
           file = "plot2.png", 
           width = 480,
           height = 480
  )
  dev.off() # don't forget to close the file
