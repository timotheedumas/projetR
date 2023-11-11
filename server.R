library(shiny)
library(dplyr)
library(leaflet)
library(scales)


server <- function(input, output, session) {
  #load the datas
  data_set_ufo <-
    read.csv("clean-ufo-sightings-transformed.csv",
             sep = ",",
             encoding = "UTF-8")
  
  
  #filter the  year based on user input
  selectedYearHistogram <- reactive({
    data_set_ufo %>% filter(Year == input$yearHistogram) %>%
      mutate(
        Duration_Category = cut(
          length_of_encounter_seconds,
          breaks = c(-1, 10, 60, 300, 1800, 7200, 86400, Inf),
          labels = c(
            '< 10 sec',
            '10 sec - 1 min',
            '1 - 5 min',
            '5 - 30 min',
            '30 min - 2h',
            '2h - 1 day',
            '> 1 day'
          ),
          include.lowest = TRUE
        )
      )
  })
  #display an error message if there is no data available for the selected year
  output$errorTextHistogram <- renderText({
    selected_year <- input$yearHistogram
    if (!selected_year %in% data_set_ufo$Year) {
      return(paste("No data available for the year", selected_year))
    }
  })
  
  #plot the histogram
  output$histogram <- renderPlot({
    ggplot(selectedYearHistogram(),
           aes(x = Duration_Category, fill = Duration_Category)) +
      geom_bar() +
      scale_fill_manual(
        values = c(
          '< 10 sec' = '#3498db',
          '10 sec - 1 min' = '#3498db',
          '1 - 5 min' = '#3498db',
          '5 - 30 min' = '#3498db',
          '30 min - 2h' = '#3498db',
          '2h - 1 day' = '#3498db',
          '> 1 day' = '#3498db'
        )
      ) +
      labs(title = "Histogram of Encounter Duration Categories", x = "Duration Category", y = "Frequency")
  })
  
  #filter the  year based on user input
  selectedYearPieSeason <- reactive({
    data_set_ufo %>% filter(Year == input$year_for_pie_seasons)
  })
  
  #count the number of occurence for each season
  season_counts <- reactive({
    table(selectedYearPieSeason()$Season)
  })
  
  
  
  #plot the pie chart for seasons
  output$pieChartSeasons <- renderPlot({
    if (!is.null(season_counts()) && length(season_counts()) > 0) {
      pie(
        season_counts(),
        labels = names(season_counts()),
        main = paste(
          "Pie Chart of the repartition of the encounters of UFO by season for the year",
          input$year_for_pie_seasons
        )
      )
    }
    #display an error message if there is no relevant datas for the selected year
    else {
      plot(
        1,
        type = "n",
        axes = FALSE,
        xlab = "",
        ylab = ""
      )
      text(
        1,
        1,
        paste(
          "No sufficient datas to plot a pie chart for the year",
          input$year_for_pie_seasons
        ),
        cex = 1.2,
        col = "black",
        font = 2
      )
    }
  })
  
  #filter the  year based on user input
  selectedYearShapes <- reactive({
    data_set_ufo %>% filter(Year == input$year_for_pie_shapes)
  })
  #count the number of occurence for each shape
  shape_counts <- reactive({
    table(selectedYearShapes()$UFO_shape)
  })
  
  #plot the histogram for the shapes repartition
  output$pieChartShapes <- renderPlot({
    if (!is.null(shape_counts()) && length(shape_counts()) > 0) {
      pie(
        shape_counts(),
        labels = names(shape_counts()),
        main = paste(
          "Pie Chart of the repartition of the UFO shape",
          input$year_for_pie_shapes
        )
      )
    }
    else {
      plot(
        1,
        type = "n",
        axes = FALSE,
        xlab = "",
        ylab = ""
      )
      text(
        1,
        1,
        paste(
          "No sufficient datas to plot a pie chart for the year",
          input$year_for_pie_shapes
        ),
        cex = 1.2,
        col = "black",
        font = 2
      )
    }
    
  })
  
  output$plotUfoEncounters <-
    renderPlot({
      ggplot(data_set_ufo, aes(x = Year)) +
        geom_line(stat = "count") +
        labs(title = "Total Number of UFO Encounters by Year", x = "Year", y = "Number of Encounters") +
        theme_minimal()
    })
  
  
  output$ufoMap <- renderLeaflet({
    selectYearMap <- data_set_ufo %>%
      filter(Year == input$year_for_map)
    
    leaflet(selectYearMap) %>%
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
        color = '#3498db',
        fillOpacity = 0.8,
        stroke = FALSE,
        options = popupOptions(closeButton = FALSE)
      )
   
  })
  
}
