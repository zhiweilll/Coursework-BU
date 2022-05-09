library(shiny)
library(ggplot2)

### import data
sberry=read.csv("sberry.csv")
sberry=sberry[,-c(1,2)]

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Strawberry Data Explorary Data Analysis"),

    fluidRow(
      column(4,
             selectInput("State",
                         "State:",
                         c("All",
                           unique(as.character(sberry$State))))
      ),
      column(4,
             selectInput("Year",
                         "Year:",
                         c("All",
                           unique(sberry$Year)))
      )
    ),
    
    DT::dataTableOutput("table"),
    verbatimTextOutput("summary"),
    plotOutput("plot1", click = "plot_click"),
    plotOutput("plot2", click = "plot_click")
 ) 


server <- function(input, output) {
  output$table <- DT::renderDataTable(DT::datatable({
    data <- sberry
    if (input$State != "All") {
      data <- data[data$State == input$State,]
    }
    if (input$Year != "All") {
      data <- data[data$Year == input$Year,]
    }
    data
  }))
  
  output$summary<-renderPrint({
    dataset<-sberry
    summary(dataset)
  })
  
  output$plot1 <- renderPlot({
    p1 <- ggplot(sberry, aes(x=sberry$Value))
    p1 <- p1 + geom_histogram(breaks = seq(0, 50, by = 2))
    p1
  })
  output$plot2 <- renderPlot({
    p2 <- ggplot(sberry, aes(x = Chemi_family, y = Value))
    p2 <- p2 + geom_boxplot() +
      labs(x = "Chemical Family")
    p2
  })
}

shinyApp(ui, server)

#https://wendy-liang.shinyapps.io/Berry_EDA/?_ga=2.179297252.1134128627.1603185041-870852303.1603185041