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

hist(myData$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", col="Red", xlim=c(0,6), ylim=c(0,1200))

graphdir=paste0(getwd(), "/plot1.png")

dev.copy(png, file=graphdir, height=480, width=480)
dev.off()
