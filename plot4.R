plot4 <- function() {
    
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
    
    par(mfrow= c(2,2))
    
    with(data2, {
    
    #create histograms
        
        plot(data2$Day, data2$Global_active_power, ylab = "Global Active Power", xlab = NA, type="n")
            lines(data2$Day, data2$Global_active_power, type="l")
        
        plot(data2$Day, data2$Voltage, ylab = "Voltage", xlab = "datetime", type="n")
            lines(data2$Day, data2$Voltage, type="l")
        
        plot(data2$Day, data2$Sub_metering_1, ylab = "Energy sub meeting", xlab = NA, type="n")
            lines(data2$Day, data2$Sub_metering_1, col = "black")
            lines(data2$Day, data2$Sub_metering_2, col = "red")
            lines(data2$Day, data2$Sub_metering_3, col = "blue")
            legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1, cex = 0.3)
        
        plot(data2$Day, data2$Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type="n")
            lines(data2$Day, data2$Global_reactive_power, type="l")
        
    })

    #copy to png and naming plot 4
    dev.copy(png, file="plot4.png", height=480, width=480)
    dev.off()
    
    #close data connection
    close(data)
    
}