f <- function(m) {    rev(m)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(-4, 6, 0, 4, -7, 2, -1)), c(-1, 2, -7, 4, 0, 6, -4))))
}
test_humaneval()
