library(shiny)
library(shinydashboard)
library(ggplot2)
library(ggthemes)
library(tidyverse)
library(maps)
library(dplyr)
library(lubridate)
library(rgdal)
library(usmap)
library(leaflet)
library(magrittr)

MainStates <- map_data("state")
AllCounty <- map_data("county")
df_map_new <-read.csv("df_map_new.csv")
df_countywide <-read.csv("df_countywide.csv")
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

ui <- dashboardPage(
  dashboardHeader(title = "Public Assistance Funded Projects",titleWidth = 220),
  dashboardSidebar(
    selectInput(
      "myyear",
      "choose a year:",
      unique(df_map_new$declarationYear)),
    
    selectInput(
      "mystate",
      "choose a state:",
      c("Whole",unique(df_map_new$state)),
      selected= "Whole"),
    
    radioButtons(
      "mytype",
      "choose a incidentType:",
      c("Hurricane","Coastal Storm")),
    
    helpText("Note: The Public Assistance Funded",
    "Projects Details dataset is",
    "from OpenFEMA website",
    "https://www.fema.gov/openfema-data-page/public-assistance-funded-projects-details-v1")
    ),
  
  dashboardBody(
    fluidRow(
    box(plotOutput("map"),width = 12,solidHeader = T,collapsible = T,title = "Obligated Mapping"),
    box(plotOutput("barplot"),width = 12,solidHeader = T,collapsible = T,title = "Damage Category Count Barplot")
    )
))

server <- function(input, output) {
  output$map <- renderPlot({
    if(input$mystate == "Whole"){
      country_obligate_map(input$myyear,input$mytype)}
    else{
      obligate_map(input$myyear,input$mystate,input$mytype)}
  })
  
  output$barplot <- renderPlot({
    if(input$mystate == "Whole"){
      country_dcc_bar(input$myyear,input$mytype)}
    else{
      dcc_bar(input$myyear,input$mystate,input$mytype)}
  })
}
shinyApp(ui, server)