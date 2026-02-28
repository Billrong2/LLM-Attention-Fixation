f <- function(single_digit) {    result <- numeric()
    for (c in 1:10) {
        if (c != single_digit) {
            result <- c(result, c)
        }
    }
    return(result)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(5), c(1, 2, 3, 4, 6, 7, 8, 9, 10))))
}
test_humaneval()
