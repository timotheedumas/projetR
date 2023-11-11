library(shinydashboard)
library(shiny)




ui <- source("ui.R")
server <- source("server.R")




shinyApp(ui, server)
