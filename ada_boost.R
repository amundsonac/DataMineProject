## libraries
library(caret)

set.seed(998)

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

grid <- expand.grid(mfinal = (1:3)*3, maxdepth = c(1, 3),
                    coeflearn = c("Breiman", "Freund", "Zhu"))

adaBoost <- train(trainingDat,
                  trainingLabels,
                  method = "AdaBoost.M1",
                  preProcess = c("nzv", "center", "scale", "pca"),
                  trControl = fitControl,
                  tuningGrid = grid
)

adaBoostClasses <- predict(adaBoost, newdata = testingDat)

adaBoostmProbs <- predict(adaBoost, newdata = testingDat, type = "prob")

confusionMatrix(data = adaBoostClasses, testingLabels$V1)