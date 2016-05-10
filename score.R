score = function(data, output) {
  # if(is.numeric(output)){
  mise = 10000 * sum((output - data$meta$mu)^2)/sum(data$meta$mu^2)
  # }else{ mise=NA }
  return(list(mise = mise))
  # return(10000*sum((output-data$meta$mu)^2)/sum(data$meta$mu^2))
}
add_score(dsc_smash, score, "mise") 