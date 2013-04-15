library(caret)
fixData <- function(data){
  preProc <- preProcess(data,method=c("center","scale"))
  return(predict(preProc,data))

}