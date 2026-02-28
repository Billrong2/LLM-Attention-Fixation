f <- function(text, pref) {    length <- nchar(pref)
    if (pref == substr(text, 1, length)) {
        return(substr(text, length+1, nchar(text)))
    }
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('kumwwfv', 'k'), 'umwwfv')))
}
test_humaneval()
