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

ui <- fluidPage(
  # App title ----
  titlePanel(h1("Dashboard to analyse the ufo sightings ", align = "center")),
  
  
  sidebarLayout(mainPanel(plotOutput("histogram")),
                sidebarPanel(
                  sliderInput(
                    inputId = "years",
                    label = "Year",
                    min = min(data_set_ufo$Year),
                    max = max(data_set_ufo$Year),
                    step = 5,
                    value = 1960,
                    sep = ""
                  )
                  
                )),
  
  textOutput("columns"),
  plotOutput("pieChart"),
  mainPanel(tabsetPanel(type = "tabs",
                        
                        tabPanel(
                          "Map", leafletOutput("ufoMap")
                        ))),
  sidebarPanel(sliderInput(
    inputId = "year_for_map",
    label = "Year",
    min = min(data_set_ufo$Year),
    max = max(data_set_ufo$Year),
    step = 5,
    value = 1960,
    sep = ""
  ))
  
)
