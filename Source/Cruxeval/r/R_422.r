f <- function(array) {    new_array <- rev(array)
    return (sapply(new_array, function(x) x*x))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 2, 1)), c(1, 4, 1))))
}
test_humaneval()
