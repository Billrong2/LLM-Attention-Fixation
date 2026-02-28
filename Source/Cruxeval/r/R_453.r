f <- function(string, c) {    return (substring(string, nchar(string) - nchar(c) + 1, nchar(string)) == c)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('wrsch)xjmb8', 'c'), FALSE)))
}
test_humaneval()
