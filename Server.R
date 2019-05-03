

library(shiny)

shinyServer(function(input, output){
      
  Model <- lm(overallPoverty_2017 ~ age0_17_2017+age5_17_2017+medHousehldIncome,data=my.data)
  
  Model_predicted <- reactive({
    
    value1 <- input$slide1
    value2 <- input$slide2
    value3 <- input$slide3
    
    predict (Model, newdata = data.frame(age0_17_2017 = value1,
                                         age5_17_2017 = value2,
                                         medHousehldIncome = value3))
  })
  
  poverty_value <- reactive({
    
    value1 <- input$slide1
    value2 <- input$slide2
    value3 <- input$slide3
  })
  
  output$graph_plot<- renderPlot(
    
    ggplot(my.data,aes(x=age0_17_2017+age5_17_2017+medHousehldIncome,y=residualstot))+
      geom_segment(aes(xend=age0_17_2017+age5_17_2017+medHousehldIncome,yend=residualstot),alpha=0.2)+
      geom_hline(yintercept = 0)+
      geom_point(aes(color=residuals017_517))+scale_color_gradient2(low="blue",high="red")+
      guides(color=FALSE)+
      geom_point(aes(x=poverty_value(),y=0),color="Red", size = 5)
  )
  
  output$value_predicted <- renderText(
    
    Model_predicted()
  )
})