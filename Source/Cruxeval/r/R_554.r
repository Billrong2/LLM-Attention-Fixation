f <- function(arr) {    rev(arr)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(2, 0, 1, 9999, 3, -5)), c(-5, 3, 9999, 1, 0, 2))))
}
test_humaneval()
