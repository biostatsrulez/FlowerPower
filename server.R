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
                 , size = 4, color = "red") +
      theme(
        axis.title.x = element_text(face = "bold")
        ,axis.title.y = element_text(face = "bold")
        ,legend.position = "right"
        
      ) +
      labs(
        x = "Sepal Length",
        y = "Sepal Width",
        title = "Scatter Plot of Sepal Length vs Width by Species"
      ) 
    
  })
  
  output$plot2 <- renderPlot({
    
   p2<- ggplot(iris, aes(x = Petal.Length, fill = factor(Species))) +
      geom_density(alpha = 0.5) +
      geom_vline(xintercept = input$petal_length, color = "red") +
     theme(
       axis.title.x = element_blank()
       ,axis.title.y = element_text(face = "bold")
       ,plot.title = element_text(face = "bold")
       ,legend.position = "none"
       
     ) +
     labs(
       y = "Density",
       title = "Petal Length"
     ) 
   
 
  p3<-  ggplot(iris, aes(x = Petal.Width, fill = factor(Species))) +
      geom_density(alpha = 0.5) +
      geom_vline(xintercept = input$petal_width, color = "red") +
    theme(
      axis.title.x = element_blank()
      ,axis.title.y = element_blank()
      ,plot.title = element_text(face = "bold")
      ,legend.position = "top"
      
    ) +
    labs(
      y = "Density",
      title = "Petal Width"
    ) + 
    guides(fill=guide_legend(title="Species"))
  
    
  p4<-  ggplot(iris, aes(x = Sepal.Length, fill = factor(Species))) +
      geom_density(alpha = 0.5) +
      geom_vline(xintercept = input$sepal_length, color = "red") +
    theme(
      axis.title.x = element_text(face = "bold")
      ,axis.title.y = element_text(face = "bold")
      ,plot.title = element_text(face = "bold")
      ,legend.position = "none"
      
    ) +
    labs(
      x = "Length",
      y = "Density",
      title = "Sepal Length"
    ) 
  
    
  p5<- ggplot(iris, aes(x = Sepal.Width, fill = factor(Species))) +
      geom_density(alpha = 0.5) +
      geom_vline(xintercept = input$sepal_width, color = "red") +
    theme(
      axis.title.x = element_text(face = "bold")
      ,axis.title.y = element_blank()
      ,plot.title = element_text(face = "bold")
      ,legend.position = "none"
      
    ) +
    labs(
      x = "Width",
      y = "Density",
      title = "Sepal Width"
    ) 
  
  
  
  glist <- list(p2, p3, p4, p5)
  
  
  grid.arrange(grobs = glist ,ncol = 2)
  })
  
  
  
}

