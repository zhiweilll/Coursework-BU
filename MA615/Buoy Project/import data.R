#1999
buoy1999=read.csv("data/buoy1999.txt",header=TRUE,sep="")
buoy1999=data.frame(buoy1999)
buoy1999=cbind(buoy1999[,1:4],0,buoy1999[,5:16],0)
colnames(buoy1999)[1]="X.YY"
colnames(buoy1999)[5]="mm"
colnames(buoy1999)[6]="WDIR"
colnames(buoy1999)[13]="PRES"
colnames(buoy1999)[18]="TIDE"


#2000
buoy2000=read.csv("data/buoy2000.txt",header=TRUE,sep="")
buoy2000=data.frame(buoy2000)
buoy2000=cbind(buoy2000[,1:4],0,buoy2000[,5:16],0)
colnames(buoy2000)[1]="X.YY"
colnames(buoy2000)[5]="mm"
colnames(buoy2000)[6]="WDIR"
colnames(buoy2000)[13]="PRES"
colnames(buoy2000)[18]="TIDE"


#2001
buoy2001=read.csv("data/buoy2001.txt",header=TRUE,sep="")
buoy2001=data.frame(buoy2001)
buoy2001=cbind(buoy2001[,1:4],0,buoy2001[,5:17])
colnames(buoy2001)[1]="X.YY"
colnames(buoy2001)[5]="mm"
colnames(buoy2001)[6]="WDIR"
colnames(buoy2001)[13]="PRES"


#import1=function(mydata){
#  url=str_c("data/",mydata,".txt", sep = "")
#  mydata=read.table(url,header=TRUE,sep="",na.strings = c("NA"))
#  mydata=data.frame(mydata)
#  mydata=cbind(mydata[,1:4],0,mydata[,5:16])
#  colnames(mydata)[1]="X.YY"
#  colnames(mydata)[5]="mm"
#  colnames(mydata)[6]="WDIR"
#  colnames(mydata)[13]="PRES"
#  return(mydata)
#}

#2002
buoy2002=read.csv("data/buoy2002.txt",header=TRUE,sep="")
buoy2002=data.frame(buoy2002)
buoy2002=cbind(buoy2002[,1:4],0,buoy2002[,5:17])
colnames(buoy2002)[1]="X.YY"
colnames(buoy2002)[5]="mm"
colnames(buoy2002)[6]="WDIR"
colnames(buoy2002)[13]="PRES"


#2003
buoy2003=read.csv("data/buoy2003.txt",header=TRUE,sep="")
buoy2003=data.frame(buoy2003)
buoy2003=cbind(buoy2003[,1:4],0,buoy2003[,5:17])
colnames(buoy2003)[1]="X.YY"
colnames(buoy2003)[5]="mm"
colnames(buoy2003)[6]="WDIR"
colnames(buoy2003)[13]="PRES"

#2004
buoy2004=read.csv("data/buoy2004.txt",header=TRUE,sep="")
buoy2004=data.frame(buoy2004)
buoy2004=cbind(buoy2004[,1:4],0,buoy2004[,5:17])
colnames(buoy2004)[1]="X.YY"
colnames(buoy2004)[5]="mm"
colnames(buoy2004)[6]="WDIR"
colnames(buoy2004)[13]="PRES"

#2005
buoy2005=read.csv("data/buoy2005.txt",header=TRUE,sep="")
buoy2005=data.frame(buoy2005)
colnames(buoy2005)[1]="X.YY"
colnames(buoy2005)[6]="WDIR"
colnames(buoy2005)[13]="PRES"


#2006
buoy2006=read.csv("data/buoy2006.txt",header=TRUE,sep="")
buoy2006=data.frame(buoy2006)
colnames(buoy2006)[1]="X.YY"
colnames(buoy2006)[6]="WDIR"
colnames(buoy2006)[13]="PRES"

#2007
buoy2007=read.csv("data/buoy2007.txt",header=TRUE,sep="")
buoy2007=data.frame(buoy2007[-1,])

#2008
buoy2008=read.csv("data/buoy2008.txt",header=TRUE,sep="")
buoy2008=data.frame(buoy2008[-1,])

buy#2009
buoy2009=read.csv("data/buoy2009.txt",header=TRUE,sep="")
buoy2009=data.frame(buoy2009[-1,])

#2010
buoy2010=read.csv("data/buoy2010.txt",header=TRUE,sep="")
buoy2010=data.frame(buoy2010[-1,])

#2011
buoy2011=read.csv("data/buoy2011.txt",header=TRUE,sep="")
buoy2011=data.frame(buoy2011[-1,])

#2012
buoy2012=read.csv("data/buoy2012.txt",header=TRUE,sep="")
buoy2012=data.frame(buoy2012[-1,])

#2013
buoy2013=read.csv("data/buoy2013.txt",header=TRUE,sep="")
buoy2013=data.frame(buoy2013[-1,])

#2014
buoy2014=read.csv("data/buoy2014.txt",header=TRUE,sep="")
buoy2014=data.frame(buoy2014[-1,])

#2015
buoy2015=read.csv("data/buoy2015.txt",header=TRUE,sep="")
buoy2015=data.frame(buoy2015[-1,])

#2016
buoy2016=read.csv("data/buoy2016.txt",header=TRUE,sep="")
buoy2016=data.frame(buoy2016[-1,])


#2017
buoy2017=read.csv("data/buoy2017.txt",header=TRUE,sep="")
buoy2017=data.frame(buoy2017[-1,])

#2018
buoy2018=read.csv("data/buoy2018.txt",header=TRUE,sep="")
buoy2018=data.frame(buoy2018[-1,])

#2019
buoy2019=read.csv("data/buoy2019.txt",header=TRUE,sep="")
buoy2019=data.frame(buoy2019[-1,])

#col combine
Buoydata = rbind(buoy1999,buoy2000,buoy2001,buoy2002,buoy2003,buoy2004,buoy2005,buoy2006,buoy2007,buoy2008,buoy2009,buoy2010,buoy2011,buoy2012,buoy2013,buoy2014,buoy2015,buoy2016,buoy2017,buoy2018,buoy2019)
Buoydata = data.frame(sapply(Buoydata, as.numeric))
Buoydata$X.YY[Buoydata$X.YY==99]=1999
#Buoydata[Buoydata == 99 | Buoydata == 999 | Buoydata == 9999] = 0
Buoydata$ATMP[Buoydata$ATMP==99|Buoydata$ATMP==999|Buoydata$ATMP==9999]=0
Buoydata$WTMP[Buoydata$WTMP==99|Buoydata$WTMP==999|Buoydata$WTMP==9999]=0

#export and save
write.csv(Buoydata,"Buoydata.csv",row.names = FALSE)
