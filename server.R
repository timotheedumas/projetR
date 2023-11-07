library(shiny)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  data_set_cars <- read.csv("Clean_data_pakwheels.csv",sep=",",encoding="UTF-8")
  filtered_data <- reactive({
    if (is.null(input$company) || length(input$company) == 0) {
      return(data_set_cars)
    } else {
      data_set_cars[data_set_cars$Company.Name %in% input$company, ]
    }
  })
  output$distPlot <- renderPlot({
    
    x    <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    hist(x, breaks = bins, col = "#007bc2", border = "white",
         xlab = "Waiting time to next eruption (in mins)",
         main = "Histogram of waiting times")
    
  })
  output$barplot <- renderPlot({
    ggplot(filtered_data(), aes(x = Company.Name, fill = Company.Name)) +
      geom_bar() +
      labs(x = "Company Name", y = "Count", title = "Bar Plot of Selected Companies") +
      theme_minimal()
  })
  output$histogram <- renderPlot({
    if (!is.null(filtered_data())) {
      hist(filtered_data()$Model.Year, 
           xlab = "Model Year",
           main = "Histogram of cars sold by selected years",
           col = "skyblue")
    }
  })
  
  output$value <- renderPrint({
    input$selectedYears
  })
  
  output$table <- renderTable({
    head(data_set_cars)
  })
  
}