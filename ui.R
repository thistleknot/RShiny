ui <- fluidPage(
  titlePanel("BC Liquor Store prices",windowTitle = "title"),
  sidebarLayout(
    #inputs
    sidebarPanel( sliderInput("priceInput", "Price", min = 0, max = 100,
                              value = c(25, 40), pre = "$"),
                  radioButtons("typeInput", "Product type",
                               #choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                               choices = c(unique(bcl$Type)),
                               selected = "WINE"),
                  selectInput("countryInput", "Country",
                              choices = c(unique(bcl$Country)))
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