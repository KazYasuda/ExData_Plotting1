
# import data
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
png("plot4.png", width = 480, height = 480)

# draw the graph
par(mfrow = c(2,2))
with(data, plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
with(data, plot(datetime, Voltage, type="l"))
with(data, plot(datetime, Sub_metering_1, xlab="", ylab="Energy sub metering", type="l", col="black", ylim=c(-1,39)))
par(new=TRUE)
with(data, plot(datetime, data$Sub_metering_2, xlab="", ylab="Energy sub metering", type="l", col="red", ylim=c(-1,39)))
par(new=TRUE)
with(data, plot(datetime, data$Sub_metering_3, xlab="", ylab="Energy sub metering", type="l", col="blue", ylim=c(-1,39)))
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, border=NULL)
with(data, plot(datetime, Global_reactive_power,type="l"))

dev.off()





