\name{coord_jacobi}

\alias{coord_jacobi}

\title{Coordinate Descent}

\description{
    Coordinate descent (Jacobi).
}

\usage{
coord_jacobi(n_x, bounds=c(0,1), err_tol=1E-08, max_iter=1000)
}

\arguments{
	\item{n_x}{
	Number of grid points.}
    \item{bounds}{
    Upper and lower bounds for the root finder.}
    \item{err_tol}{
    Algorithm tolerance.}
    \item{max_iter}{
    Maximum number of iterations.}
}

\details{
    See homework question.
}

\value{
Returns a vector of prices.
}

\author{Keith O'Hara}

\examples{
\dontrun{
coord_jacobi(10)
}
}

\keyword{coord_jacobi}
\concept{coord_jacobi}