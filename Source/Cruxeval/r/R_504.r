f <- function(values) {    values <- sort(values)
    values
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 1, 1, 1)), c(1, 1, 1, 1))))
}
test_humaneval()
