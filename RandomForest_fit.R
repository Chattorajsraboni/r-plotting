set.seed(123)

install.packages("randomForest")
library(randomForest)

dataset <- read.csv("adult.data", header = FALSE)
head(dataset)
nrow(dataset)

train_ind <- sample(seq_len(nrow(dataset)), size = nrow(dataset)-3000)

train <- dataset[train_ind, ]
test <- dataset[-train_ind, ]

mean(test$V1)

salary_prediction <- randomForest(x = train[ , c(1,5,6,7,9,13)], y = train[,15], xtest = test[ , c(1,5,6,7,9,13)], ytest = test[,15], ntree = 200, mtry = 3)

print(salary_prediction)
