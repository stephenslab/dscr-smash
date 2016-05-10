library(dscr)

dsc_smash = new_dsc("mean_function_estimation", "dscr-smash-output")
source("scenarios.R")
source("methods.R")
source("score.R")
res = run_dsc(dsc_smash)

save(res, file = "res.Robj")
save.image("res.RData")