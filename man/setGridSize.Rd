\name{setGridSize}
\alias{setGridSize}

\title{
 Sets the grid size for the Pswarm algorithm
}
\description{
Automatically sets the size of the grid, formula see [Thrun, 2018, p. 93-94].
}
\usage{
setGridSize(InputDistances,minp=0.01,maxp=0.99,alpha=4, Verbose = 0)
}

\arguments{
\item{InputDistances}{ [1:n,1:n] symmetric matrix of input distances}
\item{minp}{default value: 0.01,see \code{\link{quantile}}, first value in the vector of \code{probs} estimates robust minimum of distances}
\item{maxp}{default value: 0.99, see \code{\link{quantile}}, last value of the vector of \code{probs} estimates robust maximum of distances}
\item{alpha}{
Do not change! Intern parameter, Only if Java Version of Pswarm instead of C++ version is used.
}
\item{Verbose}{
optional, integer stating degree of textual feedback. 0 = no output, 1 = basic
notifications, 2 = progress bar, 3 = details.
}
}
\details{
grid is set such that minimum and maximum distances can be shown on the grid}
\value{
ColumnsLines=c(Columns, Lines) size of the grid for \code{Pswarm}
}
\references{
[Thrun, 2018]  Thrun, M. C.: Projection Based Clustering through Self-Organization and Swarm Intelligence, doctoral dissertation 2017, Springer, Heidelberg, ISBN: 978-3-658-20539-3, \doi{10.1007/978-3-658-20540-9}, 2018. 
}
\author{
Michael Thrun, Florian Lerch
}
\examples{
data("Lsun3D")
Data=Lsun3D$Data
Cls=Lsun3D$Cls
InputDistances=as.matrix(dist(Data))
#If not called separately setGridSize() is called in Pswarm
ColumnsLines=setGridSize(InputDistances)
}
\seealso{
automatic choice of ColumnsLines for \code{\link{Pswarm}}
}