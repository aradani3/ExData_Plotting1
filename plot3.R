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
gc()

## Add datatime column to hpc (as POSIXct)
hpc$datetime <- paste(hpc$Date,hpc$Time,sep = " ")
hpc$datetime <- as.POSIXct(strptime(hpc$datetime, 
                                    format = "%d/%m/%Y %H:%M:%S"
                                    )
                           )


# Plot3
main = "Energy Sub Metering"
with(hpc,plot (datetime,Sub_metering_1,type = "l", ylab = main))
with(hpc,lines(datetime,Sub_metering_2,col = "red"))
with(hpc,lines(datetime,Sub_metering_3,col = "blue"))
legend("topright",
       col = c("Black","red","blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       inset = 0.01,
       lwd = 1, lty = 1)


## Create PNG
dev.copy(png, 
         file = "plot3.png", 
         width = 480,
         height = 480
)
dev.off()