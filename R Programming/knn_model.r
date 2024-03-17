install.packages("mlbench")
library(mlbench)
library(tidyverse)
library(caret)

data("BostonHousing")
data("PimaIndiansDiabetes")

## review train
clean_df <- mtcars %>%
  select(mpg, hp , wt, cyl, carb)#%>%
 #mutate(am = replace_na(am, 1)
  #       wt = replace_na(wt, 3.21))
  
  
# linear
(lm_model <- train(
  mpg ~ .,
  data = clean_df,
  method = "lm"
))

# KNN
## Experimentation
set.seed(42)

## grid search
k_grid <- data.frame(k = c(3,5,7) )

ctrl <- trainControl(
  method = "cv",
  #method = "repeatedcv",
  number = 3,
  #repeats = 5,
  verboseIter = TRUE #progress bar
)

knn_model <- train(
  mpg ~ .,
  data = clean_df,
  method = "knn",
  metric = "RMSE",
  trControl = ctrl,
  tuneGrid = k_grid
)

## random k 3 values
knn_model <- train(
  mpg ~ .,
  data = clean_df,
  method = "knn",
  metric = "RMSE",
  trControl = ctrl,
  tuneLenght = 3
)

##decision tree
set.seed(42)
(dcs_model <- train(
  mpg ~ .,
  data = clean_df,
  method = "rpart",
  metric = "RMSE"
))

## save model
## .RDS extension
saveRDS(knn_model,"knnModel.RDS")




# Normalization
## 1. min-max(featrue scaling 0-1)
## 2. standardization -3,+3

x <- c(5,10,12,15,20)

minmaxNorm <- function(x){
  (x-min(x)) / (max(x)-min(x))
}

## center and scale
zNorm <- function(x){
  (x-mean(x))/sd(x)
}

# preprocess 
train_df <- mtcars[1:20,]
test_df <- mtcars[21:32,]

##compute x_bar,x_sd
transformer <- preProcess(train_df,
                          method = c("center","scale"))

## min-max scaling[0,1]
transformer <- preProcess(train_df,
                          method = c('range'))

train_df_z <- predict(transformer,train_df)
test_df_z <- predict(transformer, test_df)


