f <- function(L, m, start, step) {
    L <- append(L, m, after = start)
    index <- which(L == m)
    for (i in seq(start-1, 1, -step)) {
        L <- append(L, L[index-1], after = i)
        L <- L[-index]
        index <- which(L == m)
    }
    return(L)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 2, 7, 9), 3, 3, 2), c(1, 2, 7, 3, 9))))
}
test_humaneval()
