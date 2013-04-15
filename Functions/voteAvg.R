voteAvg <- function(svmPredA,svmPredE,lowbound,highbound){

vote1 <- (svmPredE[1:193]>highbound) + (svmPredE[194:386]>highbound) + (svmPredA[1:193]>highbound) + (svmPredA[194:386]>highbound) == 3
vote0 <- (svmPredE[1:193]<lowbound) + (svmPredE[194:386]<lowbound) + (svmPredA[1:193]<lowbound) + (svmPredA[194:386]<lowbound) == 3

accum1 <- matrix(0,193,1)
accum0 <- matrix(0,193,1)

accum1[svmPredE[1:193]>highbound] <- svmPredE[1:193][svmPredE[1:193]>highbound]
accum1[svmPredA[1:193]>highbound] <- accum1[svmPredA[1:193]>highbound] + svmPredA[1:193][svmPredA[1:193]>highbound]
accum1[svmPredE[194:386]>highbound] <- accum1[svmPredE[194:386]>highbound] + svmPredE[1:193][svmPredE[194:386]>highbound]
accum1[svmPredA[194:386]>highbound] <- accum1[svmPredA[194:386]>highbound] + svmPredA[1:193][svmPredA[194:386]>highbound]

accum0[svmPredE[1:193]<lowbound] <- svmPredE[1:193][svmPredE[1:193]<lowbound]
accum0[svmPredA[1:193]<lowbound] <- accum0[svmPredA[1:193]<lowbound] + svmPredA[1:193][svmPredA[1:193]<lowbound]
accum0[svmPredE[194:386]<lowbound] <- accum0[svmPredE[194:386]<lowbound] + svmPredE[1:193][svmPredE[194:386]<lowbound]
accum0[svmPredA[194:386]<lowbound] <- accum0[svmPredA[194:386]<lowbound] + svmPredA[1:193][svmPredA[194:386]<lowbound]

output = c(vote0=vote0,vote1=vote1,high=accum1[vote1]/3,low=accum0[vote0]/3)
return(output)
}