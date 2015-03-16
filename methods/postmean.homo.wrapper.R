#define your methods in .R files like this one in the methods subdirectory
#each method should take arguments input and args, like the example
#the output should be a list of the appropriate "output" format (defined in the README)
library(EbayesThresh)
library(wavethresh)

#Make sure to add path to bin directory in matlab to R's path variable using add_path()
#Make sure to add path to methods folder in matlab!

#runs the Bayesian wavelet method with a spike and slab prior in matlab, assuming constant variance 
#inputs:
#input: a list containing x: the data, sig.true: the true sigma values, and sig.est: the estimated sigma values
#args: currently does not have any arguments
#
#returns the estimated (posterior mean) mean function
postmean.homo.wrapper = function(input,args){
  write(input$x,"data/ml_in.txt",ncolumns=length(input$x))
  system("matlab -nodisplay -nodesktop -r \"run('methods/postmean_matlab.m')\"")
  if(Sys.info()['sysname']=="Windows"){
    while (!file.exists("data/ml_out.csv")) {
      Sys.sleep(5)
    }
  }
  mu.est=as.vector(read.csv("data/ml_out.csv",header=FALSE))
  system("rm data/ml_in.txt data/ml_out.csv")
  return(mu.est)
}