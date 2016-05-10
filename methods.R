sourceDir("methods")

# methods=list()
# 
# methods[[1]] = list(name="ebayesthresh",fn=ebayesthresh.wrapper,args=list())
# methods[[2]] = list(name="bams.homo.s8",fn=bams.homo.wrapper,args=list())
# methods[[3]] = list(name="blockjs.homo.s8",fn=blockjs.homo.wrapper,args=list())
# methods[[4]] = list(name="neighblock.homo.s8",fn=neighblock.homo.wrapper,args=list())
# methods[[5]] = list(name="sure.homo.s8",fn=sure.homo.wrapper,args=list())
# methods[[6]] = list(name="postmean.homo.s8",fn=postmean.homo.wrapper,args=list())
# methods[[7]] = list(name="tithresh.homo.s8",fn=tithresh.homo.wrapper,args=list())
# methods[[8]] = list(name="smash.homo.haar",fn=smash.homo.wrapper,args=list(filter.number=1,family="DaubExPhase"))
# methods[[9]] = list(name="smash.homo.s8",fn=smash.homo.wrapper,args=list(filter.number=8,family="DaubLeAsymm"))
# methods[[10]] = list(name="smash.haar",fn=smash.wrapper,args=list(filter.number=1,family="DaubExPhase"))
# methods[[11]] = list(name="smash.s8",fn=smash.wrapper,args=list(filter.number=8,family="DaubLeAsymm"))
# methods[[12]] = list(name="smash.jash",fn=smash.jash.wrapper,args=list(filter.number=8,family="DaubLeAsymm"))
# methods[[13]] = list(name="tithresh.rmad.haar",fn=tithresh.wrapper,args=list(method="rmad",filter.number=1,family="DaubExPhase"))
# methods[[14]] = list(name="tithresh.rmad.s8",fn=tithresh.wrapper,args=list(method="rmad",filter.number=8,family="DaubLeAsymm"))
# methods[[15]] = list(name="tithresh.smash.haar",fn=tithresh.wrapper,args=list(method="smash",filter.number=1,family="DaubExPhase"))
# methods[[16]] = list(name="tithresh.smash.s8",fn=tithresh.wrapper,args=list(method="smash",filter.number=8,family="DaubLeAsymm"))
# methods[[17]] = list(name="smash.true.haar",fn=smash.true.wrapper,args=list(filter.number=1,family="DaubExPhase"))
# methods[[18]] = list(name="smash.true.s8",fn=smash.true.wrapper,args=list(filter.number=8,family="DaubLeAsymm"))
# methods[[19]] = list(name="tithresh.true.haar",fn=tithresh.true.wrapper,args=list(filter.number=1,family="DaubExPhase"))
# methods[[20]] = list(name="tithresh.true.s8",fn=tithresh.true.wrapper,args=list(filter.number=8,family="DaubLeAsymm"))

parse.period.delimited.name <- function(name) {
    return(strsplit(name, ".", fixed = TRUE)[[1]])
}

build.period.delimited.name <- function(words) {
    return(paste(words, collapse = "."))
}

suffix <- function(name) {
    words <- parse.period.delimited.name(name)
    return(words[length(words)])
}

remove.suffix <- function(name) {
    words <- parse.period.delimited.name(name)
    return(build.period.delimited.name(words[1:(length(words) - 1)]))
}

fxn.wrapper <- function(name, named.method) {
    if ((suffix(name) == "s8") || (suffix(name) == "haar")) {
        if (named.method) {
            stem <- remove.suffix(remove.suffix(name))
        } else {
            stem <- remove.suffix(name)
        }
    } else {
        stem <- name
    }
    return(parse(text = paste(stem, "wrapper", sep = ".")))
}

arg.list <- function(name, named.method, blank.arglist) {
    args <- list()

    if (!blank.arglist) {
        if (named.method) {
            args$method <- suffix(remove.suffix(name))
        }

        if (suffix(name) == "haar") {
            args$filter.number <- 1
            args$family <- "DaubExPhase"
        } else {
            # This covers a suffix of "s8" but also the case
            # "smash.jash"
            args$filter.number <- 8
            args$family <- "DaubLeAsymm"
        }
    }

    return(args)
}

add.method.by.flags <- function(row) {
    method.name <- as.character(row$name)
    
    add_method(dsc_smash,
              name = method.name,
              fn = eval(fxn.wrapper(method.name, row$named.method)),
              args = arg.list(method.name, row$named.method, row$blank.arglist))
}

# Define methods and flags used to name the function wrappers and
# argument lists. The first seven of this list use a blank argument
# list. The tithresh.rmad and tithresh.smash methods put the
# penultimate word in the argument list instead of using separate
# wrappers.

methods <- data.frame(list(name = c("ebayesthresh",
                                    "bams.homo.s8",
                                    "blockjs.homo.s8",
                                    "neighblock.homo.s8",
                                    "sure.homo.s8",
                                    "postmean.homo.s8",
                                    "tithresh.homo.s8",
                                    "smash.homo.haar",
                                    "smash.homo.s8",
                                    "smash.haar",
                                    "smash.s8",
                                    "smash.jash",
                                    "tithresh.rmad.haar",
                                    "tithresh.rmad.s8",
                                    "tithresh.smash.haar",
                                    "tithresh.smash.s8",
                                    "smash.true.haar",
                                    "smash.true.s8",
                                    "tithresh.true.haar",
                                    "tithresh.true.s8")))

methods$named.method = FALSE
methods$named.method[13:16] = TRUE

methods$blank.arglist = FALSE
methods$blank.arglist[1:7] = TRUE

# Add the methods to the DSC
by(methods, 1:nrow(methods), add.method.by.flags)
