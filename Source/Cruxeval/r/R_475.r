f <- function(array, index) {
    if (index < 0) {
        index <- length(array) + index
    }
    array[index + 1]
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1), 0), 1)))
}
test_humaneval()
