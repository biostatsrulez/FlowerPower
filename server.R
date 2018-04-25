server <- function(input, output) {
  
  output$pred_table <- DT::renderDataTable({
    
    genPreds(
      petal_length = input$petal_length,
      petal_width = input$petal_width,
      sepal_length = input$sepal_length,
      sepal_width = input$sepal_width
    ) %>%
      datatable() %>%
      formatPercentage(columns = "preds", digits =2)
    
  })
}

