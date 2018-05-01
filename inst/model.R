# Model Building #

flowerdata <- iris

y <- flowerdata$Species

var.levels <- levels(y)

y <- as.integer(y)-1

no_outcome <- iris[,-5]
var.names<- names(no_outcome)
x = as.matrix(no_outcome)

params <- list(
  "objective" = "multi:softprob"
  ,"eval_metric" = "mlogloss"
  ,"num_class" = length(table(y))
  ,"eta" = 0.1
  ,"max_depth" = 3
)


cv.nround = 200

bst.cv <- xgb.cv(param = params, data = x, label = y
                 , nfold = 5, nrounds = cv.nround
                 , missing = NA
                 , prediction = TRUE)


which.min(bst.cv$evaluation_log$test_mlogloss_mean)

cv.nround = 40

FlowerPower <- xgboost(param = params, data = x, label  = y,
                        nrounds = cv.nround, missing  = NA)


xgb.importance(var.names, model = FlowerPower)

xgb.save(FlowerPower, "flower.model")

FlowerPowerInfo <- list(
  var.names = var.names
  ,var.levels = var.levels
)

save(FlowerPowerInfo, file = 'FlowerPowerInfo.rda')


# Gen Predictions #

genPreds <- function(petal_length = 2,petal_width = 1, sepal_width = 4, sepal_length = 5){
  
  testDF <- data.frame(Sepal.Length = sepal_length, Sepal.Width = sepal_width, Petal.Length = petal_length, Petal.Width = petal_width)
  
  preds <- predict(FlowerPower, as.matrix(testDF))
  
  
  data.frame(
    Cut = var.levels
    ,preds
  ) %>%
    arrange(desc(preds))
}

