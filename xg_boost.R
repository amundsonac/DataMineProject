## libraries
require(readr)
require(xgboost)
require(Matrix)
require(data.table)
if (!require('vcd')) {
  install.packages('vcd')
  require(vcd)
}

## Create data frame from CSV file
dat <- read.csv(
  file = "C:/Users/aaron/OneDrive/Documents/GitHub/DataMineProject/training_r.csv",
  header = TRUE,
  stringsAsFactors = FALSE
)
# dat$Class <- as.factor(dat$Class)

## For first instance ignore default values
df <- data.table(dat, keep.rownames = F)

## Split the data into training and testing
smp_size <- floor(0.75 * nrow(df))
train_id <- sample(seq_len(nrow(df)), size = smp_size)

training <- df[train_id,]
output_vector = training[,Class] == 1
training <- subset(training, select = -Class)
testing <- df[-train_id,]

# datMat <- sapply(df, as.numeric)
# trainMat <- sparse.model.matrix(Class~.-1, data = training)
# testMat <- sparse.model.matrix()

bst <- xgboost(data = data.matrix(training),
               label = output_vector,
               max.depth = 6,
               eta = 1,
               nthread = 2,
               nround = 4,
               verbose = 3,
               objective = "binary:logistic")


pred <- predict(bst, data.matrix(testing))
err <- mean(as.numeric(pred > 0.5) != testing$Class)

# importanceRaw <- xgb.importance(@Dimnames[[2]], model = bst, data = data.matrix(training), label = output_vector)


names <- dimnames(data.matrix(training))[[2]]
importance_matrix <- xgb.importance(colnames(training), model = bst)

## For second instance handle default values
