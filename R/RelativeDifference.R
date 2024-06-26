RelativeDifference=function(X,Y,epsilon=10^-10,na.rm=FALSE){
  if(isTRUE(na.rm)){ #achtung irgendwas stimmt hier nicht
    noNaNInd <- which(is.finite(X)&is.finite(Y))
    X <- X[noNaNInd]
    Y <- Y[noNaNInd]
  }
  if(length(X)!=length(Y)) stop('Length of X and Y do not match.')
  if(length(X)>1) return(mapply(X,FUN = RelativeDifference,Y))
  oben=Y-X
  unten=X+Y
  if(!is.finite(unten)) stop('Some of your values are not finite. Please use na.rm=TRUE')
  if(abs(unten)<epsilon){
    warning('X and Y are too small to calcualte Relative Differences. Returning 0')
    return(0)
  }
  if(X<0) stop('Not defined for negative X values')
  if(Y<0) stop('Not defined for negative Y values')
  return(2*oben/unten)
}
