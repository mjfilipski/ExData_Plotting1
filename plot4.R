# Code for making plot 3


# load all relevant packages
library(lubridate)
library(dplyr)


# Download, unzip, and load the data into R: 
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("data")) {
  dir.create("data")
}
download.file(fileUrl, destfile = "data/hh_power.zip")
unzip("data/hh_power.zip", exdir = "data")
hhdata_mini <- read.table("data/household_power_consumption.txt", header=TRUE, sep=";", nrows=1000, na.strings ="?")
classes = sapply(hhdata_mini, class)
hhdata_full <- read.table("data/household_power_consumption.txt", 
                          header=TRUE, sep=";", colClasses = classes, na.strings="?")


# subset the relevant dates: 
hhdata_full$Date <- as.Date(strptime(hhdata_full$Date, format ="%d/%m/%Y"))
hhdata <- filter(hhdata_full, Date == "2007-02-01"| Date == "2007-02-02")
table(hhdata$Date)
hhdata <- mutate(hhdata, gap = Global_active_power)
head(hhdata)
rm(hhdata_full) ## remove old data
rm(hhdata_mini) ## remove old data


# Making plot 4: 
#-------------------------------------------------------------------
windows()
par(mfrow= c(2,2))
# fill in four plots one after the other: 
with(hhdata, plot(datetime, gap,type="l", ylab="Global Active Power", xlab=""))
with(hhdata, plot(datetime, Voltage,type="l",  xlab="datetime"))
with(hhdata, {
  plot(datetime, Sub_metering_1, ylab="Energy sub metering", xlab="", type ="n")
  lines(datetime, Sub_metering_1)
  lines(datetime, Sub_metering_2, col = "red")
  lines(datetime, Sub_metering_3, col = "blue")
  legend("topright",  col =c("black","red","blue"), lty=1,
         legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
}) 
with(hhdata, plot(datetime, Global_reactive_power,type="l",  xlab="datetime"))

# export to png
dev.copy(png, file="Plot4.png",  width = 480, height = 480)
dev.off()
