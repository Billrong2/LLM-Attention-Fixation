f <- function(array, L) {    if (L <= 0) {
        return(array)
    }
    if (length(array) < L) {
        array <- c(array, f(array, L - length(array)))
    }
    return(array)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 2, 3), 4), c(1, 2, 3, 1, 2, 3))))
}
test_humaneval()
