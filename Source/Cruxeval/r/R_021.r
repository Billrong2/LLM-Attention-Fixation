f <- function(array) {    n <- tail(array, 1)
    array <- c(array[-length(array)], n, n)
    return(array)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 1, 2, 2)), c(1, 1, 2, 2, 2))))
}
test_humaneval()
