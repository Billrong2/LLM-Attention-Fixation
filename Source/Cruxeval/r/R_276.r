f <- function(a) {    if (length(a) >= 2 && a[1] > 0 && a[2] > 0) {
        a <- rev(a)
        return(a)
    } else {
        a[length(a) + 1] <- 0
        return(a)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c()), c(0))))
}
test_humaneval()
