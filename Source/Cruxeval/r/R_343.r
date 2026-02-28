f <- function(array, elem) {    c(array, elem)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list(c(1, 2, 3), c(1, 2), 1), list(c(1, 2, 3), 3, c(2, 1))), list(c(1, 2, 3), c(1, 2), 1, c(1, 2, 3), 3, c(2, 1)))))
}
test_humaneval()
