f <- function(s, sep) {    reverse <- sapply(strsplit(s, split = sep)[[1]], function(e) paste0("*", e))
    return(paste0(paste0(rev(reverse), collapse = ";"), collapse = ""))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('volume', 'l'), '*ume;*vo')))
}
test_humaneval()
