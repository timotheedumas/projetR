library(shiny)
library(dplyr)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  data_set_ufo <- read.csv("clean-ufo-sightings-transformed.csv",sep=",",encoding="UTF-8")
  
  minAnnee <- min(data_set_ufo$Year)
  maxAnnee <- max(data_set_ufo$Year)
  
  choix_annee <- reactive({
    data_set_ufo %>% filter(Year == input$years)
  })
  output$histogram <- renderPlot({
    ggplot(choix_annee(), aes(x = length_of_encounter_minutes, stat = "count")) +
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
    paste("Minimum Value:", minAnnee)
  })
  
  output$columns <- renderText({
    paste(";", print(colnames(data_set_ufo)))
  })
}
