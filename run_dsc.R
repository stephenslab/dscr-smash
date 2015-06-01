library(dscr)

setwd("~/dscr-smash")

dsc_smash = new.dsc("mean_function_estimation", "~/dscr-smash")
source("scenarios.R")
source("methods.R")
source("score.R")
res = run_dsc(dsc_smash)

save(res, file = "res.Robj")
save.image("res.RData")