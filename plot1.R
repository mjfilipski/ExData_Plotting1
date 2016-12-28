# Code for making plot 1


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


# Make plot 1: 
#-------------------------------------------------------------------
hist(hhdata$gap, col="red", 
      main = "Global Active Power",
      xlab = "Global Active Power (kilowatts)")
dev.copy(png, file="Plot1.png",  width = 480, height = 480)
dev.off()
