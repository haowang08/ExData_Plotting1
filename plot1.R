plot1 <- function() {

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
    data2 <- mutate(data2, Date = dmy(Date))
    head(data2)
    
    #create histogram
    hist(data2$Global_active_power, xlab = "Global Active Power(kilowatts)", ylim = c(0, 1200), col = "red", main="Global Active Power")
    
    #copy to png and naming plot 1
    dev.copy(png, file="plot1.png", height=480, width=480)
    dev.off()
    
    #close data connection
    close(data)
    
}