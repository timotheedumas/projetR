library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)
library(ggplot2)
library(dplyr)
library(leaflet)
library(rjson)
library(sf)
library(leaflet)


data_set_ufo <-
  read.csv("clean-ufo-sightings-transformed.csv",
           sep = ",",
           encoding = "UTF-8")

ui <- fluidPage(titlePanel(h1(
  "Dashboard to analyse the ufo sightings ", align = "center"
)),



mainPanel(
  tabsetPanel(
    tabPanel(
      "Histogram",
      plotOutput("histogram"),
      sliderInput(
        inputId = "yearHistogram",
        label = "Year",
        min = min(data_set_ufo$Year),
        max = max(data_set_ufo$Year),
        step = 1,
        value = 1960,
        sep = ""
      )
    ),
    
    tabPanel(
      "Pie chart Seasons",
      plotOutput("pieChartSeasons"),
      sliderInput(
        inputId = "year_for_pie_seasons",
        label = "Year",
        min = min(data_set_ufo$Year),
        max = max(data_set_ufo$Year),
        step = 1,
        value = 1960,
        sep = ""
      )
    ),
    
    tabPanel(
      "Pie chart Shapes",
      plotOutput("pieChartShapes"),
      sliderInput(
        inputId = "year_for_pie_shapes",
        label = "Year",
        min = min(data_set_ufo$Year),
        max = max(data_set_ufo$Year),
        step = 1,
        value = 1960,
        sep = ""
      ),
      
    ),
    
    tabPanel(
      "plot of the UFO encounters per year"
      ,
      plotOutput("plotUfoEncounters")
    ),
    
    tabPanel(
      "Map of the UFO encounters",
      leafletOutput("ufoMap"),
      sliderInput(
        inputId = "year_for_map",
        label = "Year",
        min = min(data_set_ufo$Year),
        max = max(data_set_ufo$Year),
        step = 1,
        value = 1960,
        sep = ""
      ),
    )
  )
))
