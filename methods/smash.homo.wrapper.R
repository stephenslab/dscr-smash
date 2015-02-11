#define your methods in .R files like this one in the methods subdirectory
#each method should take arguments input and args, like the example
#the output should be a list of the appropriate "output" format (defined in the README)
library(smash)

#performs naive elastic net with K-fold CV using package "elasticnet"
#inputs:
#input: a matrix with the first column being the y values
#args: a list with elements "nfolds" for the number of folds used in CV, and "lambda" for the grid of lambda values used for one of the dimensions in two-fold CV
#
#returns the estimated coefficients beta
smash.homo.wrapper = function(input,args){
    mu.est=ashsmooth.gaus(input$x,input$sig.est,filter.number=args$filter.number,family=args$family)
    return(mu.est)
}