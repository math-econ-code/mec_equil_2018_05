library(nnet)

N<-10
M<-10
I<-(1:N)
J<-(1:M)
alpha<-matrix(runif(N*M,0,1),N,M)
gamma<-matrix(runif(N*M,0,1),M,N)
P<-rep(0,N)
Q<-matrix(0,M,N) #Q is the inverse of P
E<-rep(0,M)
A<-matrix(J,N,M,byrow=TRUE)
t<-1
MAX_ITER<-N^2
CONT<-TRUE

while ((CONT==TRUE) && (t<MAX_ITER)) {
  print(t)
  for(i in I){
    P[i]<-which.is.max(alpha[i,])} #each i proposes to his favorite j
  for (j in J) {
    if(j %in% P){
      Q[j,1:length(which(P==j))]<-which(P==j) #j makes a list of her admirers
      E[j]<-Q[j,which.is.max(c(gamma[j,Q[j,]]))] #j chooses her favorite one from the list of admirers
    }
  }
  for (i in I) {
    if((i %in% E)==FALSE){
      A[i,]<-replace(A[i,],A[i,]==P[i],0)
      alpha[i,P[i]]<-0
    }   #i deletes from this list the j's he proposed to and rejected him, and sets
        #utility of matching with them, alpha, as if it were equal to 0
  }
  if(all(E[P]==I)){CONT<-FALSE} #here's the fixed point condition if the algorithm has reached convergence
  Q<-matrix(0,M,N)              #equivalent to "each proposal is accepted". 
  t<-t+1
}

mu<-matrix(c(E,J),N,2)
colnames(mu)<-c("I","J")
mu

#Verification against black box matching package
install.packages("matchingR")
library(matchingR)
matching<-galeShapley.marriageMarket(t(alpha), t(gamma))
matching$engagements
