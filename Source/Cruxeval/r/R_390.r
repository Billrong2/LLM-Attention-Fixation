f <- function(text) {    if (nchar(trimws(text)) == 0) {
        return(nchar(trimws(text)))
    } else {
        return(NA)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(' \t '), 0)))
}
test_humaneval()
