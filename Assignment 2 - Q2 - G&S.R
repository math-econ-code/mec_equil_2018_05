library('Matrix')
library('gurobi')

p <-3
N <- (p)^2

set.seed(0)
tiebreakersalpha<-0.01*matrix(runif(N^2),N,N)
tiebreakersgamma<-0.01*matrix(runif(N^2),N,N)
tiebreakersalpha[50,50]
tiebreakersgamma[50,50]

x <- (1/p)*matrix(1:p,p,p,byrow=FALSE)
y <- (1/p)*matrix(1:p,p,p,byrow=TRUE)
g <- matrix(c(x,y),nrow=N,ncol=2)
n <- rep(1,N)
m <- x*y
alpha <- matrix(0,N,N)
gamma <- matrix(1,N,N)
euc.dist <- function(x1, x2) sqrt(sum((x1 - x2) ^ 2))
for (i in 1:N) {
  for (j in 1:N) {
    alpha[i,j]<--(euc.dist(g[i,],g[j,]) >= 0.5)
  }
} 
for (i in 1:N) {
  for (j in 1:N) {
    gamma[i,j]<--(euc.dist(g[i,],g[j,]))
  }
} 

mu_A<-rep(1,N^2)
mu_P<-rep(0,N^2)
mu_E<-matrix(0,N^2)
A1 = kronecker(matrix(1,1,N),sparseMatrix(1:N,1:N)) 
result_P = gurobi ( list(A=A1,obj=c(alpha),modelsense="max",rhs=n,ub=c(mu_A),sense="="), params=list(OutputFlag=0) ) 
mu_P = result_P$x
result_E = gurobi ( list(A=A1,obj=c(gamma),modelsense="max",rhs=c(m),ub=c(mu_P),sense="="), params=list(OutputFlag=0) ) 
mu_E = result_E$x
mu_A = mu_A-(mu_P-mu_E)

matching<-matrix(c(mu_E),nrow=N,byrow=TRUE)
unmatched<-rep(1,N)-colSums(matching)

cbind(matching,unmatched)
