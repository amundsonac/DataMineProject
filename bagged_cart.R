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

trainingLabels <- factor(trainingLabels$V1)

## Read in testing data attributes from CSV file
testingDat <- read.csv(
  file = "testing_r.csv",
  header = TRUE,
  stringsAsFactors = FALSE
)

## Read in testing data classes from file
testingLabels <- read.table("label_testing.csv",
                            header = FALSE)

fitControl <- trainControl(
  method = "repeatedcv",
  number = 10,
  repeats = 10
)

baggedCart <- train(x = trainingDat,
                    y = trainingLabels,
                    method = "treebag",
                    preProcess = c("nzv", "center", "scale", "pca"),
                    trControl = fitControl
)

baggedCartClasses <- predict(baggedCart, newdata = testingDat)

baggedCartProbs <- predict(baggedCart, newdata = testingDat, type = "prob")

confusionMatrix(data = baggedCartClasses, testingLabels$V1)
