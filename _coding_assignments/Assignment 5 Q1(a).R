#Kelso & Crawford with a Cobb-Douglas
install.packages(rje)
require('rje')
require('Matrix')
require('gurobi')

M<-3 #workers
N<-2 #firms
MaxT<-2^(M+N)
I<-(1:M)
J<-(1:N)
Y<-matrix(0,2^M,N)
P<-matrix(0,N,M)
p = rep(1,N)
q = rep(1,M)
A1 = kronecker(matrix(1,1,2^M),sparseMatrix(1:N,1:N)) 
A2 = kronecker(sparseMatrix(1:M,1:M),matrix(1,1,N))
alpha <- -matrix(runif(N*M,0,1),N,M)
gamma <- matrix(runif(N*M,2,4),N,M) # U[1,2] to respect the MP assumption
sigma <- -alpha # starting at reservation wages
PS <- powerSetMat(M)
Y <- sqrt(PS %*% t((gamma)^2))
s<-sigma
t<-1

while((all(colSums(P)!=1)) && (t<MaxT)){
  print(t)
  S <- PS%*%t(s)
  Pi <- Y-S
  result_F = gurobi ( list(A=A1,obj=c(t(Pi)),modelsense="max",rhs=p,sense="="), params=list(OutputFlag=0) ) 
  O <- matrix(result_F$x,2^M,N,byrow=TRUE)
  for (j in J) {
    P[j,]<-PS[(which(O>0)[j]-(j-1)*(2^M)),]
  }
  result_W = gurobi ( list(A=A2,obj=c(alpha+s),modelsense="max",rhs=q,ub=P,sense="="), params=list(OutputFlag=0) ) 
  A <- matrix(result_W$x,N,M)
  for(j in J){for(i in I){
    if((A[j,i]==0) && (P[j,i]==1)){s[j,i]<-s[j,i]+1}
  }}
  t<-t+1
}

mu<-P*A
