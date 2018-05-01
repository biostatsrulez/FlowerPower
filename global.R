library(tidyverse)
library(ggplot2)
library(xgboost)
library(shiny)
library(DT)
library(gridExtra)

# Gen Predictions #

FlowerPower <- xgb.load("inst/flower.model")
load("inst/FlowerPowerInfo2.rda")

genPreds <- function(petal_length = 2,petal_width = 1, sepal_width = 4, sepal_length = 5){
  
  testDF <- data.frame(Sepal.Length = sepal_length, Sepal.Width = sepal_width, Petal.Length = petal_length, Petal.Width = petal_width)
  
  preds <- predict(FlowerPower, as.matrix(testDF))
  
  
  data.frame(
    Species = var.levels
    ,preds
  ) %>%
    arrange(desc(preds))
}
