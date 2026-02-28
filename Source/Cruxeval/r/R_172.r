f <- function(array) {    for (i in seq_along(array)) {
        if (array[i] < 0) {
            array <- array[-i]
        }
    }
    array
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c()), c())))
}
test_humaneval()
