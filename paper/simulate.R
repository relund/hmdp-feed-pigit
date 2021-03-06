# R script file
# Author: Lars Relund, Reza Pourmoayed
# Description: Simulate the growth of pigs in a pen.  
# Generate one simulation for 3 pens with different genetic growth

# For user-defined folding in R Studio make sections by setting at least four trailing dashes (-), 
# equal signs (=), or pound signs (#) 
# Shortcuts Alt-L = collapse, Shift+Alt+L = Expand, Alt+0 = Collapse All, Shift+Alt+J = Jump To

#### Set parameters and growth ####
k4Values<-estimateK4() # Find k4 values given average daily gain over the whole period
feedMixDailyGains<-round(c(5.8/7, 6.3/7, 6.8/7),1) #round(c(4.4/7, 5.2/7, 6/7, 6.8/7),1)  # ave daily gain of each feed-mix
feedMixk4Values<-subset(k4Values, aveDG %in% feedMixDailyGains)$k4  # estimated k4 values for each feed-mix
#feedMixk4Values
#feedMixk4Values<-GrowthParam(W=30,G=feedMixDailyGains,K=5.3)  # estimated k4 values for each feed-mix
penDGFactor<-c(0.92,1.12,1.32) # genetic effect on DG in pen 1-3 (10% under/over)
#Function to add the information of t=0 (inserting time into pen) to the dataframes penWeeky.  
insertRow<-function(pen, penDaily){
  pen$week<-pen$week+1
  pen<-rbind(pen[1,],pen)
  pen[1]$t<-as.integer(0)
  pen[1]$aveOLWAll<-mean(penDaily[t==1]$OLW)
  pen[1]$aveTLWAll<-mean(penDaily[t==1]$TLW)
  pen[1]$sdOLWAll<-sd(penDaily[t==1]$OLW)
  pen[1]$aveFIAll<-sum(penDaily[t==1]$FI)/15*7
  pen[1]$week<-1   
  pen[1]$stage<-1    
  pen[1]$eAveOLWAll<-26.49
  pen[1]$eAveGAll<-5.8
  pen[1]$eSdOLWAll<-2.850987
  pen[1]$eVarOLWAll<-4.26
  pen[1]$eVarGAll<-0.53
  pen[1]$eCovAll<-0.32
  return(pen)
}

#### Low growth ####
#Initial parameters:
DFI<-0
pigIds<-1:(param$pigs)
finalDataAve<-list() # A list to gather the reduced data tables for avgWeight 
finalDataDaily<-list() # A list to gather the reduced data tables for daily weighta
i<-1 # A counter for the list finalData 
#k4Mean<-feedMixk4Values[2]
DGFactor<-penDGFactor[1]
TLW<- rnorm(length(pigIds),30,1)
phase<-1
startFeed<-0
feedMix<-1
PigsCull<-rep(0,length(pigIds))
#Loop to find the optimal decisions:
while( (DFI!=(param$tMax-1)*7) || (length(pigIds)>0) ){
   if(i==1){
      paramSim<-setSimParam(pen=1,k4Mean=feedMixk4Values,pigIds=pigIds, DGFactor=DGFactor)
      pen<-simulatePen(paramSim, feedMix=feedMix, TLW=TLW, DFI=DFI, T=(param$tMax-1)*7)
   }else{
      pen<-simulatePen(paramSim, feedMix=dat$feedMix, TLW=TLW, DFI=DFI, culled = PigsCull, T=(param$tMax-1)*7)
   }
   
   if(DFI==0){
      startT<-1
      m0<-matrix(data=c(26.49,5.8),nrow=2) 
      C0<-matrix(data=c(4.26,0.32,0.32,0.53),ncol=2) 
      var0<-8.128125
      phase<-1
      feedMix<-1
      startFeed<-0
   }else{
      startT<-DFI/7 +1
      m0<-dat$m0 
      C0<-dat$C0 
      var0<-dat$var0
      phase<-dat$phase
      feedMix<-dat$feedMix
      startFeed<-dat$startFeed
   }
   #dat<-pen$dtWeekAve   
   pen$dtWeekAve<-estimatePosterior(pen$dtWeekAve, m0, C0, var0, startT)
   pen<-findActions(pen, paramSim, param, policy, startT, phase, feedMix, startFeed)
   
   dat<-cutOff(pen, feedMix, m0, C0, var0, phase, startFeed, startT, PigsCull)
   
   finalDataAve[[i]]<-dat$pen$dtWeekAve
   finalDataDaily[[i]]<-dat$pen$dtDailyPig   
   i<-i+1
   
   tA<-dat$pen$dtWeekAve[,max(t)]
   DFI<-tA
   pigIds<-dat$pen$dtDailyPig[t==tA,pig]
   TLW<-dat$pen$dtDailyPig[t==tA,TLW]
   #k4Mean<-feedMixk4Values[dat$feedMix]
   PigsCull<-dat$PigsCull #PigsCull<-dat$pen$dtDailyPig[t==tA,culled]
   
   if ( (DFI==(param$tMax-1)*7) || all(PigsCull!=0) ) break
}
pen1Weekly<-rbindlist(finalDataAve) # a data table included the optimal decisions with the updated data for Ave information
pen1Weekly<-pen1Weekly[pen1Weekly$alive!=0]
pen1Daily<-rbindlist(finalDataDaily)  # a data table included the simulated data for daily information
pen1Weekly<-insertRow(pen1Weekly,pen1Daily)
pen1Weekly[,c(5:10,12:14,19:21):=NULL]
pen1Daily[,c(4:5,7,10):=NULL]
write.csv2(pen1Weekly,"pen1Weekly.csv", row.names = FALSE)
write.csv2(pen1Daily,"pen1Daily.csv", row.names = FALSE)

#### Normal/average growth ####
#Initial parameters:
DFI<-0
pigIds<-1:(param$pigs)
finalDataAve<-list() # A list to gather the reduced data tables for avgWeight 
finalDataDaily<-list() # A list to gather the reduced data tables for daily weighta
i<-1 # A counter for the list finalData 
#k4Mean<-feedMixk4Values[2]
DGFactor<-penDGFactor[2]
TLW<- rnorm(length(pigIds),30,1)
phase<-1
startFeed<-0
feedMix<-1
PigsCull<-rep(0,length(pigIds))
#Loop to find the optimal decisions:
while( (DFI!=(param$tMax-1)*7) || (length(pigIds)>0) ){
   if(i==1){
      paramSim<-setSimParam(pen=2,k4Mean=feedMixk4Values,pigIds=pigIds, DGFactor=DGFactor)
      pen<-simulatePen(paramSim, feedMix=feedMix, TLW=TLW, DFI=DFI, T=(param$tMax-1)*7)
   }else{
      pen<-simulatePen(paramSim, feedMix=dat$feedMix, TLW=TLW, DFI=DFI, culled = PigsCull, T=(param$tMax-1)*7)
   }
   
   if(DFI==0){
      startT<-1
      m0<-matrix(data=c(26.49,5.8),nrow=2) 
      C0<-matrix(data=c(4.26,0.32,0.32,0.53),ncol=2) 
      var0<-8.128125
      phase<-1
      feedMix<-1
      startFeed<-0
   }else{
      startT<-DFI/7 +1
      m0<-dat$m0 
      C0<-dat$C0 
      var0<-dat$var0
      phase<-dat$phase
      feedMix<-dat$feedMix
      startFeed<-dat$startFeed
   }
   #dat<-pen$dtWeekAve   
   pen$dtWeekAve<-estimatePosterior(pen$dtWeekAve, m0, C0, var0, startT)
   pen<-findActions(pen, paramSim, param, policy, startT, phase, feedMix, startFeed)
   
   dat<-cutOff(pen, feedMix, m0, C0, var0, phase, startFeed, startT, PigsCull)
   
   finalDataAve[[i]]<-dat$pen$dtWeekAve
   finalDataDaily[[i]]<-dat$pen$dtDailyPig   
   i<-i+1
   
   tA<-dat$pen$dtWeekAve[,max(t)]
   DFI<-tA
   pigIds<-dat$pen$dtDailyPig[t==tA,pig]
   TLW<-dat$pen$dtDailyPig[t==tA,TLW]
   #k4Mean<-feedMixk4Values[dat$feedMix]
   PigsCull<-dat$PigsCull #PigsCull<-dat$pen$dtDailyPig[t==tA,culled]
   
   if ( (DFI==(param$tMax-1)*7) || all(PigsCull!=0) ) break
}
pen2Weekly<-rbindlist(finalDataAve) # a data table included the optimal decisions with the updated data for Ave information
pen2Weekly<-pen2Weekly[pen2Weekly$alive!=0]
pen2Daily<-rbindlist(finalDataDaily)  # a data table included the simulated data for daily information
pen2Weekly<-insertRow(pen2Weekly,pen2Daily)
pen2Weekly[,c(5:10,12:14,19:21):=NULL]
pen2Daily[,c(4:5,7,10):=NULL]
write.csv2(pen2Weekly,"pen2Weekly.csv", row.names = FALSE)
write.csv2(pen2Daily,"pen2Daily.csv", row.names = FALSE)


#### High growth ####
#Initial parameters:
DFI<-0
pigIds<-1:(param$pigs)
finalDataAve<-list() # A list to gather the reduced data tables for avgWeight 
finalDataDaily<-list() # A list to gather the reduced data tables for daily weighta
i<-1 # A counter for the list finalData 
#k4Mean<-feedMixk4Values[2]
DGFactor<-penDGFactor[3]
TLW<- rnorm(length(pigIds),30,1)
phase<-1
startFeed<-0
feedMix<-1
PigsCull<-rep(0,length(pigIds))
#Loop to find the optimal decisions:
while( (DFI!=(param$tMax-1)*7) || (length(pigIds)>0) ){
   if(i==1){
      paramSim<-setSimParam(pen=3,k4Mean=feedMixk4Values,pigIds=pigIds, DGFactor=DGFactor)
      pen<-simulatePen(paramSim, feedMix=feedMix, TLW=TLW, DFI=DFI, T=(param$tMax-1)*7)
   }else{
      pen<-simulatePen(paramSim, feedMix=dat$feedMix, TLW=TLW, DFI=DFI, culled = PigsCull, T=(param$tMax-1)*7)
   }
   
   if(DFI==0){
      startT<-1
      m0<-matrix(data=c(26.49,5.8),nrow=2) 
      C0<-matrix(data=c(4.26,0.32,0.32,0.53),ncol=2) 
      var0<-8.128125
      phase<-1
      feedMix<-1
      startFeed<-0
   }else{
      startT<-DFI/7 +1
      m0<-dat$m0 
      C0<-dat$C0 
      var0<-dat$var0
      phase<-dat$phase
      feedMix<-dat$feedMix
      startFeed<-dat$startFeed
   }
   #dat<-pen$dtWeekAve   
   pen$dtWeekAve<-estimatePosterior(pen$dtWeekAve, m0, C0, var0, startT)
   pen<-findActions(pen, paramSim, param, policy, startT, phase, feedMix, startFeed)
   
   dat<-cutOff(pen, feedMix, m0, C0, var0, phase, startFeed, startT, PigsCull)
   
   finalDataAve[[i]]<-dat$pen$dtWeekAve
   finalDataDaily[[i]]<-dat$pen$dtDailyPig   
   i<-i+1
   
   tA<-dat$pen$dtWeekAve[,max(t)]
   DFI<-tA
   pigIds<-dat$pen$dtDailyPig[t==tA,pig]
   TLW<-dat$pen$dtDailyPig[t==tA,TLW]
   #k4Mean<-feedMixk4Values[dat$feedMix]
   PigsCull<-dat$PigsCull #PigsCull<-dat$pen$dtDailyPig[t==tA,culled]
   
   if ( (DFI==(param$tMax-1)*7) || all(PigsCull!=0) ) break
}
pen3Weekly<-rbindlist(finalDataAve) # a data table included the optimal decisions with the updated data for Ave information
pen3Weekly<-pen3Weekly[pen3Weekly$alive!=0]
pen3Daily<-rbindlist(finalDataDaily)  # a data table included the simulated data for daily information
pen3Weekly<-insertRow(pen3Weekly,pen3Daily)
pen3Weekly[,c(5:10,12:14,19:21):=NULL]
pen3Daily[,c(4:5,7,10):=NULL]
write.csv2(pen3Weekly,"pen3Weekly.csv", row.names = FALSE)
write.csv2(pen3Daily,"pen3Daily.csv", row.names = FALSE)

