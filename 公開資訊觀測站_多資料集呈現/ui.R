
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(utils)
open_data=read.csv("open_stock.csv")
past_data=read.csv("past_data.csv")


shinyUI(pageWithSidebar(
  headerPanel('OPEN STOCK DataTables'),
  sidebarPanel(
    checkboxGroupInput('show_vars', 
                       'Columns in data to show:', 
                       names(open_data),
                       selected = names(open_data)),
    helpText('For the diamonds data, we can select variables
             to show in the table; for the mtcars example, we
             use orderClasses = TRUE so that sorted columns 
             are colored since they have special CSS classes 
             attached; for the iris data, we customize the 
             length menu so we can display 5 rows per page.')
    ),
  mainPanel(
    tabsetPanel(
      tabPanel('open_data',
               dataTableOutput("mytable1")),
      tabPanel('past_data',
               dataTableOutput("mytable2"))
#       tabPanel('iris',
#                dataTableOutput("mytable3"))
    )
  )
    ))