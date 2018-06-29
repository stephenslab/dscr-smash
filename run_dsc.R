library(dscr)
library(AlgDesign)
library(EbayesThresh)
library(wavethresh)
library(smashr)

# SCRIPT PARAMETERS
# -----------------
# TO DO: Explain here what this is for.
matlab.exec <- "matlab -nodisplay -nodesktop"

# DEFINE THE DSC
# --------------
cat("Constructing DSC.\n")
dscr.path <- getwd()
dsc_smash <- new_dsc("mean_function_estimation","dscr-smash-output")
source("scenarios.R")
source("methods.R")
source("score.R")

# RUN THE DSC
# -----------
cat("Running DSC.\n")
timing <- system.time(res <- run_dsc(dsc_smash))
cat("Computation took %d seconds.\n",round(timing["elapsed"]))

# SAVE RESULTS TO FILE
# --------------------
# TO DO: Fix this.
cat("Saving DSC results to file.\n")
save(res,file = "res.Robj")
save.image("res.RData")
