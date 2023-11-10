
library(shinydashboard)
library(tidyverse)
library(plotly)
library(ggplot2)
library(shiny)
library(dplyr)



data_set_ufo <- read.csv("clean-ufo-sightings-transformed.csv",sep=",",encoding="UTF-8")


ui <- source("ui.R")
server <- source("server.R")




shinyApp(ui, server)

