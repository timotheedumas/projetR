library(shiny)
library(dplyr)
library(leaflet)
library(scales)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  data_set_ufo <-
    read.csv("clean-ufo-sightings-transformed.csv",
             sep = ",",
             encoding = "UTF-8")
  
  
  selectedYearHistogram <- reactive({
    data_set_ufo %>% filter(Year == input$years)
  })
  
  output$histogram <- renderPlot({
    ggplot(selectedYearHistogram(),
           aes(x = length_of_encounter_minutes, stat = "count")) +
      geom_histogram(
        bins = 20,
        binwidth = max(selectedYearHistogram()$length_of_encounter_minutes) / 50,
        fill = "blue",
        color = "black",
        alpha = 0.7
      ) +
      labs(title = "Histogram of Encounter Length", x = "Length (minutes)", y = "Frequency") + coord_cartesian(xlim = c(0, max(
        selectedYearHistogram()$length_of_encounter_minutes
      )))
  })
  
  
  selectedyearPie <- reactive({
    data_set_ufo %>% filter(Year == input$year_for_pie)
  })
  season_counts <- reactive({
    table(selectedyearPie()$Season)
  })
  
  custom_colors <- c("#f28500", "green", "#F2FD00", "#00FDF2")
  
  output$pieChart <- renderPlot({
    pie(
      season_counts(),
      labels = names(season_counts()),
      main = paste(
        "Pie Chart of the repartition of the encounters of UFO by season for the year",
        input$year_for_pie
      ),
      col = custom_colors
    )
    
  })
  
  
  
  
  output$ufoMap <- renderLeaflet({
    map_data <- data_set_ufo %>%
      filter(Year == input$year_for_map)
    
    leaflet(map_data) %>%
      addTiles() %>%
      addCircleMarkers(
        lng = ~ longitude,
        lat = ~ latitude,
        popup = ~ paste(
          Year,
          Country,
          paste("Visible during", length_of_encounter_minutes, "minutes"),
          paste("Description: ", Description),
          sep = "<br>"
        ),
        radius = 5,
        fillOpacity = 0.8,
        stroke = FALSE,
        options = popupOptions(closeButton = FALSE)
      )
  })
}
