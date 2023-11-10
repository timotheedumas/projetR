library(shiny)
library(dplyr)
library(leaflet)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  data_set_ufo <- read.csv("clean-ufo-sightings-transformed.csv",sep=",",encoding="UTF-8")
  
  minYear <- min(data_set_ufo$Year)
  maxYear <- max(data_set_ufo$Year)
  
  selectedYear <- reactive({
    data_set_ufo %>% filter(Year == input$years)
  })
  output$histogram <- renderPlot({
    ggplot(selectedYear(), aes(x = length_of_encounter_minutes, stat = "count")) +
      geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
      labs(title = "Histogram of Encounter Length", x = "Length (minutes)", y = "Frequency")
  })
  
  
  output$plot <- renderPlot({
    
    gapminder %>%
      filter(Year==input$years) %>%
      ggplot(aes(x=gdpPercap, y=lifeExp, color=continent, size=pop)) +
      geom_point()
    
  })
  output$selected_year <- renderText({ 
    paste("You have selected", input$years)
  })
  output$selected_year <- renderText({ 
  paste("You have selected", input$years)
})
  output$min_value_output <- renderText({
    paste("Minimum Value:", minYear)
  })
  
  output$columns <- renderText({
    paste(";", print(colnames(data_set_ufo)))
  })
  
  output$ufoMap <- renderLeaflet({
    # Subset the data for the map based on the selected year
    map_data <- data_set_ufo %>%
      filter(Year == input$years)
    
    # Create a leaflet map object
    leaflet(map_data) %>%
      addTiles() %>%
      addCircleMarkers(
        lng = ~longitude, lat = ~latitude,
        popup = ~paste(Year,
                       Country,
                       paste("Visible during", length_of_encounter_minutes, "minutes"),
                       paste("Description: ", Description),
                       sep = "<br>"),
        radius = 5, fillOpacity = 0.8, stroke = FALSE,
        options = popupOptions(closeButton = FALSE)
      )
  })
}
