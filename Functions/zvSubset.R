zvSubset <- function(data){
  nzv <- nearZeroVar(data)
  subseted <- data[,-nzv]
  return(list(subseted=subseted,nzv=nzv))
}