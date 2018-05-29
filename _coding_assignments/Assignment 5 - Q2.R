#Hatfield and Milgrom 

require('rje')
require('Matrix')

M<-5 #workers
N<-3 #firms
MaxT<-2^(M+N)
Y<-matrix(0,2^M,N)
A<-matrix(1,N,2^M)
O<-matrix(0,N,M)
B <-matrix(1,N,M)
Ch<-rep(0,N)
Cd<-rep(0,M)
gamma <- matrix(runif(N*M,2,4),N,M)
alpha <- matrix(runif(N*M,0,1),N,M)
PS <- array(powerSetMat(M),dim=c(2^M,M,N))
Y <- t(sqrt(powerSetMat(M) %*% t((gamma)^2)))
t<-1
CONT<-TRUE

C <-function(X) which.max(X)
  
#voglio che R mi dia il vettore di tutti i contratti rifiutati da H 

while (CONT==TRUE) {
  print(t)
  for (i in 1:N) {
    Ch[i] <- C(t(sqrt(PS[,,i] %*% t((gamma)^2)))[i,])
    O[i,]<-PS[Ch[i],,i] 
  }
  for (j in 1:M){
    Cd[j] <- C((O*alpha)[,j])
    for (i in 1:N){
      B[i,j]<-(Cd[j]==i)
    }
  }
  if ({all(O==B)}) {CONT<-FALSE}
  else {
    for (i in 1:N){
      if(all(O[i,]==B[i,])==FALSE) {PS[Ch[i],,i]<-rep(0,M)}
      for (i in 1:N) {
        for (r in 1:2^M) { 
          for (j in 1:M) {
            if(Cd[j]==i && PS[r,j,i]==0 ){PS[r,,i]<-rep(0,M)}
          }
        }}
   t<-t+1}
}}

matching<-B
matching
