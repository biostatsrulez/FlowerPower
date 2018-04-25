ui <- fluidPage(
  
  # Application title
  titlePanel("Predicting Flower Species"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("petal_length",
                  "Petal Length:",
                  value = 4.5,
                  min = 1,
                  max = 7,
                  step = 0.25),
       
      sliderInput("petal_width",
                  "Petal Width:",
                  value = 4.5,
                  min = 0.1,
                  max = 2.5,
                  step = 0.1),
       
      sliderInput("sepal_length",
                  "Sepal Length:",
                  value = 5.5,
                  min = 4,
                  max = 8,
                  step = 0.25),
       
      sliderInput("sepal_width",
                  "Sepal Width:",
                  value = 3,
                  min = 2,
                  max = 4.5,
                  step = 0.25)
      ),
     
    # Show a plot of the generated distribution
    mainPanel(
      dataTableOutput("pred_table")
    )
  )
)


# Run the application 
shinyApp(ui = ui, server = server)