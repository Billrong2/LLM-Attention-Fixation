f <- function(array, lst) {    array <- c(array, lst)
    array[array %% 2 == 0]
    array[array >= 10]
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(2, 15), c(15, 1)), c(15, 15))))
}
test_humaneval()
