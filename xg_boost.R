## libraries
require(readr)
require(xgboost)
require(Matrix)
require(data.table)
if (!require('vcd')) {
  install.packages('vcd')
  require(vcd)
}

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

## For first instance ignore default values
training <- data.table(trainingDat, keep.rownames = F)
testing <- data.table(testingDat, keep.rownames = F)

# Convert to binary values
training_vector = trainingLabels$V1 == 1

bst <- xgboost(data = data.matrix(training),
               label = training_vector,
               max.depth = 6,
               eta = 1,
               nthread = 2,
               nround = 4,
               verbose = 3,
               objective = "binary:logistic")

xgbClasses <- predict(baggedCart, newdata = data.matrix(testingDat))
xgbProbs <- predict(baggedCart, newdata = data.matrix(testingDat), type = "prob")
err <- mean(as.numeric(xgbClasses > 0.5) != testingLabels$V1)

confusionMatrix(data = baggedCartClasses, testingLabels$V1)

names <- dimnames(data.matrix(training))[[2]]
importance_matrix <- xgb.importance(colnames(training), model = bst)

## For second instance handle default values
