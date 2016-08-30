# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
source('./TestAndRegression/ReFit.R')
source('./SVM/TestSVM.R')

shinyServer(function(input, output, session) {
  
  #rshiny event handler:use label to control other label
  selAll <- observeEvent(input$SelectAll, {
    updateCheckboxGroupInput(session,"Type", selected=as.character(c(2:5)))
  })
  
  delALL <- observeEvent(input$DelAll, {
    updateCheckboxGroupInput(session,"Type", selected=c(""))
  })  
  
  output$allPrices <- renderPlot({
    
    typeName = c("date", "EUR", "GBP", "USD", "GOLD")
    
    getType = as.numeric(input$Type)
    
    if(length(getType) >=1)
    {
      subPrice = data.frame(price$date, price[,getType])
      names(subPrice) = c("date", typeName[getType])
      
      mdf <- melt(subPrice, id.vars="date", value.name="Price", variable.name="FX")
      
      ggplot(data=mdf, aes(x=date, y=Price, group=FX, colour=FX)) +
        geom_line() +
        geom_point( size=1, shape=1, fill="white" )
    }
  })
  
  output$regression <- renderPlot({
    plot(predict, Xpred%*%Beta, type="l", col="red")
    lines(predict, price$GOLD[predict], col="blue")
  })
  
  output$fxToGold <- renderPlot({
    fxselect = as.numeric(input$selectFX)
    subpriceFX <- data.frame(price$GOLD, price[,fxselect])
    names(subpriceFX) = c("GOLD", "FX")
    lmresult <- with(subpriceFX, lm(GOLD ~ FX))
    plot(GOLD ~ FX, data=subpriceFX, main="",
         xlab="FX",
         ylab="GOLD")
    abline(lmresult, lwd=2)
  })
  
  output$fxTest <- renderDataTable({
    typeName = c("date", "EUR", "GBP", "USD", "GOLD")
    fxselect = as.numeric(input$selectFX)
    subpriceFX <- data.frame(price$GOLD, price[,fxselect])
    names(subpriceFX) = c("GOLD", "FX")
    testResult = summary(lm(GOLD ~ FX, data = subpriceFX ))
    showName = rbind("Intercept", typeName[fxselect])
    data.frame(showName, testResult$coefficients)
  })
  
  output$svmResult <- renderDataTable({
    outTable = data.frame(svm.test)
    names(outTable) = c("pred", "org", "freq")
    outTable
  })
  
})