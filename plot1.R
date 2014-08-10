
# import data
if (!file.exists("household_power_consumption.txt")){
	download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "datafile.zip")
	unzip("datafile.zip")
}

df <- read.table("household_power_consumption.txt", header = TRUE, sep=";", stringsAsFactors = FALSE, skip=66600, nrow= 3000)
colnames(df) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# combine date and time and call it datetime
df$datetime <- strptime(paste(df[,1], df[,2]), "%d/%m/%Y %H:%M:%S")

# convert date into date format
df[,1] <- as.Date(df[,1], "%d/%m/%Y")

# pick Feb 1 and Feb 2
data <- df[(df[,1]=="2007-02-01" | df[,1]=="2007-02-02"),]

# convert data into numerics
for(t in 3:8) {data[,t] <- as.numeric(data[,t])}

# create a graphic devic
png("plot1.png", width = 480, height = 480)

# draw the graph
with(data, hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red"))

dev.off()





