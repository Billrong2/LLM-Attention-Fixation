f <- function(digits) {    digits <- rev(digits)
    if (length(digits) < 2) {
        return(digits)
    }
    for (i in seq(1, length(digits), by = 2)) {
        temp <- digits[i]
        digits[i] <- digits[i+1]
        digits[i+1] <- temp
    }
    return(digits)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 2)), c(1, 2))))
}
test_humaneval()
