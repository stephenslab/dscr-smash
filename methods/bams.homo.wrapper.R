library(EbayesThresh)
library(wavethresh)

#Make sure to add path to bin directory in matlab to R's path variable using add_path()
#Make sure to add path to methods folder in matlab!


#runs the Bayesian wavelet denoising method BAMS in matlab, assuming constant variance 
#inputs:
#input: a list containing x: the data, sig.true: the true sigma values, and sig.est: the estimated sigma values
#args: currently does not have any arguments
#
#returns the estimated mean function
bams.homo.wrapper = function(input,args){
  write(input$x,"data/ml_in.txt",ncolumns=length(input$x))
  system("matlab -nodisplay -nodesktop -r \"run('methods/bams_matlab.m')\"")
  if(Sys.info()['sysname']=="Windows"){
    while (!file.exists("data/ml_out.csv")) {
      Sys.sleep(5)
    }
  }
  mu.est=as.vector(read.csv("data/ml_out.csv",header=FALSE))
  system("rm data/ml_in.txt data/ml_out.csv")
  return(mu.est)
}