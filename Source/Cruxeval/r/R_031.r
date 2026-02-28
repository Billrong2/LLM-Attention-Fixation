f <- function(string) {    upper <- 0
    for (c in strsplit(string, NULL)[[1]]) {
        if (grepl("[A-Z]", c)) {
            upper <- upper + 1
        }
    }
    return(upper * ifelse(upper %% 2 == 0, 2, 1))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('PoIOarTvpoead'), 8)))
}
test_humaneval()
