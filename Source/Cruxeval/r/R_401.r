f <- function(text, suffix) {    if (nchar(suffix) > 0 && substr(text, nchar(text) - nchar(suffix) + 1, nchar(text)) == suffix) {
        substr(text, 1, nchar(text) - nchar(suffix))
    } else {
        text
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('mathematics', 'example'), 'mathematics')))
}
test_humaneval()
