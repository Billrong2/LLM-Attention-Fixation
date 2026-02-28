f <- function(text, sub) {    a <- 0
    b <- nchar(text) - 1

    while (a <= b) {
        c <- (a + b) %/% 2
        if (regexpr(sub, text, fixed = TRUE) > c) {
            a <- c + 1
        } else {
            b <- c - 1
        }
    }

    return(a)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('dorfunctions', '2'), 0)))
}
test_humaneval()
