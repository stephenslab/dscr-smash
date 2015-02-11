#define your methods in .R files like this one in the methods subdirectory
#each method should take arguments input and args, like the example
#the output should be a list of the appropriate "output" format (defined in the README)
library(EbayesThresh)
library(wavethresh)

#performs naive elastic net with K-fold CV using package "elasticnet"
#inputs:
#input: a matrix with the first column being the y values
#args: a list with elements "nfolds" for the number of folds used in CV, and "lambda" for the grid of lambda values used for one of the dimensions in two-fold CV
#
#returns the estimated coefficients beta
ebayesthresh.wrapper = function(input,args){
  if(is.null(args$filter.number))
    args$filter.number=10
  if(is.null(args$family))
    args$family="DaubLeAsymm"
  if(is.null(args$min.level))
    args$min.level=3

  n=length(input$x)
  J=log2(n)
  x.w <- wd(input$x, args$filter.number, args$family, type = "station")
  for(j in args$min.level:(J-1)){
    x.pm = ebayesthresh(accessD(x.w,j),sdev=input$sig.est)
    x.w = putD(x.w,j,x.pm)
  }
  mu.est=AvBasis(convert(x.w))
  return(mu.est)
}