rm(list=ls())

set.seed(1988)

sigm <- function(x) 1/(1+exp(-x))

n <- 10000; k <- 10

X <- matrix(rnorm(n*k),n,k)
theta <- runif(k)

mu <- sigm(X%*%theta)

y <- numeric(n)
for(i in 1:n) {
    y[i] <- rbinom(1,1,mu[i])
}

fn <- function(x,y,X) {
    mu <- sigm(X%*%x)
    return(-sum( y*log(mu) + (1-y)*log(1-mu) ))
}

gn <- function(x,y,X) {
    mu <- sigm(X%*%x)
    return( t(X) %*%(mu - y) )
}

x0 <- rep(2,k)
res <- optim(x0,fn,gn,y=y,X=X,method="BFGS")
res
