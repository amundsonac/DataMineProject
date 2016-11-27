## libraries
library(caret)

## Read in training data attributes from CSV file
trainingDat <- read.csv(
  file = "training_r.csv",
  header = TRUE,
  stringsAsFactors = FALSE
)

## Read in training data classes from file
trainingLabels <- read.table("label_training.txt",
                             header = FALSE)

## Read in testing data attributes from CSV file
testingDat <- read.csv(
  file = "testing_r.csv",
  header = TRUE,
  stringsAsFactors = FALSE
)

## Read in testing data classes from file
testingLabels <- read.table("label_testing.csv",
                             header = FALSE)

## K-fold cross-validation for model training
fitControl <- trainControl(
  method = "repeatedcv",
  number = 10,
  repeats = 10
)

## Tuning Parameters
gbmGrid <-  expand.grid(interaction.depth = c(1, 5, 9), 
                        n.trees = (1:30)*50, 
                        shrinkage = 0.1,
                        n.minobsinnode = 20)


gbm <- train(trainingDat,
                    trainingLabels$V1,
                    method = "gbm",
                    preProcess = c("nzv", "center", "scale", "pca"),
                    tuneGrid = gbmGrid,
                    trControl = fitControl
)

gbmClasses <- predict(gbm, newdata = testingDat)

gbmProbs <- predict(gbm, newdata = testingDat, type = "prob")

confusionMatrix(data = gbmClasses, testingLabels$V1)
