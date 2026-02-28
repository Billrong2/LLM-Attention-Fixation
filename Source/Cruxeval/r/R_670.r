f <- function(a, b) {
    d <- setNames(b, a)
    a <- sort(a, decreasing = TRUE, function(x) d[[x]])
    unlist(lapply(a, function(x) d[[x]]))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('12', 'ab'), c(2, 2)), c(2, 2))))
}
test_humaneval()
