f <- function(xs) {    for (i in seq_along(xs)) {
        xs <- c(xs, xs[length(xs) - i + 1], xs[length(xs) - i + 1])
    }
    return(xs)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(4, 8, 8, 5)), c(4, 8, 8, 5, 5, 5, 5, 5, 5, 5, 5, 5))))
}
test_humaneval()
