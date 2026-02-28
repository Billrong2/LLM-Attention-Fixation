f <- function(a, b) {    a <- sort(a)
    b <- sort(b, decreasing = TRUE)
    return(c(a, b))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(666), c()), c(666))))
}
test_humaneval()
