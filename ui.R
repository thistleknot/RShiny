ui <- fluidPage(
  titlePanel("BC Liquor Store prices",windowTitle = "title"),
  sidebarLayout(
    sidebarPanel( sliderInput("priceInput", "Price", min = 0, max = 100,
                              value = c(25, 40), pre = "$"),
                  radioButtons("typeInput", "Product type",
                               #choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                               choices = c(unique(bcl$Type)),
                               selected = "WINE")),
    mainPanel("the results will go here")
  )
  
  
)
print(ui)