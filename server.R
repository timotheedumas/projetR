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
    data_set_ufo %>% filter(Year == input$years) %>%
      mutate(
        Duration_Category = cut(
          length_of_encounter_seconds,
          breaks = c(-1, 10, 60, 300, 1800, 7200, 86400, Inf),
          labels = c('< 10 sec', '10 sec - 1 min', '1 - 5 min', '5 - 30 min', '30 min - 2h', '2h - 1 day', '> 1 day'),
          include.lowest = TRUE
        )
      )
  })
  
  output$histogram <- renderPlot({
    ggplot(selectedYearHistogram(), aes(x = Duration_Category, fill = Duration_Category)) +
      geom_bar() +
      scale_fill_manual(values = c('< 10 sec' = 'blue', '10 sec - 1 min' = 'blue', '1 - 5 min' = 'blue', '5 - 30 min' = 'blue', '30 min - 2h' = 'blue', '2h - 1 day' = 'blue', '> 1 day' = 'blue')) +
      labs(title = "Histogram of Encounter Duration Categories", x = "Duration Category", y = "Frequency")
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
