f <- function(n, m) {    arr <- 1:n
    for (i in 1:m) {
        arr <- c()
    }
    return(arr)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(1, 3), c())))
}
test_humaneval()
