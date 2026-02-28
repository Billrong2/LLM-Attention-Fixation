f <- function(arr) {    n <- arr[arr %% 2 == 0]
    m <- c(n, arr)
    for (i in m) {
        if (match(i, m) > length(n)) {
            m <- m[m != i]
        }
    }
    return(m)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(3, 6, 4, -2, 5)), c(6, 4, -2, 6, 4, -2))))
}
test_humaneval()
