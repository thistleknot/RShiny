ui <- fluidPage(
  titlePanel("BC Liquor Store prices",windowTitle = "title"),
  sidebarLayout(
    #inputs
    sidebarPanel( 
      
      sliderInput("priceInput", "Price", min = 0, max = 100,
                              value = c(25, 40), pre = "$"),
                  
                  uiOutput("typeOutputs"),
                  uiOutput("subtypeOutputs"),
                  uiOutput("countryOutput")
                  
                  ),
    #outputs
    mainPanel(
      plotOutput("coolplot"),
      br(), br(),
      dataTableOutput("results")
      )
  )
  
  
)
print(ui)