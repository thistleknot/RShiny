library(shiny)
library(ggplot2)
library(dplyr)

bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)

print(str(bcl))

server <- function(input, output) {
  filtered <- reactive({
    bcl %>%
      filter(Price >= input$priceInput[1],
             Price <= input$priceInput[2],
             Type == input$typeInput,
             Country == input$countryInput
      )
  })
  
  output$results <- renderDataTable({
    filtered()
  })
  
  output$coolplot <- renderPlot({
    ggplot(filtered(), aes(Alcohol_Content)) +
      geom_histogram()
    
  })
  #testing error
  observe({print(input$priceInput)})
  priceDiff <- reactive({diff(input$priceInput)})
  observe({print(priceDiff())})
  }

#shinyApp(ui = ui, server = server)