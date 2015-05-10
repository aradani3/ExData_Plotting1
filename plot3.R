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

# Plot3
main = "Energy Sub Metering"
with(hpc,plot (datetime,                # plot datetime in x axis from hpc data.frame
                    Sub_metering_1,     # against Sub_metering_1 in the y axis
                    type = "l",         # plot as a line
                    ylab = main))       # add label to y axis
                    
with(hpc,lines(datetime,                # add line with datetime in x axis from hpc data.frame
                    Sub_metering_2,     # against Sub_metering_2 in the y axis
                    col = "red"))       # colored in red
                    
with(hpc,lines(datetime,                # add line with datetime in x axis from hpc data.frame
                    Sub_metering_3,     # against Sub_metering_3 in the y axis
                    col = "blue"))      # colored in blue
                    
legend("topright",                      # add legend in the top right corner
       col = c("Black","red","blue"),   # lines colours
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), # legend text
       inset = 0.01,                    # inset 1% (puts the legend inside the plot area
       lwd = 1,                         # line width 1
       lty = 1)                         # line type 1

## Create PNG
dev.copy(png, 
         file = "plot3.png", 
         width = 480,
         height = 480
)
dev.off() # don't forget to close the png file
