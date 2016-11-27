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

bayesGlm <- train(trainingDat,
             trainingLabels,
             method = "bayesglm",
             preProcess = c("nzv", "center", "scale", "pca"),
             trControl = fitControl
)

bayesGlmClasses <- predict(bayesGlm, newdata = testingDat)

bayesGlmmProbs <- predict(bayesGlm, newdata = testingDat, type = "prob")

confusionMatrix(data = bayesGlmClasses, testingLabels$V1)