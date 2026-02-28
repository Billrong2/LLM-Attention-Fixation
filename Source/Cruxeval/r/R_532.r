f <- function(n, array) {    final <- list(array)
    for (i in 1:n) {
        arr <- array
        arr <- c(arr, final[[length(final)]])
        final <- c(final, list(arr))
    }
    return(final)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(1, c(1, 2, 3)), list(c(1, 2, 3), c(1, 2, 3, 1, 2, 3)))))
}
test_humaneval()
