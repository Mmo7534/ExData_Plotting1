# Script file to output Plot 1 to the active graphic device and save to png.
# Checks for the necessary files, downloads if necessary.
# Creates a tibble called hpdc, converts the date and time columns and NA's
# From the tibble an R object is filtered as per requested date period.
# Mehmet Bora 2020 
# mehmet.bora@outlook.com

plot3 <- function(){
    library(tidyverse)
    
    # Download and extract the data
    if(!file.exists("household_power_consumption.txt")){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                      destfile = "hhpc.zip")
        unzip("hhpc.zip")
    }
    
    # Read and convert bulk data
    if(!exists("filtered")){
    hpcd <- read_delim("household_power_consumption.txt", 
                       ";", escape_double = FALSE, 
                       col_types = cols(Date = col_date(format = "%d/%m/%Y"),
                                        Time = col_time(format = "%H:%M:%S")), 
                       na = "?", trim_ws = TRUE)
    
    # Filter requested dates and clean up environment
    filtered <- filter(hpcd, Date > "2007-01-31" & Date < "2007-02-03" )
    rm("hpcd")
    
    }
    
    # Plot 3
    dev.copy(png,"plot3.png")
    par(mfrow = c(1,1))
    plot(filtered$Sub_metering_1, type = "n", xlab="", ylab = "Energy sub metering", xaxt = "n")
    axis(1, at = seq(0, 2880, by = 1440), 
         labels = c("Thu","Fri","Sat"))
    lines(filtered$Sub_metering_1)
    lines(filtered$Sub_metering_2, col ="Red")
    lines(filtered$Sub_metering_3, col ="Blue")
    legend("topright",lty = "solid", col =c("black","red", "blue"),
           legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
    dev.off()
}