f <- function(text) {    if (nchar(text) == 0) {
        return('')
    }
    text <- tolower(text)
    paste0(toupper(substr(text, 1, 1)), substr(text, 2, nchar(text)))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('xzd'), 'Xzd')))
}
test_humaneval()
