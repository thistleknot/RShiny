ui <- fluidPage(
  
  
  titlePanel("BC Liquor Store prices",windowTitle = "title"),
  sidebarLayout(
    #inputs
    sidebarPanel( 
      
      sliderInput("priceInput", "Price", min = 0, max = 100,
                              value = c(25, 40), pre = "$"),
      
      #sliderInput("slider", "Move me", value = 5, 1, 10),
      #numericInput("num", "Number", value = 5, 1, 10),
                  
                  uiOutput("typeOutputs"),
                  uiOutput("subtypeOutputs"),
                  uiOutput("countryOutput")
                  
                  ),
    #outputs
    mainPanel(
      
      
      tabsetPanel(
        tabPanel("Tab 1", 
                 plotOutput("coolplot"),
                 br(), br(),
                 dataTableOutput("results")
                 ),
        tabPanel("Tab 2", "Blank")
      )
      
      
      )
  )
  
  
)
print(ui)