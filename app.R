
library(shinydashboard)
library(tidyverse)
library(plotly)
library(ggplot2)
library(shiny)



data_set_cars <- read.csv("Clean_data_pakwheels.csv",sep=",",encoding="UTF-8")


ui <- source("ui.R")
server <- source("server.R")




shinyApp(ui, server)

