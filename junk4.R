library(shiny)
library(data.table)

# Define the UI
ui <- fluidPage(
  titlePanel("Calculate Population Sum"),
  sidebarLayout(
    sidebarPanel(
      selectInput("x_select", "Select x:", choices = c("A", "B", "C"), multiple = TRUE),
      selectInput("y_select", "Select y:", choices = c(1, 2, 3, 4, 5), multiple = TRUE)
    ),
    mainPanel(
      tableOutput("selected_table"),
      verbatimTextOutput("pop_sum")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  
  # Load the data.table object
  mylength <- 100
  x <- sample(c("A", "B", "C"), mylength, replace=TRUE, prob = NULL)
  y <- sample(c(1, 2, 3, 4, 5), mylength, replace=TRUE, prob = NULL)
  z <- sample(c(TRUE, FALSE), mylength, replace=TRUE, prob=c(0.9,0.1))
  pop <- runif(mylength,30,100)
  DT <- data.table(x,y,z,pop)
  
  # Display the selected data table
  output$selected_table <- renderTable({
    DT_subset <- DT[x %in% input$x_select & y %in% input$y_select, ]
    DT_subset
  })
  
  # Calculate the population sum based on user input
  output$pop_sum <- renderPrint({
    DT_subset <- DT[x %in% input$x_select & y %in% input$y_select, ]
    sum(DT_subset$pop)
  })
}

# Run the app
shinyApp(ui, server)
