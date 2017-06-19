#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(rpart)
library(party)
library(stats)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Iris Data"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("sepal_length",
                    "Sepal Length:",
                    min = 4.3,
                    max = 7.9,
                    value = 6.0)
      ,
         sliderInput("sepal_width",
                     "Sepal Width:",
                     min = 2.0,
                     max = 4.4,
                     value = 3.0)
      ,
        sliderInput("petal_length",
               "Petal Length:",
               min = 1.0,
               max = 6.9,
               value = 4.0)
      , 
        sliderInput("petal_width",
            "Petal Width:",
            min = 0.1,
            max = 2.5,
            value = 1.0)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         textOutput("prediction")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   fit = rpart(Species~., iris)
   output$prediction <- renderText({
     new_data = data.frame(
       Sepal.Length = input$sepal_length,
       Sepal.Width = input$sepal_width,
       Petal.Length = input$petal_length,
       Petal.Width = input$petal_width
     )
     prediction = predict(fit, new_data, type='class')
     paste("The species is: ", prediction)
   })
   
}

# Run the application 
shinyApp(ui = ui, server = server)

