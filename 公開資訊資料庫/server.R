
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {
  
  # Filter data based on selections
  output$table <- renderTable({
    
    data <- open_stock
    
    if (input$date2 != "All"){
      data <- data[data$date == input$date2,]
    }
    
    if (input$time2 != "All"){
      data <- data[data$time == input$time2,]
    }
    
    if (input$people2 != "All"){
      data <- data[data$people == input$people2,]
    }
    
    data
    
  })
  
})