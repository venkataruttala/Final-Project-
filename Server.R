##Question: poverty estimation of US states and the counties in 2017
#basing on ages and medium houshold Income

#Here we estimate poverty rate of people, are divided into  3 groups based on age and their income. people of age between 0 to 17, 5 to 17 and 0 - 4.
#Overall poverty estimation is given based on count of people and in percentages.

#Initially, we had taken the data from data.gov, and extracted data from excel sheet formed a data frame. 
#Here we took 3 independent variables(predictors). developed linear regression model taking POV_0_17 as predictor and POVALL_2017 as dependent variable.y = a+bX.
#Secondly created another model linear regression model with 2 variables taking  POV_0_17 +POV_5_17   predictors estimating overall poverty basing on those two 
#(y=ax1+bx2+c).Finally created another multivariable regression taking predictors as POV_0_17 +POV_5_17+mediumHouseholdIncome) as predictor and taking 
#overall poverty_2017 as independent variable ( lm(pov_all_2017 ~pov_0_17+pov_5_17+mediumHouseholdIncome). Out of all these 3 models
#we considered third model would be best when compared to other two, 
#because in the third model estimation is based on both 2 groups of ages and householdIncome

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