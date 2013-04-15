cappedProb <- function(prob,upper,lower){
  temp <- prob
  temp[temp>upper] <- upper
  temp[temp<lower] <- lower
  return(temp)
  
}