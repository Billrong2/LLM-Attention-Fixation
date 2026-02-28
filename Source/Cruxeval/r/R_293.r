f <- function(text) {    s <- tolower(text)
    for (i in 1:nchar(s)) {
        if (substr(s, i, i) == 'x') {
            return('no')
        }
    }
    return(isTRUE(toupper(text) == text))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('dEXE'), 'no')))
}
test_humaneval()
