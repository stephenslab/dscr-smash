sourceDir("datamakers")

library(AlgDesign)

meanfn=c("spikes","bumps","blocks","angles","doppler","blip","corner")
meanfn.short=c("sp","bump","blk","ang","dop","blip","cor")
rsnr=sqrt(c(1,3))
varfn=1:5

design=gen.factorial(c(length(varfn),length(rsnr),length(meanfn)),center=FALSE)

for(i in 1:dim(design)[1]){
  scenario.name=paste(meanfn.short[design[i,3]],rsnr[design[i,2]]^2,paste0("v",varfn[design[i,1]]),sep=".")
  scenario.args=list(n=1024,meanfn=meanfn[design[i,3]],varfn=varfn[design[i,1]],rsnr=rsnr[design[i,2]])
  addScenario(dsc_smash,name=scenario.name,fn=datamaker,args=scenario.args,seed=1:100)
}

#scenarios=list()
#scenarios[[1]]=list(name="sp.1.v1",fn=datamaker,args=list(n=1024,meanfn="spikes",varfn=1,rsnr=1),seed=1)