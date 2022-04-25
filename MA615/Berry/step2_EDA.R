library(ggplot2)
library(dplyr )
library(magrittr)

#### import dataset
berry=read.csv("new_berry.csv")
berry=data.frame(berry)
# organize the Value as numeric, and delete the NA and D 
berry=berry %>% filter(Value != "(NA)") %>% filter(Value != "(D)") 
berry$Value=as.numeric(berry$Value)
summary(berry)



############################ for categorical variable ###################################
## histogram for Commodity, divided by State
ggplot(berry)+geom_histogram(aes(x=Commodity,fill=State),stat = "count")

## histogram for Chemi, divided by Commidty
ggplot(berry)+geom_histogram(aes(x=Chemi_family,fill=Commodity),stat = "count")

## pie for Type, and we can use the same way to plot other pie
T=table(berry$Type)
percentT=prop.table(T)
tbT=cbind(T,percentT)
piepercentT = paste(round(100*tbT[,2],digits = 2), "%")
nameT=c("BEARING","TAME","WILD")
pie(T ,labels=piepercentT ,col=c("purple","green","white"))
legend("topright", nameT,cex=0.8,fill=c("purple","green","white"))





##################################### for Strawberries Value ########################################
### I choose *Strawberries*
sberry=berry%>% filter(Commodity=="STRAWBERRIES")
write.csv(sberry,"sberry.csv")

####################### Overview of Measurement and Value #################
### count of each measurement
mea_sum = sberry %>%
  group_by(Measure)%>%
  summarize(
    Count=n(),
    Mean=round(mean(Value),2)
  )
cat(paste("There are",length(mea_sum$Measure),"types of measurements for strawberry in the dataset."))

### plot for count of each measurement
ggplot(mea_sum,aes(x=Measure,y=Count))+
  geom_bar(stat='identity')+
  ggtitle("Measurements of Strawberry")+
  geom_text(aes(label=Count,y=Count+10),size=3) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
#*Measured in PCT of area bearing* is mostly used for 272 times, and *Measured in $/Ton* is least used for only 7 times in the strawberry dataset.

### boxplot for Value, divided by Measure
ggplot(sberry, aes(x = Measure, y= Value)) +
  geom_boxplot()+
  xlab("Measurement") + 
  ylab("Mean Value of Each Measurement")+
  facet_wrap(~Measure,scales="free")



####################### Value,divided by Measurement ####################
unique(sberry$Measure)
# I choose three different dimensions -- number, price and weight -- to explore the Value

######## 1.Measurement == NUMBER ---- Production Number #########
### count of each measurement
sberry_number = sberry %>% 
  filter(Measure=="NUMBER") %>% 
  group_by(State,Year) %>%
  summarise(Marketing=Marketing,Sum=sum(Value))

## plot for Sum of Value in NUMBER measurement
ggplot(sberry_number)+
  geom_line(aes(x=Year,y=Sum,col=State),alpha=0.3)+
  geom_point(aes(x=Year,y=Sum,col=State))+
  xlab("Year") + 
  ylab("Sum of Value") + 
  ggtitle("Number: Value in NUMBER measurement")

############### 2.Measurement == $ / CWT ---- Price ################
### count of each measurement
sberry_cwt_price = sberry %>% 
  filter(Measure=="$ / CWT") %>% 
  group_by(State,Year) %>%
  summarise(Marketing=Marketing,Mean_price=mean(Value))

## plot for Sum of Value in $ /CWT measurement
ggplot(sberry_cwt_price)+
  geom_line(aes(x=Year,y=Mean_price,col=State),alpha=0.3)+
  geom_point(aes(x=Year,y=Mean_price,col=State,size=Mean_price), alpha=0.5)+
  xlab("Year") + 
  ylab("Mean of Value") + 
  ggtitle("Price: Value in $ / CWT")


############### 3.Measurement == CWT ---- Weight ################
### count of each measurement
sberry_cwt = sberry %>% 
  filter(Measure=="CWT") %>% 
  group_by(State,Year) %>%
  summarise(Marketing=Marketing,Sum=sum(Value))

## plot for Sum of Value in CWT measurement
ggplot(sberry_cwt)+
  geom_point(aes(x=Year,y=Sum,col=State),size=3)+
  geom_line(aes(x=Year,y=Sum,col=State),alpha=0.3)+
  geom_point(aes(x=Year,y=Sum,col=State),size=3)+
  xlab("Year") + 
  ylab("Sum of Value") + 
  ggtitle("Weight: Value in CWT")






####################### Value,divided by Marketing ####################
###### for APPLICATIONS, divided by Measure
sberry1= sberry %>% filter(Marketing=="APPLICATIONS") 
unique(sberry1$Measure)
ggplot(sberry1)+geom_boxplot(aes(x=Chemi_family,y=Value))+facet_wrap(~Measure,scales="free")

sberry1_a =sberry1 %>% filter(Measure=="LB")
summary(sberry1_a$Value)
ggplot(sberry1_a)+geom_boxplot(aes(x=Chemi_family,y=Value))+facet_wrap(~Chemi_family,scales="free")+
  ggtitle("LB")

sberry1_b=sberry1 %>% filter(Measure=="LB / ACRE / APPLICATION")
summary(sberry1_b$Value)
ggplot(sberry1_b)+geom_boxplot(aes(x=Chemi_family,y=Value))+facet_wrap(~Chemi_family,scales="free")+
  ggtitle("LB / ACRE / APPLICATION")

sberry1_c=sberry1 %>% filter(Measure=="LB / ACRE / YEAR")
summary(sberry1_c$Value)
ggplot(sberry1_c)+geom_boxplot(aes(x=Chemi_family,y=Value))+facet_wrap(~Chemi_family,scales="free")+
  ggtitle("LB / ACRE / YEAR")

sberry1_d=sberry1 %>% filter(Measure=="NUMBER")
summary(sberry1_d$Value)
ggplot(sberry1_d)+geom_boxplot(aes(x=Chemi_family,y=Value))+facet_wrap(~Chemi_family,scales="free")+
  ggtitle("For NUMBER")


##### for PROCESSING, divided by Measure
sberry2= sberry %>% filter(Marketing=="PROCESSING") 
unique(sberry2$Measure)
ggplot(sberry2)+geom_boxplot(aes(x=Chemi_family,y=Value))+facet_wrap(~Measure,scales="free")

sberry2_a =sberry2 %>% filter(Measure=="$")
summary(sberry2_a$Value)
ggplot(sberry2_a)+geom_boxplot(aes(x=State,y=Value))+facet_wrap(~State,scales="free")+
  ggtitle("$")

sberry2_b=sberry2 %>% filter(Measure=="$ / CWT")
summary(sberry2_b$Value)
ggplot(sberry2_a)+geom_boxplot(aes(x=State,y=Value))+facet_wrap(~State,scales="free")+
  ggtitle("$ / CWT")


sberry2_c=sberry2 %>% filter(Measure=="$ / TON")
summary(sberry2_c$Value)
ggplot(sberry2_c)+geom_boxplot(aes(x=State,y=Value))+facet_wrap(~State,scales="free")+
  ggtitle("$ / TON")

sberry2_d=sberry2 %>% filter(Measure=="TONS")
summary(sberry2_d$Value)
ggplot(sberry2_d)+geom_boxplot(aes(x=State,y=Value))+facet_wrap(~State,scales="free")+
  ggtitle("TONS")

sberry2_e=sberry2 %>% filter(Measure=="CWT")
summary(sberry2_e$Value)
ggplot(sberry2_e)+geom_boxplot(aes(x=State,y=Value))+facet_wrap(~State,scales="free")+
  ggtitle("CWT")

