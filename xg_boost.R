## libraries
require(readr)
require(xgboost)
require(Matrix)
require(data.table)
if (!require('vcd')) install.packages('vcd')

## Create data frame from CSV file
dat <- read.csv(
  file = "C:/Users/aaron/OneDrive/Documents/GitHub/DataMineProject/training_r.csv",
  header = TRUE,
  stringsAsFactors = FALSE
)
dat$Class <- as.factor(dat$Class)

## For first instance ignore default values
df <- data.table(dat, keep.rownames = F)

# datMat <- sapply(df, as.numeric)
datMat <- sparse.model.matrix(Class~.-1, data = df)

output_vector = df[,Class] == 1

bst <- xgboost(data = datMat,
               label = df$Class,
               missing = 0,
               max.depth = 6,
               eta = 0.3,
               subsample = 1,
               nthread = 2,
               nround = 10,
               objective = "binary:logistic")




## For second instance handle default values
