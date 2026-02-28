f <- function(array, elem) {   
    if (elem %in% array) {
        return(which(array == elem) - 1)
    }
    return(-1)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(6, 2, 7, 1), 6), 0)))
}
test_humaneval()
