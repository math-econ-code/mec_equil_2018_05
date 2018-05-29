library(nnet)

N<-10
M<-10
MaxT<-N*M
I<-(1:N)
J<-(1:M)
p = rep(1,N)
q = rep(1,M)
A1 = kronecker(matrix(1,1,M),sparseMatrix(1:N,1:N)) 
A2 = kronecker(sparseMatrix(1:M,1:M),matrix(1,1,N)) 
alpha<-matrix(runif(N*M,0,1),N,M)
gamma<-matrix(runif(N*M,0,1),M,N)

mu_A<-matrix(0,MaxT,N*M)
mu_A[1,]<-rep(1,N*M)
mu_P<-matrix(0,MaxT+1,N*M)
mu_E<-matrix(0,MaxT+1,N*M)
CONT<-TRUE
t<-1

while ((CONT==TRUE) && (t<MaxT)) {
    print(t)
    result_P = gurobi ( list(A=A1,obj=c(alpha),modelsense="max",rhs=p,ub=c(mu_A[t,]),sense="="), params=list(OutputFlag=0) ) 
    mu_P[t+1,] = result_P$x
    result_E = gurobi ( list(A=A2,obj=c(gamma),modelsense="max",rhs=q,ub=c(mu_P[t+1,]),sense="<="), params=list(OutputFlag=0) ) 
    mu_E[t+1,] = result_E$x
    mu_A[t+1,] = mu_A[t,]-(mu_P[t+1,]-mu_E[t+1,])
    if(all(mu_P[t+1,]==mu_E[t+1,])) {CONT<-FALSE}
    else {t<-t+1}
}

matching<-matrix(mu_E[t+1,],N,M,byrow=TRUE)
matching




