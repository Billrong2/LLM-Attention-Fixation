f <- function(array) {    output <- c(array)
    output[c(TRUE, FALSE)] <- rev(array[c(FALSE, TRUE)])
    rev(output)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c()), c())))
}
test_humaneval()
