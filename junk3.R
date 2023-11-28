library(shiny)

# Define UI for the app
ui <- fluidPage(
  titlePanel("Subset data.table based on user input"),
  sidebarLayout(
    sidebarPanel(
      # Input for selecting rows based on 'y' column
      selectInput("y", "Select 'y' column value to filter on:",
                  choices = unique(DT$y)),
      
      # Input for selecting rows based on 'z' column
      selectInput("z", "Select 'z' column value to filter on:",
                  choices = unique(DT$z))
    ),
    
    mainPanel(
      # Output the resulting subset data.table
      DTOutput("subset_table")
    )
  )
)

# Define server logic for the app
server <- function(input, output) {
  # Subset the data.table based on user input
  subset_dt <- reactive({
    DT[y == input$y & z == input$z, ]
  })
  
  # Output the subset data.table
  output$subset_table <- renderDT(subset_dt())
}

# Run the app
shinyApp(ui = ui, server = server)
