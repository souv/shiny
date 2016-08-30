

library(shiny)

#HELLO
# Load the ggplot2 package which provides
# the 'mpg' dataset.
library(ggplot2)

# Define the overall UI
shinyUI(
  fluidPage(
    titlePanel("MPG Filter"),
    
    # Create a new Row in the UI for selectInputs
    fluidRow(
      div(class="span4", 
          selectInput("man", 
                      "Manufacturer:", 
                      c("All", 
                        unique(as.character(mpg$manufacturer))))
      ),
      div(class="span4", 
          selectInput("trans", 
                      "Transmission:", 
                      c("All", 
                        unique(as.character(mpg$trans))))
      ),
      div(class="span4", 
          selectInput("cyl", 
                      "Cylinders:", 
                      c("All", 
                        unique(as.character(mpg$cyl))))
      )        
    ),
    # Create a new row for the table.
    fluidRow(
      tableOutput(outputId="table")
    )    
  )  
)