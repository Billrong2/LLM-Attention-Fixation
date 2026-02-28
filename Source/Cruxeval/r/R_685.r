f <- function(array, elem) {    sum(array == elem) + elem
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 1, 1), -2), -2)))
}
test_humaneval()
