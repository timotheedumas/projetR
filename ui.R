library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)
library(ggplot2)
library(dplyr)
library(leaflet)
library(rjson)
library(sf)


data_set_cars <- read.csv("Clean_data_pakwheels.csv",sep=",",encoding="UTF-8")

ui <- fluidPage(
  
  # App title ----
  titlePanel(h1("Vente de voiture", align = "center")),
  
  titlePanel("CSV Data Viewer"),
  tableOutput("table"),
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
      sidebarPanel("sidebar panel"),
      mainPanel("main panel")
    ),
  selectInput("company", label = "Select Company",
              choices = unique(data_set_cars$Company.Name),
              selected = NULL, multiple = TRUE),
  checkboxGroupInput("checkboxGroup", label = "Checkbox",
                     choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3),
                     selected = 1),
  
  
  mainPanel(
    plotOutput("barplot"),
    hr(),
    verbatimTextOutput("value"),
    hr(),
    plotOutput("histogram")
    
    
  )
)



