rm(list=ls())

fn <- function(x) { 
    return(sum(x*x))
}

gn <- function(x) {
    return(2*x)
}

n <- 10

x0 <- rep(2,n)

res <- optim(x0,fn,gn,method="BFGS")
res
