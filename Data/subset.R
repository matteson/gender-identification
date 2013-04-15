setwd('/Users/Andrew/Kaggle/Gender_ident/Submissions/glmnet_with_magic/Data/')
M <- read.csv('train.csv')

M_sub <- M[M$language=='Arabic',]
M_sub <- M_sub[M_sub$same_text==1,]
non_features <- subset(M_sub,select=c(1:4))
M_sub <- subset(M_sub,select=-c(1:4))
write.csv(M_sub,'arabic_same_text.csv')

M_sub2 <- M[M$language=='Arabic',]
M_sub2 <- M_sub2[M_sub2$same_text==0,]
non_features2 <- subset(M_sub2,select=c(1:4))
M_sub2 <- subset(M_sub2,select=-c(1:4))
write.csv(M_sub2,'arabic_diff_text.csv')

M_sub2 <- M[M$language=='English',]
M_sub2 <- M_sub2[M_sub2$same_text==1,]
non_features2 <- subset(M_sub2,select=c(1:4))
M_sub2 <- subset(M_sub2,select=-c(1:4))
write.csv(M_sub2,'english_same_text.csv')

M_sub2 <- M[M$language=='English',]
M_sub2 <- M_sub2[M_sub2$same_text==0,]
non_features2 <- subset(M_sub2,select=c(1:4))
M_sub2 <- subset(M_sub2,select=-c(1:4))
write.csv(M_sub2,'english_diff_text.csv')