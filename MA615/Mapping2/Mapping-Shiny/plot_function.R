###mapping
obligate_map=function(myyear,mystate,mytype){
  
  h=df_map_new%>%filter(declarationYear==myyear,state==mystate,incidentType==mytype)
  s=sum(h$totalObligated)
  my_states <- map_data("state", region =mystate)
  my_counties <- map_data("county", region =mystate)
  
  
  ggplot() + 
    geom_polygon(data=my_counties, 
                 aes(x=long, y=lat, group=group),
                 color="gray", fill="white", size = .1 ) + 
    geom_polygon(data = h, 
                 aes(x = long, y = lat, group = group, fill = `totalObligated`), 
                 color = "lightgrey", size = 0.2, alpha = 1.6,)+
    scale_fill_steps(low="lightblue",high="blue",name='Total Obligated',guide = "coloursteps")+
    geom_polygon(data=my_states, 
                 aes(x=long, y=lat, group=group),
                 color="black", fill="white",  size = .5, alpha = .3)+
    ggtitle(paste(myyear,mystate,mytype,"total obligated: $",s))+
    theme(plot.title=element_text(hjust=0.5),
          panel.background=element_blank(),
          panel.border=element_blank(),
          axis.title=element_blank(),
          axis.text=element_blank(),
          axis.ticks=element_blank())
}




## for whole country
country_obligate_map=function(myyear,mytype){
  
  h=df_map_new%>%filter(declarationYear==myyear,incidentType==mytype)
  s=sum(h$totalObligated)
  ggplot() + 
    geom_polygon(data=AllCounty, 
                 aes(x=long, y=lat, group=group),
                 color="gray", fill="white", size = .1 ) + 
    geom_polygon(data = h, 
                 aes(x = long, y = lat, group = group, fill = `totalObligated`), 
                 color = "lightgrey", size = 0.2, alpha = 1.6,)+
    scale_fill_steps(low="lightblue",high="blue",name='Total Obligated',guide = "coloursteps")+
    geom_polygon(data=MainStates, 
                 aes(x=long, y=lat, group=group),
                 color="black", fill="white",  size = .5, alpha = .3)+
    ggtitle(paste(myyear,mytype,"total obligated: $",s))+
    theme(plot.title=element_text(hjust=0.5),
          panel.background=element_blank(),
          panel.border=element_blank(),
          axis.title=element_blank(),
          axis.text=element_blank(),
          axis.ticks=element_blank())
}


###### barplot
library(ggthemes)
dcc_bar = function(myyear,mystate,mytype){
  hh= df_countywide %>% filter(declarationYear==myyear,state==mystate,incidentType==mytype)%>%
    group_by(disasterNumber)%>%
    summarise(dcc,.groups="drop")%>%
    unique()
  
  ggplot(hh,aes(x=dcc,fill=dcc))+
    geom_bar(stat = "count",width=0.5)+
    geom_text(aes(label=as.character(..count..)),stat="count")+
    theme_solarized()+
    scale_fill_solarized()+
    ggtitle(paste(myyear,mystate,mytype,"damage category count"))
}



country_dcc_bar = function(myyear,mytype){
  hh= df_countywide %>%       filter(declarationYear==myyear,incidentType==mytype)%>%
    group_by(disasterNumber)%>%
    summarise(dcc,.groups="drop")%>%
    unique()
  
  ggplot(hh,aes(x=dcc,fill=dcc))+
    geom_bar(stat = "count",width=0.5)+
    geom_text(aes(label=as.character(..count..)),stat="count")+
    theme_solarized()+
    scale_fill_solarized()+
    ggtitle(paste(myyear,"U.S",mytype,"damage category count"))
}



