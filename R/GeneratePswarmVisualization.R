GeneratePswarmVisualization=function(Data, ProjectedPoints, ColumnsLines, PlotIt=FALSE,
                                     ComputeInR=FALSE, Parallel=TRUE, Tiled = FALSE,
                                     DataPerEpoch = 1){
  # results=GeneratePswarmVisualization(Data,res$ProjectedPoints,res$ColumnsLines)
  # plotUmatrix(results$Umatrix,results$Bestmatches,Cls)
  # Generiert die ESOMneurons(wts) und die Umatrix (umx) fuer einen Schwarm
  # Ist der Spezialfall der generalisierten Umatrix, bei festem GridSize
  # INPUT 
  #  Data[1:n,1:d]
  #  ProjectedPoints[1:n,1:2]
  #  ColumnsLines                                       Grid size c(Lines,Columns) of Pswarm
  # OPTIONAL
  # PlotIt																			=T: plots, =F doesn plot
  # ComputeInR                                  =T: Rcode, =F Cpp Code
  # Output
  # BMUs[1:2,n]                             BestMatchingUnits
  # wts                                         ESOMneurons
  # umx                                         Umatrix
  # GridPoints                                ProjectedPoints on Grid
  # ColumnsLines										Sometimes is better to choose a different grid size, e.g. to to reduce computional effort
  #											contrary to SOM, here the grid size defined only the resolution of the visualizations
  #											It real grid size is predfined by Pswarm, but you may choose a factor x*res$ColumnsLines if you so desire.
  #											Therefore, The resulting grid size is given back here.
  # Author MT 03/16
  Data=checkInputDistancesOrData(Data,funname='GeneratePswarmVisualization')
  toroid = TRUE
  if(missing(ColumnsLines)){
    ColumnsLines=ceiling(apply(ProjectedPoints,2,max))+1
    if(Lines>Columns){
      ProjectedPoints=ProjectedPoints[,c(2,1)]
      ColumnsLines=ceiling(apply(ProjectedPoints,2,max))+1
    }
  }
  Lines=ColumnsLines[2]
  Columns=ColumnsLines[1]
    
  if(Lines>Columns){
    warning('Lines should not be bigger then Columns. Rotating Projected Points in a 90 degree angle.')
    Linestemp=Columns
    Columns=Lines
    Lines=Linestemp
    ProjectedPoints=ProjectedPoints[,c(2,1)]
    eps=4
  }
    
  #Der Standardalgorithmus funktioniert ohne Lines und Columns, und liefer nicht
  # immer exakt die Voreinstellung des Schwarmes an Lines/Columns
  Points=ProjectedPoints2Grid(ProjectedPoints,Lines,Columns)
  
  #Lines=ColumnsLines[1]
  #Columns=ColumnsLines[2]
  #############################################################################
  ##calcUmatrixToroid()
  ############################################################################
  calcUmatrixToroid <- function(EsomNeurons){
    # Umatrix=calcUmatrix(wts)
    # Calculate the Umatrix for given EsomNeurons projection
    # INPUT
    # EsomNeurons[Lines,Columns,weights]		neuronen aus EsomNeurons
    # OPTIONAL
    # Toroid				planar=F
    # OUTPUT
    # Umatrix[Lines,Columns]
    
    #############################################
    ## Nachbarn()
    nachbarn <- function(k, EsomNeurons){
      # INPUT
      # k Gitterpunkt
      # EsomNeurons[Lines,Columns,weights]
      # Toroid
      # OUTPUT
      # nb
      M <- dim(EsomNeurons)[1]
      N <- dim(EsomNeurons)[2]
      pos1 = c(k[1]-1,k[1]-1,k[1]-1,k[1],k[1],k[1]+1,k[1]+1,k[1]+1) %% M
      pos1[which(pos1==0)] = M
      pos2 = c(k[2]-1,k[2],k[2]+1,k[2]-1,k[2]+1,k[2]-1,k[2],k[2]+1) %% N
      pos2[which(pos2==0)] = N
      nb = cbind(pos1,pos2)
      return(nb)
    }
    ############################################
    k = dim(EsomNeurons)[1]
    m = dim(EsomNeurons)[2]
    Umatrix = matrix(0,k,m)
    
    d=dim(EsomNeurons)[3]
    if(is.null(d)){#wts als liste
      stop('EsomNeurons wts has to be an array[1:Lines,1:Columns,1:Weights], use ListAsEsomNeurons')
    }
    
    for(i in 1:k){
      for(j in 1:m){
        nbs=nachbarn(c(i,j),EsomNeurons)
        wij=EsomNeurons[i,j,]
        n.nbs=dim(nbs)[1]
        for(l in 1:n.nbs){
          nij=EsomNeurons[nbs[l,1],nbs[l,2],]
          Umatrix[i,j]=Umatrix[i,j]+sqrt(sum((wij-nij)^2))
        }	
        Umatrix[i,j]=Umatrix[i,j]/n.nbs
      }
    }
    return(Umatrix)
  }
  #########################################################################
  ##end calcUmatrixToroid
  #########################################################################
  rr=round(max(c(Columns,Lines))/10,0)
  
  if(rr<12){
    HeuristischerParameter=12
  }else{
    HeuristischerParameter=rr
  }
  #Nur eine Lineare Transformation
  n=nrow(Points)
  c=ncol(Points)
  if(c==2){
    BMUs=matrix(NaN,nrow=n,ncol=c)
    BMUs=Points[,c(2,1)]
  }else if(c==3){
    BMUs=matrix(NaN,nrow=n,ncol=(c-1))
    BMUs=Points[,c(3,2)]
  }else{
    stop('Error, wrong number of colums')
  }
  
  BMUs[,1]=max(BMUs[,1])-BMUs[,1]+1
  #fixes start: error: Cube::operator(): index out of bounds
  LCtest=apply(BMUs,2,max)
  if(LCtest[1]>Lines){
    BMUs=BMUs[,c(2,1)] #just rotate
  }
  #fixes end
  
  #BMUs=ProjectedPoints2Bestmatches(Points,Lines)
  
  # if(LCtest[1]>Lines){
  #   Lines=LCtest[1]
  #   warning('Maximum coordinate of BMU exceeds ColumnsLines[1]. Setting ColumnsLines[1] to max(BMU[,2])')
  # }
  # if(LCtest[2]>Columns){
  #   Columns=LCtest[2]
  #   warning('Maximum coordinate of BMU exceeds ColumnsLines[2]. Setting ColumnsLines[2] to max(BMU[,1])')
  # }
  
  DIM             = ncol(Data) #NumberOfweights
  SizeESOMWeights = DIM*Lines*Columns
  MinESOMWeights  = min(as.numeric(Data),na.rm = T) #besser als min(data) bis max(data)
  MaxESOMWeights  = max(as.numeric(Data),na.rm = T)
  rnd             = runif(n = SizeESOMWeights, min = MinESOMWeights, max = MaxESOMWeights)
  wts             = array(rnd, c(Lines, Columns, DIM)) #[Lines,Columns,weights]
  print('Initializing sESOM algorithm')
 
  # BestMatches werden festgehalten
  #for(i in c(1:nrow(BMUs))){
  #    wts[BMUs[i,1],BMUs[i,2],] = Data[i,]
  #}
  #Jeder Radius sollte min. 1 Eppoche durchlaufen werden, mehr als eine Eppoche fuehrte nicht zu mehr Emergenz
  # s. auch Experimente mit iUmatrix(), wo eine Umatrix als Video pro Eppoche bei diverser Parameterwahl gezeichnet wird
  epochs=HeuristischerParameter
  AnfangsRadius=HeuristischerParameter
  #epochs=20
  #AnfangsRadius=20
  #vec = pmax(seq(from=AnfangsRadius-1,by=-1,length.out = HeuristischerParameter),1)
  #for(i in vec){
  #  CurrentRadius =  i#max(AnfangsRadius-i,1) #Endradius=1
  #  #Algorithmus
  #  wts=sESOM4BMUs(BMUs,Data, wts, toroid=T, CurrentRadius, ComputeInR, Parallel=Parallel)
  #  print(paste0('Operator: getUmatrix4BMUs() at ',round(1-i/HeuristischerParameter,2)*100,'%'))
  #} # end 1:epochs
 
  Radii=pmax(seq(from=AnfangsRadius-1,by=-1,length.out = HeuristischerParameter),1)
  
  for(i in Radii){
    # Experimental: Use sampling for speed-up
    if(DataPerEpoch <1){
      NumberOfDatapoints = floor(nrow(Data)*DataPerEpoch)
      if(NumberOfDatapoints < 2){
        NumberOfDatapoints = 2
      }
      ind      = sample(1:nrow(Data),NumberOfDatapoints)
      DataTemp = Data[ind,]
      tmpBMUs  = BMUs[ind,]
    }else{
      DataTemp = Data
      tmpBMUs  = BMUs
    }
    CurrentRadius =  i # max(AnfangsRadius-i,1) #Endradius=1
    #Algorithmus
    wts = sESOM4BMUs(tmpBMUs, DataTemp, wts, toroid, CurrentRadius,
                     ComputeInR = ComputeInR, Parallel = Parallel)
    print(paste0('Operator: getUmatrix4BMUs() at ',round(1-(i/HeuristischerParameter),2)*100,'%'))
  }
  
  print('Calculating Umatrix')
  
  Umap  = calcUmatrixToroid(wts)
  LCnew = c(dim(wts)[1],dim(wts)[2])
  
  gplotres = FALSE
  
  if(isTRUE(PlotIt)){
    requireNamespace("GeneralizedUmatrix",quietly = TRUE)
    #GeneralizedUmatrix::plotTopographicMap(Umap,BMUs,NoLevels=10)
    Cls=rep(1,nrow(BMUs))
    gplotres=TopviewTopographicMap(GeneralizedUmatrix = Umap,BestMatchingUnits = BMUs,Cls = Cls,Tiled = Tiled,BmSize =8) #Sondern Gebirge=Unbekannte Orte der U-Matrix
    print(gplotres)
  }
  
  return(list("Bestmatches"      = BMUs,
              "Umatrix"          = Umap,
              "WeightsOfNeurons" = wts,
              "GridPoints"       = Points,
              "ColumnsLines"     = LCnew,
              "PlotlyHandle"     = gplotres))
}