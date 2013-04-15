setwd('/Users/Andrew/Kaggle/Gender_ident/Submissions/glmnet_with_magic/')
#Setup
rm(list = ls(all = TRUE)) 
gc(reset=TRUE)
set.seed(42) #From random.org

#Libraries
library(caret)

#Data
trainFeaturesEnglish <- read.csv('FeatureSelection/englishMutualInfoFeaturesTrain.csv',header=FALSE)
testFeaturesEnglish  <- read.csv('FeatureSelection/englishMutualInfoFeaturesTest.csv',header=FALSE)
trainFeaturesArabic  <- read.csv('FeatureSelection/arabicMutualInfoFeaturesTrain.csv',header=FALSE)
testFeaturesArabic   <- read.csv('FeatureSelection/arabicMutualInfoFeaturesTest.csv',header=FALSE)

trainLabels <- matrix(read.csv('Data/train_answers.csv')$male,ncol=1)

trainFeaturesEnglish1 <- trainFeaturesEnglish[1:282,]
trainFeaturesEnglish2 <- trainFeaturesEnglish[283:564,]
trainFeaturesArabic1 <- trainFeaturesArabic[1:282,]
trainFeaturesArabic2 <- trainFeaturesArabic[283:564,]

testFeaturesEnglish1 <- testFeaturesEnglish[1:193,]
testFeaturesEnglish2 <- testFeaturesEnglish[194:386,]
testFeaturesArabic1 <- testFeaturesArabic[1:193,]
testFeaturesArabic2 <- testFeaturesArabic[194:386,]

#Split train/test
train <- cbind(trainFeaturesEnglish1,trainFeaturesArabic1)
test  <- cbind(testFeaturesEnglish1,testFeaturesArabic1)

colnames(train) <- make.unique(colnames(train))
colnames(test) <- make.unique(colnames(test))

nzv <- nearZeroVar(train)
train <- train[,-nzv]
test  <- test[,-nzv]

#Setup CV Folds
#returnData=FALSE saves some space
folds=5
repeats=1
index=createMultiFolds(trainLabels, k=folds, times=repeats);
myControl <- trainControl(method='cv', number=folds, repeats=repeats, returnResamp='none', 
                          returnData=FALSE, savePredictions=TRUE, 
                          verboseIter=TRUE, allowParallel=TRUE,
                          index=index)
PP <- c('center', 'scale')

#Train some models

model <- train(train, trainLabels, method='glmnet', trControl=myControl, preProcess=PP,
                 family='gaussian')

#Make a list of all the models
all.models <- list(model)
names(all.models) <- sapply(all.models, function(x) x$method)
sort(sapply(all.models, function(x) min(x$results$RMSE)))

#Predict for test set:
preds_train <- data.frame(sapply(all.models, predict, newdata=train))
preds <- data.frame(sapply(all.models, predict, newdata=test))

source('../../Functions/cappedProb.R')
source('../../Functions/LogLoss.R')

write.csv(cbind(trainLabels,preds_train),file="find_the_magic.csv")
# find a transform for the training data that improves things
# copy over the training predictions
    
magic1 = 11.29
magic2 = .5080

bestfit = 1/(1+exp(-magic1*(preds$glmnet-magic2)))

submit_greedy <- cappedProb(bestfit,.95,.05)
submit_file = cbind(c(283:475),submit_greedy)
write.table(submit_file, file="submissioncons.csv",row.names=FALSE, col.names=FALSE, sep=",")

temp <- read.csv('../../CrossValidations/caretMedley/unlikely.csv',header=FALSE)
plot(temp[,2],submit_greedy)