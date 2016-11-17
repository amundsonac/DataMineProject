## libraries
library(caret)
library(AppliedPredictiveModeling)
library(mlbench)


## THIS DOESN'T WORK!!

## visualization

## Create data frame from CSV file
dat <- read.csv(
  file = "C:/Users/aaron/OneDrive/Documents/GitHub/DataMineProject/training_r.csv",
  header = TRUE,
  stringsAsFactors = FALSE
)
# dat$Class <- as.factor(dat$Class)

## Data Preprocessing
dat1 <- scale(dat,TRUE,TRUE)


nzv <- nearZeroVar(dat1,
                   freqCut = 95/5,
                   saveMetrics = FALSE)
dat2 <- dat1[, -nzv]

preProcFtlValues <- preProcess(dat3, method = c("range","pca"), na.rm = TRUE) 
ftlDatTransformed <- predict(preProcFtlValues, ftlDat)

preProcDf <- preProcess(ftlDatTransformed,
                        method = "pca",
                        pcaComp = 10,
                        na.remove = TRUE)




## Partition preprocessed data
set.seed(998)
inTrain <- createDataPartition(preProcDat$class, p = 0.75, list = FALSE)
training <- preProcDat[inTrain,]
testing <- preProcDat[-inTrain,]

table(training$class)
table(testing$class)

# Run prediction on datasets
# trainTransformed <- predict(preProcDat, training)
# testTransformed <- predict(preProcDat, testing)
