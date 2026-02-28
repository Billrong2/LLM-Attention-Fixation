f <- function(d, count) {    for (i in 1:count) {
        if (length(d) == 0) {
            break
        }
        d <- head(d, -1)
    }
    return(d)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list(), 200), list())))
}
test_humaneval()
