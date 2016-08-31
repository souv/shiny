# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#fiddler.node.js.HOUSE.guess the code.pm
#http://www.codedata.com.tw/javascript/using-nodejs-to-learn-javascript
# https://blog.allenchou.cc/node-js-web-spider/
#http://ccckmit.github.io/webbook/htm/node.html
#http://www.infoq.com/cn/articles/what-is-nodejs

library(shiny)
source('./TestAndRegression/ReFit.R')
source('./SVM/TestSVM.R')

shinyUI(navbarPage("GOLD and FX",
                   tabPanel("Regression and Test",
                            sidebarLayout(
                              
                              #LEFT SIDE
                              sidebarPanel(
                                selectInput("selectFX", label = h2("Select FX"), 
                                            choices = list("EUR" = 2, "GBP" = 3,
                                                           "USD" = 4)),
                                checkboxGroupInput("Type", label=h2("Targets"),
                                                   choices=list("GOLD"=5,
                                                                "EUR"=2,
                                                                "GBP"=3,
                                                                "USD"=4),
                                                   selected = ""),
                                actionButton("SelectAll", label = "SelectAll"),
                                actionButton("DelAll", label = "DelAll")),
                              
                              #RIGHT SIDE
                              mainPanel(
                                plotOutput("fxToGold"),
                                dataTableOutput("fxTest"),
                                plotOutput("allPrices"),
                                plotOutput("regression"))
                            )
                   ),
                   tabPanel("SVM",
                            mainPanel(
                              dataTableOutput("svmResult")
                            ))
))