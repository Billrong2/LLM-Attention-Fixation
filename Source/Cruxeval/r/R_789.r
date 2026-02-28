f <- function(text, n) {    if (n < 0 || n >= nchar(text)) {
        return(text)
    }
    result <- substr(text, 1, n)
    i <- nchar(result)
    while (i >= 1) {
        if (substr(result, i, i) != substr(text, i, i)) {
            break
        }
        i <- i - 1
    }
    return(substr(text, 1, i))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('bR', -1), 'bR')))
}
test_humaneval()
