LogLoss<-function(actual, predicted)
{
  result<- -1/length(actual)*(sum((actual*log(predicted)+(1-actual)*log(1-predicted))))
  return(result)
}