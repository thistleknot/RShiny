library(shiny)

bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)

print(str(bcl))

server <- function(input, output) {}

#shinyApp(ui = ui, server = server)