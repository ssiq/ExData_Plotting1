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

png("plot3.png")

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

dev.off()