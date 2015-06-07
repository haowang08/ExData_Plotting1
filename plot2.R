plot2 <- function() {
    
    library(sqldf)
    library(lubridate)
    library(dplyr)
    
    #assumes the household_power_consumption.txt file is already downloaded and in the working directory
    
    #scans data using sqldf to minimize data read into R
    filepath <- "./household_power_consumption.txt"
    data <- file(filepath)
    attr(data, "file.format") <- list(sep = ";", header=TRUE)
    data.df <- sqldf("select * from data where Date = '1/2/2007' or Date = '2/2/2007'")
    
    #convert data frame to data table
    data2 <- tbl_df(data.df)
    
    #change Date to dates via lubridate
    data2 <- mutate(data2, Day = dmy(Date) + hms(Time), label=TRUE)
    
    #create histogram
    plot(data2$Day, data2$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = NA, type="n")
    lines(data2$Day, data2$Global_active_power, type="l")
    
    #copy to png and naming plot 2
    dev.copy(png, file="plot2.png", height=480, width=480)
    dev.off()
    
    #close data connection
    close(data)
    
}