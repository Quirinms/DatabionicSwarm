UniquePoints = function(Datapoints, Eps = 1e-10){
  # 
  # V <- UniquePoints(Datapoints)
  # return only the unique points in Datapoints
  # 
  # DESCRIPTION
  # This function will return the set of unique points within an epsilon 
  # neighborhood.
  # 
  # INPUT
  # Datapoints[1:n,1:d]   [1:n,1:d] matrix of Datapoints points of dimension d
  #				                the points are in the  rows
  #
  # Eps                   Optional,scalarabove zero that defines minimum non-
  #                       identical euclidean distance between two points
  # 
  # OUTPUT
  # a list V containing:
  # Unique[1:k,1:d]        the Datapoints points  without duplicate points
  # IsDuplicate[1:n]       is the datapoint a unique or a doublet
  # (IsDuplicate[1:n,1:n]   for i!=j IsDuplicate[i,j]== 1  if Datapoints[i,] == Datapoints[j,]    IsDuplicate[i,i]==0)
  # UniqueInd[1:k]		     an index vector 1:k such that
  #                        Unique == Datapoints[UniqueInd,], it has k
  #                        non-consecutive numbers or labels, each label defines
  #                        a row number within Datapoints[1:n,1:d] of a unique
  #                        data point
  # Uniq2DatapointsInd[1:n]    an index vector 1:n. It has k unique index
  #                            numbers representing the arbitrary labels. Each
  #                            labels is mapped uniquely to a point in Unique.
  #                            Logically in a way such that
  #                            Datapoints == Unique[Uniq2DatapointsInd,]
  #                            (will not work directly in R this way) 
  #
  # Description: Euclidean distance is computed and used within. Setting 
  # \code{Eps} to a very small number results in the identification of unique
  # data points. Setting epsilon to a higher number results in the definition of
  # mesh points within an d-dimensional R-ball grap
  # 
  # DETAILS
  # Careful! This function is mathematically not uniquely defined! There can be
  # different outcomes if data is shuffled. This is due to the order of the
  # data, which determines the rank in distances, where the first occurence is
  # always regarded as the unique point, and the subsequent close neighbors are
  # doublets!
  # 
  # Algorithmic idea: MT 2022, Solved: QS 09/2023
  
  
  #if(inherits(Datapoints,"matrix")) {
  if(is.vector(Datapoints)) {
      # If Datapoints is a vector.
    Datapoints <- as.matrix(Datapoints)
  }
  
  N           = dim(Datapoints)[1]
  DM          = as.matrix(parallelDist::parDist(Datapoints))
  
  tmpVi        = hlp_UniquePoints(DM = DM, Datapoints = Datapoints, Eps = Eps)
  Unique       = tmpVi$Unique
  UniqueInd    = tmpVi$UniqueInd
  Uniq2DataIdx = tmpVi$Uniq2DatapointsInd
  IsDuplicate  = tmpVi$IsDuplicate
  Eps          = tmpVi$Eps
  # Edit
  NewUniqueInd    = 1:length(UniqueInd)
  NewUniq2DataIdx = unlist(lapply(Uniq2DataIdx, function(x, y){
    which(y == x)
  }, UniqueInd))
    
  return(list("Unique"             = Unique,
              "UniqueInd"          = UniqueInd,
              "Uniq2DatapointsInd" = Uniq2DataIdx,
              "NewUniqueInd"       = NewUniqueInd,
              "NewUniq2DataIdx"    = NewUniq2DataIdx,
              "IsDuplicate"        = IsDuplicate,
              "Eps"                = Eps))
}

hlp_UniquePoints = function(DM, Datapoints, Eps){
  N             = dim(Datapoints)[1]
  IsDuplicate   = rep(FALSE, N)
  Idx           = 1:N
  UniqueInd     = c()
  Uniq2DataIdx  = Idx
  
  while(length(Idx) > 0){                                                       # Proceed until no sample is left
    Draw                     = sample(x = Idx, size = 1)                        # Draw a sample
    # Ensure, that a draw is not by mistake already a unique representative or
    # contained in an eps ngbh
    Cond1       = !(Draw %in% UniqueInd)
    if(length(UniqueInd) > 0){
      #tmpVar1   = as.matrix(dist(rbind(Datapoints[Draw,], Datapoints[UniqueInd,])))[1,]
      #tmpVar2   = tmpVar1[2:length(tmpVar1)]
      tmpVar1   = as.matrix(DM[Draw, UniqueInd])
      tmpVar2   = tmpVar1[1:length(tmpVar1)]
      Cond2     = all(tmpVar2 >= Eps)
    }else{
      Cond2     = TRUE
    }
    if(all(Cond1, Cond2)){
      Ngbh      = get_indices_smaller_than_eps(Draw, DM, Eps)                   # Get eps ngbh of sample
      UniqueInd = c(UniqueInd, Draw)                                            # Add sample to unique index
      Idx       = setdiff(Idx, c(Draw, Ngbh))                                   # Remove draw with its ngbh from index  
    }else{
      Idx       = setdiff(Idx, Draw)
    }
  }
  
  UniqueInd = sort(UniqueInd)
  if(length(UniqueInd) != length(unique(UniqueInd))){
    warning("Something went wrong: There are redundant entries in the unique index!")
  }
  
  Duplicates               = setdiff(1:N, UniqueInd)
  NumDupl                  = length(Duplicates)
  tmpVar1                  = DM[Duplicates,UniqueInd]
  if(is.vector(tmpVar1) | !is.matrix(tmpVar1)){
    tmpRes                 = order(tmpVar1)[2]
  }else{
    tmpRes                 = apply(tmpVar1, 1, function(x){order(x)[2]})
  }
  
  Uniq2DataIdx[Duplicates] = UniqueInd[as.numeric(tmpRes)]
  Unique                   = Datapoints[UniqueInd,]
  IsDuplicate[Duplicates]  = TRUE
  
  return(list("Unique"             = Unique,
              "UniqueInd"          = UniqueInd,
              "Uniq2DatapointsInd" = Uniq2DataIdx,
              "IsDuplicate"        = IsDuplicate,
              "Eps"                = Eps))
}

get_indices_smaller_than_eps = function(Draw, DM, Eps){
  return(setdiff(as.numeric(which(DM[Draw,] < Eps)), Draw))
}

