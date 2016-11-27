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

## Tuning parameters
grid <- expand.grid(.size = c(1,5,10),
                    .decay = c(0,0.001,0.1))

neuralNet <- train(trainingDat,
                  trainingLabels,
                  method = "neuralnet",
                  preProcess = c("nzv", "center", "scale", "pca"),
                  trControl = fitControl
)

neuralNetClasses <- predict(neuralNet, newdata = testingDat)

neuralNetmProbs <- predict(neuralNet, newdata = testingDat, type = "prob")

confusionMatrix(data = neuralNetClasses, testingLabels$V1)