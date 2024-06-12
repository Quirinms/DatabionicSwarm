\name{Pswarm}
\alias{Pswarm}
\title{
A Swarm of Databots based on polar coordinates (Polar Swarm).
}
\description{
This projetion method is a part of the databionic swarm which uses the nash
equlibrium [Thrun/Ultsch, 2021]. Using polar coordinates for agents (here
Databots) in two dimensions has many advantages, for further details see
[Thrun, 2018] and [Thrun/Ultsch, 2021].
}
\usage{
Pswarm(DataOrDistance, Cls = NULL, QuadOrHexa = "Hexa", NumJumps = 4,
ColumnsLines = NULL, Parallel = FALSE, NCores = "max", Verbose = 1,
PlotIt = FALSE, Debug = FALSE, DistanceMeasure = "euclidean",
Eps = 0.001)
}
\arguments{
\item{DataOrDistance}{
Numeric matrix nxd. Two cases here: d=n  => assuming distance matrix d!=n =>
assuming data matrix with n cases and d features implying the need to compute
the distance matrix internally.
}
\item{Cls}{
Numeric vector [1:n] with class labels for each observation in DataOrDistance.
}
\item{QuadOrHexa}{
Optional, Boolean indicating the geometry of tiles the 2D projection plane is
built with.
}
\item{NumJumps}{
Integer indicating the number of jumps to be considered for each single databot
selected for jumping.
}
\item{ColumnsLines}{
Optional, grid size c(Columns, Lines), sometimes it is better to call
\code{\link{setGridSize}} separately.
}
\item{Parallel}{
Optional, Boolean: TRUE  = parallel execution, FALSE = single thread execution.
}
\item{NCores}{
Character or integer: choice of number of cores of CPU (in case). Can be 'max'
or a number. The max will always be 'all available cores - 1', to avoid core
overload.
}
\item{PlotIt}{
Optional, bool, default=FALSE, If =TRUE, Plots the projection during the
computation prozess after every nash equlibirum.
}
\item{Debug}{
Optional, Debug, default=FALSE, =TRUE results in various console messages,
depricated for CRAN, because cout is not allowed.
}
\item{DistanceMeasure}{
Optional, one of 39 distance methods of \code{parDist} of package parallelDist,
if Data matrix is chosen above
}
\item{Verbose}{optional, integer stating the degree of textual feedback. 0 = no
output, 1 = basic notifications, 2 = progress bar, 3 = details.}
\item{Eps}{optional, double: Stop criterion for convergence of each epoche.}
}
\details{
DBS is a flexible and robust clustering framework that consists of three
independent modules. The first module is the parameter-free projection method
Pswarm \code{\link{Pswarm}}, which exploits the concepts of self-organization
and emergence, game theory, swarm intelligence and symmetry considerations. The
second module is a parameter-free high-dimensional data visualization technique,
which generates projected points on a topographic map with hypsometric colors
\code{\link{GeneratePswarmVisualization}}, called the generalized U-matrix. The
third module is a clustering method with no sensitive parameters
\code{\link{DBSclustering}}. The clustering can be verified by the visualization
and vice versa. The term DBS refers to the method as a whole. 
}
\value{
List with
\item{ProjectedPoints}{
[1:n,1:2] xy cartesian coordinates of projection
}
\item{ColumnsLines}{
number of Columns and Lines in c(Columns,Lines)
}
\item{Control}{
List, only for intern debugging
}
}
\references{
[Thrun, 2018]  Thrun, M. C.: Projection Based Clustering through
Self-Organization and Swarm Intelligence, doctoral dissertation 2017, Springer,
Heidelberg, ISBN: 978-3-658-20539-3, \doi{10.1007/978-3-658-20540-9}, 2018. 

[Thrun/Ultsch, 2021]  Thrun, M. C., and Ultsch, A.: Swarm Intelligence for
Self-Organized Clustering, Artificial Intelligence, Vol. 290, pp. 103237,
\doi{10.1016/j.artint.2020.103237}, 2021.
}
\note{
ColumnsLines is now automatically estimated; ColumnsLines is the size of the grid c(Columns,Lines),
number of Columns and Lines, default c(NULL,NULL) and automatic calculation by
\code{\link{setGridSize}}.
}
\author{
Michael Thrun, Quirin Stier
}
\examples{
data("Lsun3D")
Data=Lsun3D$Data
Cls=Lsun3D$Cls
InputDistances=as.matrix(dist(Data))
#If not called separately setGridSize() is called in Pswarm
ColumnsLines=setGridSize(InputDistances)
\donttest{res=Pswarm(InputDistances,ColumnsLines=ColumnsLines,Cls=Cls,PlotIt=TRUE)}

\dontshow{
data=matrix(runif(n = 100),10,10)
distance=as.matrix(dist(data))
res1=Pswarm(DataOrDistance = distance, Parallel = FALSE, ColumnsLines = c(12,10))
res2=Pswarm(DataOrDistance = distance, Parallel = TRUE,  ColumnsLines = c(12,10))
}
}
\keyword{Clustering}
\keyword{Swarm}
\keyword{Swarms}
\keyword{Projection}
\keyword{Equilibrium}
\keyword{PSwarm}
\keyword{Visualization}
\keyword{Segregation}
\keyword{Databionic}
\keyword{Data-driven}
\concept{Machine Learning}
\concept{Swarm Intelligence}
\concept{Game Theory}
\concept{Projection Method}
\concept{Dimensionality Reduction}
\concept{Cluster Analysis}
\concept{Databionic Swarm}
\concept{Polar Swarm}
\concept{Visual Analytics}
\concept{Human in the Loop}
