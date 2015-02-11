score = function(data, output){
  return(10000*sum((output-data$meta$mu)^2)/sum(data$meta$mu^2))
}
