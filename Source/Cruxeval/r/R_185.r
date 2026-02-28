f <- function(L) {    N <- length(L)
    for (k in 1:(N %/% 2)) {
        i <- k
        j <- N - k + 1
        while (i < j) {
            temp <- L[i]
            L[i] <- L[j]
            L[j] <- temp
            i <- i + 1
            j <- j - 1
        }
    }
    return(L)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(16, 14, 12, 7, 9, 11)), c(11, 14, 7, 12, 9, 16))))
}
test_humaneval()
