f <- function(array) {    array <- rev(array)
    a <- c()
    for (i in seq_along(array)) {
        if (array[i] != 0) {
            a <- c(a, array[i])
        }
    }
    rev(a)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c()), c())))
}
test_humaneval()
