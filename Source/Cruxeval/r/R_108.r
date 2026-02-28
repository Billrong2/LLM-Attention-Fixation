f <- function(var) {    if (is.list(var)) {
        amount <- length(var)
    } else {
        amount <- 0
    }
    
    if (is.list(var)) {
        nonzero <- ifelse(length(var) > 0, length(var), 0)
    } else if (is.list(var)) {
        nonzero <- ifelse(length(names(var)) > 0, length(names(var)), 0)
    } else {
        nonzero <- 0
    }
    
    return(nonzero)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(1), 0)))
}
test_humaneval()
