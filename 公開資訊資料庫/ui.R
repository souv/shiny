
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(utils)

library(shiny)

open_stock<-read.csv("open_stock.csv", header=T)

shinyUI(fluidPage(

  # Application title
  titlePanel("OPEN STOCK INFORMATION DATABASE"),
  
  fluidRow(
    div(class="span4", 
        selectInput("date2", 
                    "date:", 
                    c("All", 
                      unique(as.character(open_stock$date))))
    ),
    div(class="span4", 
        selectInput("time2", 
                    "time:", 
                    c("All", 
                      unique(as.character(open_stock$time))))
    ),
    div(class="span4", 
        selectInput("people2", 
                    "people:", 
                    c("All", 
                      unique(as.character(open_stock$people))))
    )  
  ),
  
  
  

  fluidRow(
    tableOutput(outputId="table")
    
  )
))
