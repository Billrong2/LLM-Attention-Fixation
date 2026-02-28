f <- function(arr) {    count <- length(arr)
    sub <- arr
    for (i in seq(1, count, by=2)) {
        sub[i] <- sub[i] * 5
    }
    sub
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(-3, -6, 2, 7)), c(-15, -6, 10, 7))))
}
test_humaneval()
