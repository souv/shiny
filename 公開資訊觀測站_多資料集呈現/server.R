
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {
  
  # a large table, reative to input$show_vars
  output$mytable1 = renderDataTable({

    open_data[, input$show_vars, drop = FALSE]
  })
  
  output$mytable2 = renderDataTable({
    
    past_data[, input$show_vars, drop = FALSE]
  })
  
})