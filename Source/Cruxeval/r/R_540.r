f <- function(a) {    b <- c(a)
    for (k in seq(1, length(a) - 1, by = 2)) {
        b <- append(b, b[k], after = k)
    }
    b <- append(b, b[1])
    return(b)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(5, 5, 5, 6, 4, 9)), c(5, 5, 5, 5, 5, 5, 6, 4, 9, 5))))
}
test_humaneval()
