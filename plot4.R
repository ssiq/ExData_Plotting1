input_data <- function(){
  data<-read.csv2("household_power_consumption.txt",stringsAsFactors=FALSE)
  data<-data[data$Date=="1/2/2007"|data$Date=="2/2/2007",]
  mask<-which(as.logical(rowSums(data!="?",na.rm=TRUE)))
  data<-data[mask,]
  data<-within(data,(
    time<-strptime(paste(Date,Time,rep=" "),"%d/%m/%Y %T")
  ))
  data
}
data<-input_data()

png("plot4.png")
par(mfrow = c(2, 2))

#region(1,1)
plot(
  data$time,
  as.numeric(data$Global_active_power),
  xlab="",
  ylab="Global Actlve Power",
  main="",
  type="l"
)

#region(1,2)
plot(
  data$time,
  as.numeric(data$Voltage),
  xlab="datatime",
  ylab="Voltage",
  main="",
  type="l"
)

#region(2,1)
with(data,plot(
  rep(time,3),
  c(as.numeric(Sub_metering_1),
    as.numeric(Sub_metering_2),
    as.numeric(Sub_metering_3)),
  type="n",
  main="",
  xlab="",
  ylab="Energy sub metering"
))
with(data,lines(time,as.numeric(Sub_metering_1)))
with(data,lines(time,as.numeric(Sub_metering_2),col="red"))
with(data,lines(time,as.numeric(Sub_metering_3),col="blue"))
legend(
  "topright",
  legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
  lty=rep(1,3),
  col=c("black","red","blue")
)

#region(2,2)
plot(
  data$time,
  as.numeric(data$Global_reactive_power),
  xlab="datatime",
  ylab="Global_reactive_power",
  main="",
  type="l"
)

dev.off()
