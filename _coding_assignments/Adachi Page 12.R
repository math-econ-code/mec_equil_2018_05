require('Matrix')
require('gurobi')

N<-10
M<-10
MaxT<-N*M
I<-(1:N)
J<-(1:M)
pI<-matrix(0,N,MaxT)
pJ<-matrix(0,M,MaxT)
kappa <- -matrix(runif(N*M,0,1),N,M)
gamma <- matrix(runif(N*M,0,1),M,N)
CI <-matrix(0,N,M)
CJ <-matrix(0,M,N)  #consideration sets
A <- matrix(0,N,M)
G <- matrix(0,N,M)
matching<-matrix(0,N,M)
CONT<-TRUE
#Initial guess 
pJ[,1]<-0
t <- 1

while ((CONT==TRUE) && (t<MaxT)) {
  print(t)
  for (i in I) {
    CI[i,]<-(gamma[i,]>=pJ[,t])
  }
  for (i in I) {
    for (j in J) {
      if(CI[i,j]==1){A[i,j] <- kappa[i,j]}}
    pI[i,t+1]<-min(A[i,])
  }
  for (j in J) {
    CJ[,j]<-(kappa[,j]<=pI[,t+1])
  }
  for (j in J) {
    for (i in I) {
      if(CJ[i,j]==1){G[i,j]<-gamma[i,j]}}
    pJ[j,t+1]<-max(G[,j])
  }
  if(all(colSums(CI*CJ)==1)){CONT <- FALSE}
  else {
    t<-t+1
    A <- matrix(0,N,M)
    G <- matrix(0,N,M)
  }
}

for (i in I) {
  for (j in J) {
    if (CI[i,j]==1 && CJ[i,j]==1) { 
      matching[i,j] = 1}
  }
}

matching
