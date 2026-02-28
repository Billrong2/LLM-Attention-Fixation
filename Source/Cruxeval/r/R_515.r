f <- function(array) {
    result <- rev(array)
    result <- result * 2
    return(result)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 2, 3, 4, 5)), c(10, 8, 6, 4, 2))))
}
test_humaneval()
