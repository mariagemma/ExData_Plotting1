readFile <- function(dir, file) {
  
  pathfile=paste0(dir, file)  
  data = read.table(pathfile, header=TRUE, sep=";", na.strings = "?") 
  datetime <- paste(data$Date, data$Time)
  
  data$Date <- as.Date(data$Date, format="%d/%m/%Y")
  data$DateTime <- strptime(datetime, format="%d/%m/%Y %H:%M:%S")
  
  subdata <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
  na.omit(subdata)
}


#Run

workdir="C:/DataScientistGit/Exploratory data analysis/ProjectWeek1/";
setwd(workdir);
datafile="household_power_consumption.txt";
datadir=paste0(workdir, "data/");

myData = readFile(datadir, datafile)

## Plot 4
#Distribute plots in 2 rows and 2 columns
par(mfrow=c(2, 2), mar=c(4, 4, 2, 1), oma=c(0, 0, 2, 0))

#Multiple plots
with(myData, {
  plot(DateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  plot(DateTime, Voltage, type="l", ylab="Voltage (volt)", xlab="datetime")
  plot(myData$DateTime, myData$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="");
  lines(myData$DateTime, myData$Sub_metering_2,col='red');
  lines(myData$DateTime, myData$Sub_metering_3,col='blue');
  
  # add legend to topright in plot
  legend("topright", adj=c(0,0.1), lty=1, lwd=2, cex=0.4, seg.len=0.3,xjust = 0, yjust = 1, 
         col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(DateTime, Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
})

graphdir=paste0(getwd(), "/plot4.png")

dev.copy(png, file=graphdir, height=480, width=480)
dev.off()
