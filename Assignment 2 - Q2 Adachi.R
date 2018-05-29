#Adachi for taxi drivers

p <- 10
N <- (p)^2

MaxT<-N^2
set.seed(0)

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
} #alpha
for (i in 1:N) {
  for (j in 1:N) {
    gamma[i,j]<--(euc.dist(g[i,],g[j,]))
  }
} #gamma
u<-matrix(-2,N,MaxT)
v<-matrix(-2,N,MaxT)

CI <-matrix(0,N,N)
CJ <-matrix(0,N,N)  #consideration sets
A <- matrix(0,N,N)
G <- matrix(0,N,N)
matching<-matrix(0,N,N)
CONT<-TRUE
t<-1

while ((CONT==TRUE) && (t<MaxT)) {
  print(t)
  for (i in 1:N) {
    CI[i,]<-(gamma[i,]>=v[,t])
  }
  for (i in 1:N) {
    for (j in 1:N) {
      if(CI[i,j]==1){A[i,j]<-alpha[i,j]}}
    u[i,t+1]<-max(A[i,])
  }
  for (j in 1:N) {
    CJ[,j]<-m[j]*(alpha[,j]>=u[,t+1])
  }
  for (j in 1:N) {
    for (i in 1:N) {
      if(CJ[i,j]==1){G[i,j]<-gamma[i,j]}}
    v[j,t+1]<-max(G[,j])
  }
  if((all(v[j,t+1]==v[j,t]))&&(all(u[j,t+1]==u[j,t]))) {CONT<-FALSE}
  else {
    t<-t+1
    A <- matrix(0,N,N)
    G <- matrix(0,N,N)
  }
}

matching<-CI*CJ
unmatched<-rep(1,N)-colSums(matching)
cbind(matching,unmatched)


