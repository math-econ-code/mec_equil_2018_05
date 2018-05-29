#Gale and Shapley on the taxi drivers exercise
#Hints: (1) Set an extra column for alpha with utility of outside option 
#(2) don't use tie breaking rule when the proposal has not been rejected at the previous period

library(nnet)
p <- 10
N <- (p)^2

set.seed(0)
tiebreakersalpha<-0.01*matrix(runif(N*(N+1)),N,N+1)
tiebreakersgamma<-0.01*matrix(runif(N*(N+1)),N,N+1)
tiebreakersalpha[50,50]
tiebreakersgamma[50,50]

x <- (1/p)*matrix(1:p,p,p,byrow=FALSE)
y <- (1/p)*matrix(1:p,p,p,byrow=TRUE)
g <- matrix(c(x,y),nrow=N,ncol=2)
n <- rep(1,N)
m <- x*y
alpha <- matrix(0,N,N+1)
gamma <- matrix(1,N,N)
euc.dist <- function(x1, x2) sqrt(sum((x1 - x2) ^ 2))
for (i in 1:N) {
  for (j in 1:N) {
    alpha[i,j]<--(euc.dist(g[i,],g[j,]) >= 0.5)
  }
} #alpha
alpha[,N+1]<--3
#Tie breaking alpha 
alpha <- alpha + tiebreakersalpha
for (i in 1:N) {
  for (j in 1:N) {
    gamma[i,j]<--(euc.dist(g[i,],g[j,]))
  }
} #gamma
P<-rep(0,N)
Q<-matrix(0,N,N) #Q is the inverse of P
E<-rep(0,N)
A<-matrix(1:N,N,N+1,byrow=TRUE)
t<-1
MAX_ITER<-N^2
CONT<-TRUE

while ((CONT==TRUE) && (t<MAX_ITER)) {
  print(t)
  for(i in 1:N){
    P[i]<-which.is.max(alpha[i,])} #each i proposes to his favorite j
  for (j in 1:N) {
    if(j %in% P){
      Q[j,1:length(which(P==j))]<-which(P==j) #j makes a list of her admirers
      E[j]<-Q[j,which.is.max(c(gamma[j,Q[j,]]))] #j chooses her favorite one from the list of admirers
    }
  }
  for (i in 1:N) {
    if((i %in% E)==FALSE){
      A[i,]<-replace(A[i,],A[i,]==P[i],0)
      alpha[i,P[i]]<-0
    }   #i deletes from this list the j's he proposed to and rejected him, and sets
    #utility of matching with them, alpha, as if it were equal to 0
  }
  if(all(E[P]==1:N)){CONT<-FALSE} #here's the fixed point condition if the algorithm has reached convergence
  Q<-matrix(0,N,N)              #equivalent to "each proposal is accepted". 
  t<-t+1
}

mu<-matrix(c(E,1:N),N,2)
colnames(mu)<-c("I","J")
mu


