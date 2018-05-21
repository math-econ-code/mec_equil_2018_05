rm(list=ls())
library(doParallel)
#
n_cores <- 2
#
cl <- makeCluster(n_cores)
registerDoParallel(cl)

kk <- foreach(i=1:2, .combine=c) %dopar% {
    X <- rnorm(6000,6000)
    for (j in 1:5000000) {
        Y <- X%*%X
    }
    c(i)
}

stopCluster(cl)
