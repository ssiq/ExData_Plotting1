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
png("plot1.png")
hist(as.numeric(data$Global_active_power),xlab="Global Actlve Power (kllowans)",ylab="Frequency",col="red",main="Global Actlve Power")
dev.off()