f <- function(array) {    return_arr <- lapply(array, function(a) {a})
    return(return_arr)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list(c(1, 2, 3), c(), c(1, 2, 3))), list(c(1, 2, 3), c(), c(1, 2, 3)))))
}
test_humaneval()
