## libraries
require(readr)
require(xgboost)
require(Matrix)
require(data.table)
if (!require('vcd')) {
  install.packages('vcd')
  require(vcd)
}

## Import differently formatted data
dat <- read.csv(
  file = "C:/Users/aaron/OneDrive/Documents/GitHub/DataMineProject/training_r.csv",
  header = TRUE,
  stringsAsFactors = FALSE
)

## Import the data labels

## Transform the data labels into 

## Read data into a data table
df <- data.table(dat, keep.rownames = F)

## May want to scale the data and/or do some dimensionality reduction




## Transform data into sparse matrix
sparse_matrix <- sparse.model.matrix(Class)