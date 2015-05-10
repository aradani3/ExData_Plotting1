# First download the zip and extract "household_power_consumption.txt"
# file to the working directory
  
  ## Bring datafrom file to hcp data.frame
  library(sqldf) #needed in order to use read.csv.sql
  
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
  
  ## Plot1
  main = "Global Active Power" # Main title
  with(hpc,hist(Global_active_power, # Histogram of Global_active_power from the hpc data.frame
                col = "red", # coloured in red
                main = main, # add title
                xlab = paste(main, " (Kilowatts)"), # x axis label
                )
       )
  
  ## Create PNG
  dev.copy(png, 
           file = "plot1.png", 
           width = 480,
           height = 480
           )
  dev.off() # don't forget to close the png file
