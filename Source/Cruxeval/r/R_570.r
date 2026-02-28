f <- function(array, index, value) {    array <- c(index + 1, array)
    if (value >= 1) {
        array <- c(head(array, index), value, tail(array, length(array) - index))
    }
    return(array)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(2), 0, 2), c(2, 1, 2))))
}
test_humaneval()
