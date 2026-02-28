f <- function(s, suffix) {    if (suffix == "") {
        return(s)
    }
    while (substring(s, nchar(s) - nchar(suffix) + 1) == suffix) {
        s <- substr(s, 1, nchar(s) - nchar(suffix))
    }
    return(s)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('ababa', 'ab'), 'ababa')))
}
test_humaneval()
