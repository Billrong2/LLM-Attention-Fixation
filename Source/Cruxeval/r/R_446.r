f <- function(array) {    l <- length(array)
    if (l %% 2 == 0) {
        array <- c()
    } else {
        array <- rev(array)
    }
    return(array)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c()), c())))
}
test_humaneval()
