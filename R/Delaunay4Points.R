Delaunay4Points <- function(Points, IsToroid = TRUE, ColumnsLines,PlotIt=FALSE,Gabriel=FALSE){
  # Delaunay=Delaunay4Points(Points, IsToroid,Grid,PlotIt)$Delaunay
  # Calculates the adjacency matrix of the delaunay graph for bestmatches in tiled form if BMs are located on a toroid grid
  #
  # INPUT
  # Points[1:n,1:3]            n by 3 matrix containing the BMKey, X and Y coordinates of the n Points
  #                                 Points NEED NOT BE UNIQUE!
  #                                 however, there is an edge in the Deaunay between duplicate points!  
  #
  # OPTIONAL
  # ColumnsLines[1:2]               A vector of length 2, containing the number of lines (y-points) and columns (x-points) of the Grid
  # IsToroid                        logical, indicating if BM's are on a toroid grid. Default is True
  # PlotIt                          Set PlotIt=TRUE, if you want to see the Plots
  # OUTPUT
  # DelaunayAdjazenzMatrix[1:n,1:n]  adjacency matrix of the Delaunay-Graph
  #
  # NOTE: Im Unterschied zu Delauany4Bestmatches hier in cartesischer Definition, Testweise auch Gabriel Graph moeglich
  # 	     Die Unterfunktionen wurden fuer diesen einen Zweck noch nachoptimiert  
  # authors:  MT 03/16
  

  if(is.list(Points)){
    stop('Points is a list not a matrix')
  }
  if(!(ncol(Points) %in% c(2,3))){
    stop('Points have wrong number of dimensions')
  }

  if(ncol(Points) == 3) {
    Points = Points[, 2:3]
    message("Delaunay4Points.R: Points have dimensions 3 and therefore it is assumed the first column carries keys and the 2nd and 3rd columns the 2d projected points!")
  }
  
  if(missing(ColumnsLines)){
    if(isTRUE(IsToroid)){
      message("Delaunay4Points.R: IsToroid is not applicable without parameter ColumnsLines defining the outline of the topographic grid.")
    }
    IsToroid = FALSE
  	if(isTRUE(Gabriel)){
  	  warning("Delaunay4Points.R: calcGabrielGraph2D requires input argument *ColumnsLines* - IsToroid is set to FALSE.")
  	}
  	else{
  	  warning("Delaunay4Points.R: As Input argument *ColumnsLines* is missing, IsToroid is set to FALSE.")
  	}
  }
  
  if(!missing(ColumnsLines)){
    Grid   = ColumnsLines
    tmpMax = apply(Points, 2, max)
    if(!all(tmpMax <= Grid)){
      stop("The projected points exceed their limits defined by ColumnsLines")
    }
  }else{
    if (IsToroid){
      stop('ColumnsLines has to be set, if toroid=TRUE')
    }
  }
  if (!missing(ColumnsLines)) {
    Xgrid = Grid[1]
    Ygrid = Grid[2]
  }
  
  
  
  if(IsToroid){
    if(floor(max(Points[, 1])) > floor(Grid[1])){
      stop('Grid[1]>max(Points[,1])')
    }
    if(round(max(Points[, 2])) > round(Grid[2])){
      stop('Grid[2]>max(Points[,2])')
    }
  }
  #####################################################################################
  DelaunayGraphMatrix_hlp <- function(X, Y, PlotIt = FALSE) {
    # D <- DelaunayGraphMatrix(X,Y,PlotIt)
    # Calculates the Adjacency Martix for a Delaunay-Graph
    # INPUT
    # X[1:n],  Y[1:n]         point coordinates for which a planar Delaunay graph is constucted
    #                         POINTS NEED NOT BE UNIQUE!
    #                         however, there is an edge in the Delaunay between duplicate points!
    # OPTIONAL
    # PlotIt                  if TRUE Delaunay graph is plotted
    #
    # OUTPUT
    # a list of
    # Delaunay[1:n,1:n]       The adjacency matrix of the Delaunay-Graph.
    #
    # uses packages deldir
    
    # Punkte unique machen
    unique           = UniquePoints(cbind(X, Y))
    UniqXY           = unique$Unique
    UniqueInd        = unique$UniqueInd
    Uniq2DataInd     = unique$Uniq2DatapointsInd
    Uniq2DataInd2    = unique$NewUniq2DataIdx
    IsDuplicate      = unique$IsDuplicate
    UniqX            = UniqXY[, 1]
    UniqY            = UniqXY[, 2]
    DeldirOutput     = deldir::deldir(UniqX , UniqY)                            # Delaunay ausrechnen mit deldir
    PointsAndIndices = DeldirOutput$delsgs                                      # dadrin stecken die indices des Delaunays von -> Nach
    FromInd          = PointsAndIndices$ind1                                    # indices der Ausgangspunkte des Delanays
    ToInd            = PointsAndIndices$ind2                                    # indices der Endpunkte des Delanays
    UniqDelaunay     = matrix(0, length(UniqX), length(UniqY))                  # Adjazenzmatrix initialisieren
    for (i in c(1:length(FromInd))) {
      UniqDelaunay[FromInd[i], ToInd[i]] = 1                                    # Only Direct neighbours A and B get an one from A to B
      UniqDelaunay[ToInd[i], FromInd[i]] = 1                                    # Only Direct neighbours A and B get an one from A to B
    } # end for i neighbours
    
    Delaunay = matrix(0, length(X), length(Y))
    Delaunay = UniqDelaunay[Uniq2DataInd2, Uniq2DataInd2]
    #Delaunay = Delaunay + diag(IsDuplicate)
    if(sum(IsDuplicate)>1){ #Verstehe ich nicht, aber bei genau einem duplikat funktioniert es nicht
      Duplicates = which(IsDuplicate)
      UniqueNgbh = unique$Uniq2DatapointsInd[which(IsDuplicate)]
      #diag(Delaunay[Duplicates,UniqueNgbh]) = 1
      Delaunay[Duplicates,UniqueNgbh] = 1
      Delaunay[UniqueNgbh,Duplicates] = 1
    }
    #erstmal fallback auf urspruengliche version
    if(sum(IsDuplicate)==1){
      Delaunay = Delaunay + diag(IsDuplicate)
    }
    
    #Delaunay[IsDuplicate, ]
    # jetzt uniqe points wieder auf originale uebertragen
    #Delaunay = matrix(0, length(X), length(Y))
    #Delaunay = UniqDelaunay[RightIdx, RightIdx]
    #Delaunay = UniqDelaunay[Uniq2DataInd, Uniq2DataInd]
    #Delaunay = Delaunay + IsDuplicate # noch je eine Verbindung zwischen den Doubletten eintragen
    #Delaunay = Delaunay + diag(IsDuplicate)
    
    # ausgabe zusammenstellen
    return(Delaunay = Delaunay)
  }# end function  DelaunayGraphMatrix
  ###############################################################################################
  ##############################################################################################
  if(IsToroid){
    # behandlung eines pack-man (toroiden) MapSpaces
    
    TiledX = Points[, 1]
    TiledY = Points[, 2]
    TiledX = c(TiledX, TiledX + Xgrid, TiledX + Xgrid, TiledX)
    TiledY = c(TiledY, TiledY, TiledY + Ygrid, TiledY + Ygrid)
    if(Gabriel){
      Delaunay = calcGabrielGraph2D(cbind(TiledX, TiledY), PlotIt = PlotIt)
      if(!is.matrix(Delaunay)){
        Delaunay = Delaunay[[1]]
      }
    }else{
      Delaunay = DelaunayGraphMatrix_hlp(TiledX, TiledY, PlotIt = PlotIt)
    }
    
    TiledDelaunay =  Delaunay
    n = nrow(Points)
    AnzBestMatches = nrow(Points)
    
    Offset = c(0, 1, 2, 3) * AnzBestMatches
    DelaunayAdjazenzMatrix = TiledDelaunay[c(1:AnzBestMatches), c(1:AnzBestMatches)]  # initialisieren mit dem oberen viertel
    for (i in Offset) {
      for (j in Offset) {
        DelaunayAdjazenzMatrix = DelaunayAdjazenzMatrix + TiledDelaunay[c(1:AnzBestMatches) +
                                                                          i, c(1:AnzBestMatches) + j]
      }# end for j
    }# end for i
    # zurueckrechnen auf die ungekachelten werte
    DelaunayAdjazenzMatrix = (DelaunayAdjazenzMatrix > 0) * 1  # alles auf 0/1 reduzieren
    # X=TiledX
    # Y=TiledY
    
  }else{
    # MapSpace ist planar
    
    X = Points[, 1]
    Y = Points[, 2]
    if (Gabriel) {
      Delaunay = calcGabrielGraph2D(cbind(X, Y), PlotIt = PlotIt)
    } else{
      Delaunay <- DelaunayGraphMatrix_hlp(X, Y, PlotIt)
    }
    DelaunayAdjazenzMatrix  = Delaunay
    #TiledDelaunay = DelaunayAdjazenzMatrix
  }# end if(IsToroid)
  
  # Ausgabe zusammenstellen
  return(DelaunayAdjazenzMatrix)
}# end function