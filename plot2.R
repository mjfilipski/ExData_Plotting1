# Code for making plot 2


# load all relevant packages
library(lubridate)
library(dplyr)




# Download, unzip, and load the data into R: 
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
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


# Make plot 2: 
#-------------------------------------------------------------------
#Need to generate the right date+time variable
hhdata$datetime = ymd_hms(paste(hhdata$Date, hhdata$Time))
with(hhdata, plot(gap ~ datetime,type="l", ylab="Global Active Power (kilowatts)", xlab=""))

# export to png
dev.copy(png, file="Plot2.png",  width = 480, height = 480)
dev.off()

