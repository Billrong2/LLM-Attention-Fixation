f <- function(array, n) {    array[(n+1):length(array)]
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(0, 0, 1, 2, 2, 2, 2), 4), c(2, 2, 2))))
}
test_humaneval()
