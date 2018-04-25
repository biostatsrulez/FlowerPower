server <- function(input, output) {
  
  
  output$table <- DT::renderDataTable({
    
    genPreds(
      petal_length = input$petal_length,
      petal_width = input$petal_width,
      sepal_length = input$sepal_length,
      sepal_width = input$sepal_width
    ) %>%
      datatable() %>%
      formatPercentage(columns = "preds", digits =2)
    
  })
  
  output$plot1 <- renderPlot({
    
    ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
      geom_point(aes(color = Species)) +
      geom_point(aes(x = input$sepal_length, y = input$sepal_width)
                 , size = 4, color = "red") 
    
  })
  
  output$plot2 <- renderPlot({
    
    ggplot(iris, aes(x = Petal.Length, y = Petal.Width)) +
      geom_point(aes(color = Species)) +
      geom_point(aes(x = input$petal_length, y = input$petal_width)
                 , size = 4, color = "red") 
    
  })
  
  
}

