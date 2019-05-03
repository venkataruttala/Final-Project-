library(shiny)

shinyUI(fluidPage(
  
     titlePanel("Shiny App"),
     sidebarLayout(
       sidebarPanel(
         
         sliderInput("slide1","move the slider",min = -1832,max = 1554, value = 10,step = 100),
         sliderInput("slide2","Move the slider",min = -1832,max = 1554, value = 10,step = 100),
         sliderInput("slide3","Move the slider",min = -1832,max = 1554, value = 10,step = 100)
       ),
       mainPanel(
         
          plotOutput("graph_plot"),
          h3("Predicted Value:"),
          textOutput("value_predicted")
       )
     )
))