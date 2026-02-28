f <- function(text, suffix) {    if (substring(text, nchar(text) - nchar(suffix) + 1, nchar(text)) == suffix) {
        return(substring(text, 1, nchar(text) - nchar(suffix)))
    } else {
        return(text)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('zejrohaj', 'owc'), 'zejrohaj')))
}
test_humaneval()
