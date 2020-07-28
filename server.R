library(shiny)
library(ggplot2)
library(dplyr)

bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)

print(str(bcl))

server <- function(input, output) {
  filtered <- reactive({
    if (is.null(input$countryInput)) {
      return(NULL)
    }    
    
    bcl %>%
      filter(Price >= input$priceInput[1],
             Price <= input$priceInput[2],
             Type == input$typeInput,
             Country == input$countryInput
      )
  })

  output$typeOutputs <- renderUI({
    selectInput("typeInput", "Type",
                sort(unique(bcl$Type)),
                selected = "Wine")
  })
  
  subfiltered <- reactive({
    filter(bcl,Type==input$typeInput)
    
  })
  observe({print(subfiltered)})
  
  output$countryOutput <- renderUI({
    selectInput("countryInput", "Country",
                sort(unique(bcl$Country)),
                selected = "CANADA")
  })
  
  output$results <- renderDataTable({
    filtered()
  })
  
  output$coolplot <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    ggplot(filtered(), aes(Alcohol_Content)) +
      geom_histogram()
  })
  #testing error
  observe({print(input$priceInput)})
  priceDiff <- reactive({diff(input$priceInput)})
  observe({print(priceDiff())})
  observe({print(filtered()$Subtype)})
  }

#shinyApp(ui = ui, server = server)