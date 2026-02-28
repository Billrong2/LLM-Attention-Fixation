f <- function(text, suffix) {    if (substring(text, nchar(text) - nchar(suffix) + 1) == suffix) {
        text <- paste0(substring(text, 1, nchar(text) - 1), toupper(substring(text, nchar(text), nchar(text))))
    }
    text
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('damdrodm', 'm'), 'damdrodM')))
}
test_humaneval()
