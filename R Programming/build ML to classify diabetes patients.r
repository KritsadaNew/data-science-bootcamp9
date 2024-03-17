
## build ML to classify diabetes patients
## binary classification

library(mlbench)
library(tidyverse)
library(caret)
library(MLmetrics)

##load dataset
data("PimaIndiansDiabetes")
df <- PimaIndiansDiabetes

## explore dataset
glimpse(df)

# no missing value
mean(complete.cases(df))

## select varibles
 df_starter <- df %>%
   select(2,5,6,8,9,diabetes)
 
## 1.split data
set.seed(42)
n <- nrow(df_starter)
id <- sample(1:n, size = 0.8*n)
train_df <- df_starter[id, ]
test_df <- df_starter[-id, ]

## 2.train
set.seed(42)
## use for Recall , F1, AUC
ctrl <- trainControl(method = "cv",
                     number = 5,
                     ##pr = precision + recall
                     summaryFunction = prSummary,
                     classProbs = TRUE)
## use for Accuracy
##ctrl <- trainControl(method = "cv",
                     #number = 5,
                     ##pr = precision + recall
                     

logis_model <- train(diabetes ~ .,
                     data = train_df,
                     method = "glm",
                     metric = "Recall",# เน€เธเธฅเธตเนเธขเธเน€เธเนเธ Accuracy for use for Accuracy
                     trControl = ctrl) 
## 3.score
p<- predict(logis_model, newdata = test_df)

## 4.evaluate
mean(p== test_df$diabetes)

## confusion matrix
table(test_df$diabetes, p, dnn = c("actual","preds"))
confusionMatrix(p,
                test_df$diabetes,
                positive = "pos",
                mode = "prec_recall")
