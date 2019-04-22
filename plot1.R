#DOWNLOADING AND SETTING
if(!file.exists("ElectricData")){dir.create("ElectricData")}
setwd("./ElectricData")
fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,destfile="./electric.zip")
unzip("electric.zip")

#CLEANING
##read and separate into 9 columns
powerc<-read.table("household_power_consumption.txt",header=TRUE, sep=";",
                   stringsAsFactors = FALSE,dec = ".")
##Extracting readings from February 1 to 2, 2007
use_powerc<-subset(powerc,Date=="1/2/2007" | Date=="2/2/2007")
View(use_powerc)
##Changing colclass and merging date and time
use_powerc$Global_active_power<-as.numeric(use_powerc$Global_active_power)
use_powerc$DateTime<-strptime(paste(use_powerc$Date,use_powerc$Time,sep = " "),
                              format = "%d/%m/%Y %H:%M:%S")
use_powerc$Sub_metering_1<-as.numeric(use_powerc$Sub_metering_1)
use_powerc$Sub_metering_2<-as.numeric(use_powerc$Sub_metering_2)
use_powerc$Sub_metering_3<-as.numeric(use_powerc$Sub_metering_3)

#CREATING THE PLOTS
##Plot 1 - Hist of Global Active Power
png("plot1.png",width=480,height=480)
with(use_powerc,hist(Global_active_power,col="red",
                     xlab = "Global Active Power (kilowatts)",ylab="Frequency",
                     main="Global Active Power"))
dev.off()