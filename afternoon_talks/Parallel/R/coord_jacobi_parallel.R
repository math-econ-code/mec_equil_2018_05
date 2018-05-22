rm(list=ls())
library(doParallel)

n_x <- 10
n_xx <- n_x^2
seq_vec <- seq(0.1,1.0,length.out=n_x)

n_vec <- rep(1,n_xx)

make_grid <- function(x) {
    n_x <- length(x)
    X <- matrix(0,n_x^2,2)
    X[,1] <- rep(x,n_x)
    X[,2] <- rep(x,1,each=n_x)
    return(X)
}

dist_fn <- function(X,Y) {
    return(sqrt(rowSums((X - matrix(Y,nrow=1)[rep(1,nrow(X)),])^2)))
}

XYZ_mat <- make_grid(seq_vec)

m_vec <- XYZ_mat[,1]*XYZ_mat[,2]

U_mat <- matrix(0,n_xx,n_xx)
C_mat <- matrix(0,n_xx,n_xx)

for (jj in 1:n_xx)
{
    U_mat[,jj] <- -10*(dist_fn(XYZ_mat,XYZ_mat[jj,]) >= (1/n_x - 1e-08))
    C_mat[,jj] <- dist_fn(XYZ_mat,XYZ_mat[jj,])^2
}

#

prices <- rep(0,n_xx)

#

demand_fn_j <- function(prices, U_mat, n_vec, jj) {
    n_xx <- nrow(U_mat)
    
    ret_val <- sum( n_vec * exp(U_mat[,jj] - prices[jj] ) / (1 + rowSums(exp(U_mat - t(prices)[rep(1,n_xx),] ))) )
    
    return(ret_val)
}

supply_fn_j <- function(prices, C_mat, m_vec, jj) {
    n_xx <- nrow(C_mat)
    
    ret_val <- sum( m_vec * exp(prices[jj] - C_mat[,jj]) / (1 + rowSums(exp(t(prices)[rep(1,n_xx),] - C_mat))) )
    
    return(ret_val)
}

root_fn <- function(price_j,prices,U_mat,C_mat,n_vec,m_vec,jj) {
    prices[jj] <- price_j
    return( - demand_fn_j(prices,U_mat,n_vec,jj) + supply_fn_j(prices,C_mat,m_vec,jj) )
}

#

max_iter <- 1000
err_val <- 1.0
err_tol <- 1e-08

prices_up <- prices

iter <- 0

n_cores <- 2

cl <- makeCluster(n_cores)
registerDoParallel(cl)

while(err_val > err_tol & iter < max_iter)
{
    iter <- iter + 1

    prices_up <- foreach(jj=1:n_xx, .combine=c) %dopar% {
        uniroot(root_fn,c(0,2),prices=prices,U_mat=U_mat,C_mat=C_mat,n_vec=n_vec,m_vec=m_vec,jj=jj)$root
    }
    
    prices_up <- matrix(c(prices_up))
    
    err_val <- max(abs(prices_up - prices)) / (1 + max(abs(prices)))
    
    prices <- prices_up
    
    cat('Iteration = ', iter,'. error = ', err_val,'\n',sep='')
}

stopCluster(cl)

matrix(prices,n_x,n_x)
