f <- function(s1, s2) {    if (substring(s2, nchar(s2) - nchar(s1) + 1, nchar(s2)) == s1) {
        s2 <- substr(s2, 1, nchar(s2) - nchar(s1))
    }
    return(s2)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('he', 'hello'), 'hello')))
}
test_humaneval()
