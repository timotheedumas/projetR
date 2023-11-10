library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)
library(ggplot2)
library(dplyr)
library(leaflet)
library(rjson)
library(sf)


data_set_ufo <- read.csv("clean-ufo-sightings-transformed.csv",sep=",",encoding="UTF-8")

ui <- fluidPage(
  
  # App title ----
  titlePanel(h1("ufo sightings", align = "center")),
  
  

  p("minAnnee", align = "right"),
  
  sidebarLayout(
    mainPanel(
      textOutput("selected_year"),
      plotOutput("histogram")
      ),
    sidebarPanel(
      sliderInput(inputId = "years",
                  label = "Year",
                  min = 1910,
                  max = 2010,
                  step = 5,
                  value = 1940,
                  sep = ""
                  )
    
                )
    ),
  textOutput("min_value_output"),
  textOutput("columns")
    
)



