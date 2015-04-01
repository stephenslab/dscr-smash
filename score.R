score = function(data, output){
  mise=10000*sum((output-data$meta$mu)^2)/sum(data$meta$mu^2)
  return(list(mise=mise))
  #return(10000*sum((output-data$meta$mu)^2)/sum(data$meta$mu^2))
}
addScore(dsc_smash,score,"mise")