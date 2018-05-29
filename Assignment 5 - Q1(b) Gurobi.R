#Kelso and Crawford gurobi solution of the dual 
library('rje')

N<-2 #firms
M<-4 #workers
PS <- powerSetMat(M)
A1 = kronecker(matrix(1,2^M,1),sparseMatrix(1:N,1:N))
A2 = kronecker(PS,matrix(1,N,1)) 
A = cbind(A1,A2)
gamma <- matrix(runif(N*M,2,4),M,N)
Y <- sqrt(PS %*% (gamma)^2)
result = gurobi ( list(A=A,obj=rep(1,N+M),modelsense="min",rhs=c(Y),sense=">"), params=list(OutputFlag=0) ) 
L<-matrix(result$pi,nrow = N) 

#Convert the above result into a matching matrix 

m<-PS[which(L[1,]>0),]
for (i in 2:N) {
  m<-rbind(m,PS[which(L[i,]>0),])
}
m<-matrix(m,nrow = N)

