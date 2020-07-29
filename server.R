library(shiny)
library(ggplot2)
library(dplyr)
library(shinyWidgets)

bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)

print(str(bcl))

server <- function(input, output, session) {
  
  #observe({updateNumericInput(session, "num", value = input$slider)})
  
  observe({
    print(input$countryInput)
  })
  
  filtered <- reactive({
    if (is.null(input$countryInput) || is.null(input$typeInput) || is.null(input$subtypeInput)) {
      return(NULL)
    }    
    
    bcl %>%
      filter(Price >= input$priceInput[1],
             Price <= input$priceInput[2],
             Type %in% c(input$typeInput),
             Subtype %in% c(input$subtypeInput),
             Country %in% c(input$countryInput)
      )
  })

  typeFiltered <- sort(unique(bcl$Type))
  
  output$typeOutputs <- renderUI({
    pickerInput("typeInput", "Type",
                typeFiltered,
                #options = list(`actions-box` = TRUE),
                options = pickerOptions(
                  actionsBox = TRUE),
                selected = NULL,
                multiple=TRUE)
  })
  
  subfiltered <- reactive({
    if (is.null(input$typeInput)) {
      return(NULL)
    }    
    
    unique(filter(bcl,Type==input$typeInput)$Subtype)
  })
  
  countryFiltered  <- sort(unique(bcl$Country))
  names(countryFiltered) = sort(unique(bcl$Country))
  print(names(countryFiltered))
  
  #observe({print(countryFiltered())})
  
  output$subtypeOutputs <- renderUI({
    pickerInput("subtypeInput", "Subtype",
                subfiltered(),
                options = pickerOptions(
                  actionsBox = TRUE),
                selected = NULL,
                multiple=TRUE)
    
  })
  #observe({print(subfiltered)})
  
  output$countryOutput <- renderUI({
    pickerInput("countryInput", "Country",
                countryFiltered,
                options = pickerOptions(
                  actionsBox = TRUE),
                selected=NULL,
                #selected = countryFiltered[1], 
                #selected = countryFiltered[10],
                #selected = countryFiltered["Canada"],
                #selected = "Canada",
                multiple=TRUE
                )
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