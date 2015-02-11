#define your datamaker functions in .R files in the datamaker subdirectory
#each datamaker should take input seed (integer) and args (list), and output a list with names elements meta and input
#the format of the meta and input elements should be defined in the README



datamaker = function(seed,args){

  n=args$n
  meanfn=args$meanfn
  varfn=args$varfn
  rsnr=args$rsnr
  
  t=1:n/n
  
  if(meanfn=="spikes"){
    spike.f=function(x) (0.75*exp(-500*(x-0.23)^2)+1.5*exp(-2000*(x-0.33)^2)+3*exp(-8000*(x-0.47)^2)+2.25*exp(-16000*(x-0.69)^2)+0.5*exp(-32000*(x-0.83)^2))
    mu.s=spike.f(t)
    mu=(1+mu.s)/5
  }else if(meanfn=="bumps"){
    pos = c(.1, .13, .15, .23, .25, .40, .44, .65, .76, .78, .81)
    hgt = 2.97/5*c(4, 5, 3, 4, 5, 4.2, 2.1, 4.3, 3.1, 5.1, 4.2)
    wth = c(.005, .005, .006, .01, .01, .03, .01, .01, .005, .008, .005)
    mu.b = rep(0,n)
    for(j in 1:length(pos)){
      mu.b = mu.b + hgt[j]/(( 1 + (abs(t - pos[j])/wth[j]))^4)
    }
    mu=(1+mu.b)/5
  }else if(meanfn=="blocks"){
    pos=c(.1, .13, .15, .23, .25, .40, .44, .65, .76, .78, .81)
    hgt = 2.88/5*c(4, (-5), 3, (-4), 5, (-4.2), 2.1, 4.3, (-3.1), 2.1, (-4.2))
    mu.blk = rep(0,n)
    for(j in 1:length(pos)){
      mu.blk = mu.blk + (1 + sign(t-pos[j]))*(hgt[j]/2)
    }
    mu=0.2+0.6*(mu.blk-min(mu.blk))/max(mu.blk-min(mu.blk))
  }else if(meanfn=="angles"){
    sig=((2*t + 0.5)*(t <= 0.15)) + 
      ((-12*(t-0.15) + 0.8)*(t > 0.15 & t <= 0.2)) + 
      0.2*(t > 0.2 & t <= 0.5) + 
      ((6*(t - 0.5) + 0.2)*(t > 0.5 & t <= 0.6)) + 
      ((-10*(t - 0.6) + 0.8)*(t > 0.6 & t <= 0.65)) + 
      ((-0.5*(t - 0.65) + 0.3)*(t > 0.65 & t <= 0.85)) + 
      ((2*(t - 0.85) + 0.2)*(t > 0.85))
    mu.ang = 3/5*((5/(max(sig)-min(sig)))*sig - 1.6)-0.0419569
    mu=(1+mu.ang)/5
  }else if(meanfn=="doppler"){
    dop.f=function(x) sqrt(x*(1-x))*sin((2*pi*1.05)/(x+0.05))
    mu.dop=dop.f(t)
    mu.dop=3/(max(mu.dop)-min(mu.dop))*(mu.dop-min(mu.dop))
    mu=(1+mu.dop)/5
  }else if(meanfn=="blip"){
    mu=(0.32+0.6*t+0.3*exp(-100*(t-0.3)^2))*(t>=0&t<=0.8)+(-0.28+0.6*t+0.3*exp(-100*(t-1.3)^2))*(t>0.8&t<=1)
  }else if(meanfn=="corner"){
    mu.cor=623.87*t^3*(1-2*t)*(t>=0&t<=0.5)+187.161*(0.125-t^3)*t^4*(t>0.5&t<=0.8)+3708.470441*(t-1)^3*(t>0.8&t<=1)
    mu.cor=(0.6/(max(mu.cor)-min(mu.cor)))*mu.cor
    mu=mu.cor-min(mu.cor)+0.2
  }else{
    stop("Error: mean function not recognized")
  }
  
  if(varfn==1){
    sigma=sqrt(rep(1,n))
  }else if(varfn==2){
    sigma=sqrt(0.0001+4*(exp(-550*(t-0.2)^2)+exp(-200*(t-0.5)^2)+exp(-950*(t-0.8)^2)))
  }else if(varfn==3){
    dop.f=function(x) sqrt(x*(1-x))*sin((2*pi*1.05)/(x+0.05))
    var.dop=10*dop.f(t)
    var.dop=var.dop-min(var.dop)
    sigma=sqrt(0.00001+2*var.dop)
  }else if(varfn==4){
    pos = c(.1, .13, .15, .23, .25, .40, .44, .65, .76, .78, .81)
    hgt = 2.97/5*c(4, 5, 3, 4, 5, 4.2, 2.1, 4.3, 3.1, 5.1, 4.2)
    wth = c(.005, .005, .006, .01, .01, .03, .01, .01, .005, .008, .005)
    var.b = rep(0,n)
    for(j in 1:length(pos)){
      var.b = var.b + hgt[j]/(( 1 + (abs(t - pos[j])/wth[j]))^4)
    }
    sigma=sqrt(0.00001+var.b)
  }else if(varfn==5){
    pos=c(.1, .13, .15, .23, .25, .40, .44, .65, .76, .78, .81)
    hgt = 2.88/5*c(4, (-5), 3, (-4), 5, (-4.2), 2.1, 4.3, (-3.1), 2.1, (-4.2))
    var.cblk = rep(0,n)
    for(j in 1:length(pos)){
      var.cblk = var.cblk + (1 + sign(t-pos[j]))*(hgt[j]/2)
    }
    var.cblk[var.cblk<0]=0
    sigma=sqrt(0.00001+1*(var.cblk-min(var.cblk))/max(var.cblk))
  }else{
    stop("Error: variance function not recognized")
  }
  
  sig.true=sigma/mean(sigma)*sd(mu)/rsnr^2
  x.data=rnorm(n,mu,sig.true)
  sig.est=sqrt(2/(3*(n-2))*sum((1/2*x.data[1:(n-2)]-x.data[2:(n-1)]+1/2*x.data[3:n])^2))
  
  meta=list(mu=mu)
  
  input=list(x=x.data,sig.true=sig.true,sig.est=sig.est)

  data = list(meta=meta,input=input)
  
  return(data)
}
