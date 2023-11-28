
  
  ui <- fluidPage(
    checkboxGroupInput("variable", "Variables to show:",
                       c("A" = "cyl",
                         "B" = c("am", "gear"),
                         "Gears" = "gear")),
    tableOutput("data")
  )
  
  server <- function(input, output, session) {
    output$data <- renderTable({
      mtcars[, c("mpg", input$variable), drop = FALSE]
    }, rownames = TRUE)
  }
  
  shinyApp(ui, server)
  
